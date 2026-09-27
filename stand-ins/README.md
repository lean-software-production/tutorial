# Stand-in agents

Small programs that take the place of a real coding agent, so you can see
what your factory hands its agent and what it does with the answer —
fast, and the same for everyone. The examples in `agent.feature` use
them, and any other feature's examples may too. Examples that build real
software need a real agent.

Swap one in the same way you would choose any agent — never build one
into your factory.

## How they behave

They take the same shape of call as `pi` in print mode: the prompt as the
last argument (flags such as `-p` are ignored), or on stdin. They run in
whatever directory your factory runs them in, and their answer is what
they print.

No stand-in waits a set time. The ones that wait — `held`, and
`scripted` at a `wait` step — wait until the check lets them go, by
making the file `go` in `$STAND_IN_STATE`. A check decides when things
move, so no example depends on how fast anything runs. They also give up
if `$STAND_IN_STATE` is removed, so none outlives the check that started
it: let them go, or remove the folder, when the check ends.

If `$STAND_IN_LOG` is set, each stand-in appends its name to that file
when it is called. That is how a check counts calls and sees their order.
If `$STAND_IN_RECORD` is set, it names a folder, and each stand-in writes
everything it was given to a file of its own there, named
`<time>-<stand-in>-<process>`, so a check can see what the factory handed
each call. Stand-ins that run at the same time, like three reviewers,
never share a file.

The factory never reads the plan; the agents keep it. The stand-ins that
keep a plan find it by the first path ending in `plan.md` that their
prompt names, and keep it as one task per line, `- [ ] name` or
`- [x] name`. They do a task by writing a file with the task's name in
the current directory.

Each stand-in answers with a **result**: one line of JSON describing the
job it did. The factory never looks for words in an answer; it reads the
result's fields, and routes on them.

- A plan keeper's result says whether the plan is complete:
  `{"complete": false}`.
- A validator's result says whether it is satisfied, and why not:
  `{"satisfied": false, "findings": ["..."]}`.
- Other results describe the work, and nothing routes on them:
  `{"task": "alpha"}`.

| Stand-in | What it does |
|---|---|
| `ralph-alpha-beta` | A whole Ralph loop's agent in one call. With no plan, writes one: `alpha`, then `beta`. Otherwise does the first task not ticked and ticks it. Result: `{"complete": …}`, plus the task it did. |
| `plan-alpha-beta` | A planner. With no plan, writes one: `alpha`, then `beta`. With a plan, ticks every task whose work is committed. Result: `{"complete": …}`. |
| `do-next` | A doer. Does the first task not ticked, and never touches the plan. Result: `{"task": …}`. |
| `plan-in-prose` | Keeps its plan in prose that no factory could parse, and plays any part: writes the plan, builds whichever of `alpha` and `beta` is not committed yet. Result: `{"complete": …}`, true once both are committed. |
| `rubber-stamp` | A reviewer that approves whatever it is given: `always-satisfied` under a name of its own, so a check can count reviewers apart from the synthesiser. |
| `held` | A reviewer that prints `waiting`, then waits until it is let go, prints anything it heard, and is satisfied. |
| `numbered-report` | A reviewer that is never satisfied, with a numbered finding — `report 1`, `report 2` and so on — so a check can tell reports apart. |
| `scripted` | A doer that follows the steps written in its task, separated by `;`: `say <text>`, `wait`, `read <skill>` (that skill's `SKILL.md`, whose path the prompt names), `run <command>`, and `on attempt <n>: <step>`. After each step it prints anything it heard. Then it does the task. |
| `always-satisfied` | A validator. Result: `{"satisfied": true, "findings": []}`, whatever it is asked to check. |
| `not-satisfied-once` | A validator. Not satisfied, with a finding, the first time it is called; satisfied every time after. It remembers in `$STAND_IN_STATE` (default `${TMPDIR:-/tmp}/stand-in-state`). |
| `never-satisfied` | A validator. Result: `{"satisfied": false, "findings": [...]}`, whatever it is asked to check. |
| `write-sentinel` | Writes a file called `SENTINEL` in the current directory, and nothing else. Result: `{"wrote": "SENTINEL"}`. |
| `record-input` | Records everything it was given, in `$STAND_IN_RECORD` (default `${TMPDIR:-/tmp}/stand-in-record`), then does nothing. Result: `{"recorded": …}`. |
| `unreadable-result` | Writes a file called `UNREADABLE`, then answers in prose, not with a result: nothing a factory can route on. |

For "Without an agent, nothing is built", point your factory at a path
where no agent exists.

## Over ACP

From homework 6 the factory runs each machine as an ACP agent, speaking
the [Agent Client Protocol](https://agentclientprotocol.com) to it over
stdio. `acp/<stand-in>` runs any stand-in that way, the way an adapter
such as `claude-agent-acp` runs a real agent. It needs only Node. For
each `session/prompt` it runs the stand-in with the prompt, and:

- streams each line the stand-in prints as an `agent_message_chunk`;
- answers the prompt with `usage`: the prompt's length as `inputTokens`,
  the answer's as `outputTokens`, so the numbers grow with every attempt;
- passes a `_session/steering` message on to the running stand-in, which
  prints it at its next step as `heard: <message>`, and writes it to a
  file of its own in `$STAND_IN_RECORD`;
- stops the stand-in on `session/cancel`.

Two kinds of line a stand-in prints are requests, not text:

- `@read <path>` becomes a read tool call whose `locations` name the file
  — how the factory sees a skill activated;
- `@run <command>` becomes a call to the `run_command` tool of the first
  MCP server the factory named in `session/new`; what the tool answers is
  printed.

