#!/usr/bin/env node
// Runs a stand-in as an ACP agent (https://agentclientprotocol.com), the
// way an adapter such as claude-agent-acp runs a real agent. Every other
// file in this folder runs this one for the stand-in of the same name, in
// the folder above: `acp/do-next` is do-next, over ACP.
//
// It speaks JSON-RPC over stdio, one message per line, and needs nothing
// but Node. For each session/prompt it runs the stand-in with the prompt,
// and streams what the stand-in prints as agent_message_chunk updates.
// Two kinds of line are requests instead:
//
//   @read <path>   reported as a read tool call, with the path in its
//                  locations, so the client can see what was read
//   @run <command> sent to the run_command tool of the first MCP server
//                  the client gave session/new, and reported as an
//                  execute tool call; what the tool answers is printed
//
// The turn ends with the stand-in. Its PromptResponse carries usage: the
// prompt's length in, the answer's length out. _session/steering, as
// claude-agent-acp and codex-acp accept it, passes a message to the running
// stand-in, which prints it at its next step; session/cancel stops it.

import { spawn } from 'node:child_process';
import { appendFileSync, mkdirSync, mkdtempSync, writeFileSync } from 'node:fs';
import { createInterface } from 'node:readline';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const name = process.argv[2];
const standIn = path.join(path.dirname(path.dirname(fileURLToPath(import.meta.url))), name);
const sessions = new Map();
let nextId = 1;

const send = (msg) => process.stdout.write(JSON.stringify({ jsonrpc: '2.0', ...msg }) + '\n');
const update = (sessionId, u) => send({ method: 'session/update', params: { sessionId, update: u } });
const say = (sessionId, text) => update(sessionId, { sessionUpdate: 'agent_message_chunk', content: { type: 'text', text } });
// Like the stand-ins, write to a file of our own in the $STAND_IN_RECORD folder.
const record = (kind, text) => {
  const dir = process.env.STAND_IN_RECORD;
  if (!dir) return;
  mkdirSync(dir, { recursive: true });
  writeFileSync(path.join(dir, `${process.hrtime.bigint()}-${name}-${kind}-${process.pid}`), text);
};

// A minimal MCP client over stdio: initialize, then one tools/call.
async function callTool(server, tool, args) {
  if (!server?.command) return 'no run_command tool was given';
  const child = spawn(server.command, server.args ?? [], {
    env: { ...process.env, ...Object.fromEntries((server.env ?? []).map((e) => [e.name, e.value])) },
    stdio: ['pipe', 'pipe', 'inherit'],
  });
  const replies = new Map();
  createInterface({ input: child.stdout }).on('line', (line) => {
    try { const m = JSON.parse(line); replies.get(m.id)?.(m); } catch {}
  });
  let id = 0;
  const ask = (method, params) => new Promise((resolve) => {
    const n = ++id;
    replies.set(n, resolve);
    child.stdin.write(JSON.stringify({ jsonrpc: '2.0', id: n, method, params }) + '\n');
  });
  await ask('initialize', { protocolVersion: '2025-06-18', capabilities: {}, clientInfo: { name: `stand-in ${name}`, version: '1' } });
  child.stdin.write(JSON.stringify({ jsonrpc: '2.0', method: 'notifications/initialized' }) + '\n');
  const reply = await ask('tools/call', { name: tool, arguments: args });
  child.stdin.end();
  child.kill();
  if (reply.error) return `error: ${reply.error.message}`;
  return (reply.result?.content ?? []).map((c) => c.text ?? '').join('\n');
}

async function prompt(id, { sessionId, prompt: blocks }) {
  const session = sessions.get(sessionId);
  const text = blocks.filter((b) => b.type === 'text').map((b) => b.text).join('\n');
  const inbox = path.join(session.dir, 'inbox');
  writeFileSync(inbox, '');
  const child = spawn(standIn, ['-p', text], {
    cwd: session.cwd,
    env: { ...process.env, STAND_IN_INBOX: inbox },
    stdio: ['ignore', 'pipe', 'inherit'],
  });
  const exited = new Promise((resolve) => child.on('close', resolve));
  session.running = { child, inbox };
  let answer = '';
  let tools = 0;
  const lines = createInterface({ input: child.stdout });
  for await (const line of lines) {
    if (line.startsWith('@read ')) {
      const file = path.resolve(session.cwd, line.slice(6).trim());
      update(sessionId, { sessionUpdate: 'tool_call', toolCallId: `t${++tools}`, title: `Read ${file}`, kind: 'read', status: 'completed', locations: [{ path: file }] });
    } else if (line.startsWith('@run ')) {
      const command = line.slice(5).trim();
      const toolCallId = `t${++tools}`;
      update(sessionId, { sessionUpdate: 'tool_call', toolCallId, title: command, kind: 'execute', status: 'in_progress', rawInput: { command } });
      const out = await callTool(session.mcpServers[0], 'run_command', { command });
      update(sessionId, { sessionUpdate: 'tool_call_update', toolCallId, status: 'completed' });
      answer += `${out}\n`;
      say(sessionId, `${out}\n`);
    } else {
      answer += `${line}\n`;
      say(sessionId, `${line}\n`);
    }
  }
  const code = await exited;
  const cancelled = session.running?.cancelled;
  session.running = null;
  const usage = { inputTokens: text.length, outputTokens: answer.length, totalTokens: text.length + answer.length };
  if (code !== 0 && !cancelled) return send({ id, error: { code: -32603, message: `${name} exited with ${code}` } });
  send({ id, result: { stopReason: cancelled ? 'cancelled' : 'end_turn', usage } });
}

createInterface({ input: process.stdin }).on('line', (line) => {
  let msg;
  try { msg = JSON.parse(line); } catch { return; }
  const { id, method, params } = msg;
  if (method === 'initialize') {
    send({ id, result: { protocolVersion: 1, agentCapabilities: { promptCapabilities: {} }, agentInfo: { name: `stand-in ${name}`, version: '1' }, authMethods: [] } });
  } else if (method === 'session/new') {
    const sessionId = `s${nextId++}`;
    sessions.set(sessionId, { cwd: params.cwd, mcpServers: params.mcpServers ?? [], dir: mkdtempSync(path.join(os.tmpdir(), 'stand-in-')) });
    send({ id, result: { sessionId } });
  } else if (method === 'session/prompt') {
    prompt(id, params).catch((e) => send({ id, error: { code: -32603, message: String(e) } }));
  } else if (method === '_session/steering') {
    const running = sessions.get(params.sessionId)?.running;
    const text = (params.prompt ?? []).filter((b) => b.type === 'text').map((b) => b.text).join('\n');
    if (!running) return send({ id, result: { outcome: 'promptRequired', reason: 'noRunningTurn' } });
    appendFileSync(running.inbox, `${text}\n`);
    record('steered', `${text}\n`);
    send({ id, result: { outcome: 'injected' } });
  } else if (method === 'session/cancel') {
    const running = sessions.get(params.sessionId)?.running;
    if (running) { running.cancelled = true; running.child.kill(); }
  } else if (id !== undefined) {
    send({ id, error: { code: -32601, message: `Method not found: ${method}` } });
  }
});
