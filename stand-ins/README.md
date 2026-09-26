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

If `$STAND_IN_LOG` is set, each stand-in appends its name to that file
when it is called. That is how a check counts calls and sees their order.
If `$STAND_IN_RECORD` is set, each stand-in also appends its name and
everything it was given, so a check can see what the factory handed it.

The factory never reads the plan; the agents keep it. The stand-ins that
keep a plan find it by the first path ending in `plan.md` that their
prompt names, and keep it as one task per line, `- [ ] name` or
`- [x] name`. They do a task by writing a file with the task's name in
the current directory.

Two answers mean something to the factory, from a stand-in or from a real
agent:

- `PLAN COMPLETE` — from whoever keeps the plan: no task is left.
- `NOT SATISFIED` — from validation: the work is not good enough yet.

| Stand-in | What it does |
|---|---|
| `ralph-alpha-beta` | A whole Ralph loop's agent in one call. With no plan, writes one: `alpha`, then `beta`. Otherwise does the first task not ticked and ticks it, or answers `PLAN COMPLETE` when none is left. |
| `plan-alpha-beta` | A planner. With no plan, writes one: `alpha`, then `beta`. With a plan, ticks every task whose work is committed, and answers `PLAN COMPLETE` when none is left. |
| `do-next` | A doer. Does the first task not ticked, and answers with its name. Never touches the plan. |
| `plan-in-prose` | Keeps its plan in prose that no factory could parse, and plays any part: writes the plan, builds whichever of `alpha` and `beta` is not committed yet, and answers `PLAN COMPLETE` once both are. |
| `always-satisfied` | Answers `SATISFIED`, whatever it is asked to check. |
| `not-satisfied-once` | Answers `NOT SATISFIED`, with a reason, the first time it is called, and `SATISFIED` every time after. It remembers in `$STAND_IN_STATE` (default `${TMPDIR:-/tmp}/stand-in-state`). |
| `never-satisfied` | Answers `NOT SATISFIED`, with a reason, whatever it is asked to check. |
| `write-sentinel` | Writes a file called `SENTINEL` in the current directory, and nothing else. |
| `record-input` | Records everything it was given, to `$STAND_IN_RECORD` (default `${TMPDIR:-/tmp}/stand-in-record.txt`), then does nothing. |

For "Without an agent, nothing is built", point your factory at a path
where no agent exists.
