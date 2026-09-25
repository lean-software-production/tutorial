# Iterations

| Iteration | Spec |
|---|---|
| 001 | [Basic unvalidated loop](001-basic-unvalidated-loop/README.md) |
| 002 | [Checking the work](002-checking-the-work/README.md) |
| 003 | [The assembly line](003-assembly-line/README.md) |
| 004 | [Jobs and targets](004-jobs-and-targets/README.md) |
| 005 | [Fan out](005-fan-out/README.md) |
| 006 | [Watching](006-watching/README.md) |
| 007 | [Steering](007-steering/README.md) |
| 008 | [Skills](008-skills/README.md) |

Your progress is kept in your starter repo (`tetris/.factory/ITERATION`),
not here. `fetch-iteration` works through these in order.

## Spec structure

Each iteration folder holds the whole spec at that point, not just what's new:

- `README.md` — the homework framing: what's changing, what to watch for, and the CLI commands you should end up with.
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
