# Agent instructions

This repo holds the course's iterations (`docs/iterations/`) and stand-in
agents (`stand-ins/`). Students don't work here: they work in their copy of
[capstone-project-starter](https://github.com/lean-software-production/capstone-project-starter),
whose `fetch-iteration` skill downloads each iteration from this repo's
`main` branch on GitHub.

The feature files are the students' test suite, and their step
definitions carry over between iterations. When you change a feature,
use the steps in `docs/iterations/STEPS.md` (add a new one there first)
and run `bin/step-drift` to check that each iteration's steps differ
from the last only where the meaning changed. Every example not tagged
`@real-agent` must run with the stand-ins alone.
