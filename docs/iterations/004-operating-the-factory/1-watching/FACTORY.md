# The factory, as of this iteration

The factory builds software from a seed. A planner writes the plan, then
a doer makes it one task at a time and the three big brains checks each
attempt, until the plan is complete.

What changes here is that you can see it work. The factory no longer runs
in front of you: you start a job, it keeps running, and a second command
attaches to it. What that command shows is what every machine generates
and what every machine spends — live, from the start of the job, and
still there after the job has finished, because the factory writes it
down as it goes.

Each run is for a **job**, named on the command line. A job is started
with an assembly line, a seed and a target — the codebase it builds, its
own git repository — and remembers all three, so after that its name is
enough. The seed is the assembly line's only input; the name and the
target are for the orchestrator, telling it where to keep the job's
plan and its record (`jobs/<name>/`, never in the target) and where to build. You can stop a
job, and the factory stays up; or stop the factory, and its job stops
with it. Either way the work in flight is interrupted, nothing
half-finished is marked done or committed, and starting the job again by
name carries on from there.

Tokens are counted for each machine and totalled for each provider,
because the three big brains puts three providers' models on one attempt
and each of them invoices separately.

New since iteration 3: `monitoring.feature` and `observability.feature`,
and new rules in `orchestration.feature` — the factory runs as a daemon,
it runs one job at a time, and a job or the factory can be stopped and
the job started again. A job's record is kept with the job. `planning`, `validation` and
`assembly-line` are unchanged.
