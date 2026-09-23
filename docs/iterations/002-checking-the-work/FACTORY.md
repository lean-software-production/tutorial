# The factory, as of this iteration

The factory builds software from a seed. It plans the work, then makes
it one task at a time: a doer produces the work and a validator checks
it, until the plan is done. A validator only reports. The doer records
each finding as a subtask of the task it is on, and tries again.

The factory itself writes no project code, no plan and no verdict. All
three come from a coding agent — an LLM-driven tool such as `pi`, the
default — that the factory calls. Another agent can be chosen on the
command line for a run, and the validator's agent separately, including
the course's stand-ins for quick checks (see `agent.feature`).

Each run is for a **job**, named on the command line. A job is started
with a seed and a target — the codebase it builds, its own git
repository — and remembers both, so after that its name is enough. The
seed is the only input to the work; the name and the target tell the
factory where to keep the job's plan (`jobs/<name>/`, never in the
target) and where to build. The factory can be told to keep its jobs in
another folder instead, as its tests do.

There are two ways to run it. Running one pass takes one task from
start to checked and stops. Running to completion keeps going until the
plan is done. The examples say which they mean.

New since iteration 1: `validation.feature`, the validator's agent in
`agent.feature`, and two rules in
`orchestration.feature` — a pass now ends on validation, and gives up
after a set number of attempts.
