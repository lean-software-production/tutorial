# Iterations

| Iteration | Spec | Set after | Status |
|---|---|---|---|
| 001 | [Basic unvalidated loop](001-basic-unvalidated-loop/README.md) | Day 1 | Todo |
| 002 | [Checking the work](002-checking-the-work/README.md) | Day 2 | Todo |
| 003.1 | [Real routing — the assembly line](003-real-routing/1-assembly-line/README.md) | Day 3, part 1 | Todo |
| 003.2 | [Real routing — fan out](003-real-routing/2-fan-out/README.md) | Day 3, part 2 | Todo |
| 004.1 | [Operating the factory — watching](004-operating-the-factory/1-watching/README.md) | Day 4, part 1 | Todo |
| 004.2 | [Operating the factory — steering](004-operating-the-factory/2-steering/README.md) | Day 4, part 2 | Todo |
| 005 | [Skills](005-skills/README.md) | Day 5 | Todo |

## Status

- Todo: not started
- WIP: in progress
- Done: complete

## Spec structure

Each iteration folder holds the whole spec at that point, not just what's new:

- `README.md` — the homework framing: what day it was set, what's changing, what to watch for, and the CLI commands you should end up with.
- `FACTORY.md` — the factory's full behaviour at this point, in prose.
- `spec.md` — the seed: the project the factory builds (when there is one).
- `adr/` — the architecture decisions that shape this iteration's factory.
- `features/*.feature` — the acceptance criteria, in Gherkin.
