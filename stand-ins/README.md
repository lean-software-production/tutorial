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

| Stand-in | What it does | Used by |
|---|---|---|
| `write-sentinel` | Writes a file called `SENTINEL` in the current directory, and nothing else. | "The target holds what the agent wrote" |
| `record-input` | Appends everything it was given to `$STAND_IN_RECORD` (default `${TMPDIR:-/tmp}/stand-in-record.txt`), then does nothing. | "The agent is given the task and the seed" |
| `plan-alpha-beta` | Answers with a plan of two tasks, `alpha` and `beta`. If its prompt names a path ending in `plan.md`, it writes the plan there too. | "The plan is what the agent wrote" |
| `never-satisfied` | Answers `NOT SATISFIED`, with a reason, whatever it is asked to check. | "Validation is what the agent decided" (from homework 2) |

For "Without an agent, nothing is built", point your factory at a path
where no agent exists.
