# Iterations

| Iteration | Spec | Set after |
|---|---|---|
| 001 | [Basic unvalidated loop](001-basic-unvalidated-loop/README.md) | Day 1 |
| 002 | [Checking the work](002-checking-the-work/README.md) | Day 2 |
| 003 | [The assembly line](003-assembly-line/README.md) | Day 3 |
| 004 | [Fan out](004-fan-out/README.md) | Day 3 |
| 005 | [Watching](005-watching/README.md) | Day 4 |
| 006 | [Steering](006-steering/README.md) | Day 4 |
| 007 | [Skills](007-skills/README.md) | Day 5 |

Your progress is kept in your own factory repo (`spec/ITERATION`), not
here. Coaching works through these in order.

## Spec structure

Each iteration folder holds the whole spec at that point, not just what's new:

- `README.md` — the homework framing: what day it was set, what's changing, what to watch for, and the CLI commands you should end up with.
- `FACTORY.md` — a short summary of the factory at this point. The features win where they disagree.
- `spec.md` — the seed: the project the factory builds (when there is one).
- `features/*.feature` — the acceptance criteria, in Gherkin.

## Ground rules

These hold for every homework.

- The behaviour in `features/` is the spec. How you build it — language,
  shape, libraries — is up to you.
- Your factory drives a real coding agent, and the agent does the work:
  the plans, the code and the verdicts. `pi` is the default; any coding
  agent will do. The factory writes none of the work itself and fakes
  none of it — `agent.feature` is how that is checked, with the stand-ins
  in [`stand-ins/`](../../stand-ins/README.md).
