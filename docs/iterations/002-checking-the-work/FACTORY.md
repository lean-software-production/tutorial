# The factory, as of this iteration

The factory builds software from a seed. It plans the work, then makes
it one task at a time: a doer produces the work and a validator checks
it, until the plan is done. A validator only reports. The doer records
each finding as a subtask of the task it is on, and tries again.

Each run is for a **job**, named on the command line. A job is started
with a seed and a target — the codebase it builds, its own git
repository — and remembers both, so after that its name is enough. The
seed is the only input to the work; the name and the target tell the
factory where to keep the job's plan (`jobs/<name>/`, never in the
target) and where to build.

There are two ways to run it. Running one pass takes one task from
start to checked and stops. Running to completion keeps going until the
plan is done. The examples say which they mean.

New since iteration 1: `validation.feature`, and two rules in
`orchestration.feature` — a pass now ends on validation, and gives up
after a set number of attempts.
