# Homework 6 — Watching

Read `FACTORY.md`, then the feature files in `features/`. Together they
are the whole spec of the factory at this point, not just the new parts.

The factory builds the same software it built for homework 5. What is new
is that you can watch it: what every machine generates, and what every
machine costs.

This is where your factory stops being something you run and becomes
something that is running. You start a job and get your terminal back.
Watching is a separate command that attaches to a job in flight. How it
attaches — a socket, a pipe, a file the daemon appends to, an HTTP
endpoint — is yours to choose.

## Your machines speak ACP

Until now each machine was one call: a prompt in, an answer out. To watch
a machine as it works, and see what it spends, the factory now runs each
one as an ACP agent — the [Agent Client
Protocol](https://agentclientprotocol.com), JSON-RPC over the machine's
stdin and stdout — and is itself the ACP client. A machine's harness is
an ACP agent from here on:

- Claude Code: `claude-agent-acp` (npm `@agentclientprotocol/claude-agent-acp`)
- Codex: `codex-acp` (npm `@agentclientprotocol/codex-acp`)
- pi: `pi-rpc-acp`, the small bridge over pi's RPC mode in your starter
  repo

What the factory reads: the `agent_message_chunk` updates, as what the
machine generates; the last line of that text, as its result; and the
`usage` on its `session/prompt` response — `inputTokens` and
`outputTokens` — as what it spent. That usage is still a draft in ACP,
but the Claude Code and Codex adapters send it, and so does the pi
bridge.

## The commands you'll end up with

The exact commands are your choice. This is the shape, with `./factory`
for whatever you call it:

```sh
# start a job — you get your terminal back
$ ./factory --job tetris --target ../tetris --line careful --seed ../tetris/seeds/tetris.md
started job tetris

# attach to it, now or later — catches you up, then follows live
$ ./factory watch tetris
planner    | ...
doer       | ...
tokens     doer 12.4k in / 3.1k out   anthropic 15.5k   google 4.2k   openai 3.9k   job 23.6k

# a second job while one is running is refused
$ ./factory --job snake --target ../snake --line quick --seed ../tetris/seeds/snake.md
refused: job tetris is running

# stop the job (the factory stays up); start it again later by name alone
$ ./factory stop tetris
$ ./factory --job tetris

# stop the factory itself — its job stops with it
$ ./factory stop
```

Before you start, look at what your factory does today. It probably
prints as it goes, and printing is not this: it is gone when the
scrollback is gone, and it belongs to the terminal that started the run.
A record you can attach to late, catch up on, and still read tomorrow is
a different piece of machinery.

## Your doubles speak ACP too

Your test doubles, which used to replace machines, now replace "machines that communicate via ACP".
