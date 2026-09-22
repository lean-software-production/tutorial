# The factory, as of this iteration

The factory builds software from a seed. A planner writes the plan, then
a doer makes it one task at a time and the three big brains checks each
attempt, until the plan is complete. You can watch what every machine
generates and what it spends, live or afterwards.

Each run is for a **job**, named on the command line. A job is started
with an assembly line, a seed and a target — the codebase it builds, its
own git repository — and remembers all three, so after that its name is
enough. The seed is the assembly line's only input; the name and the
target are for the orchestrator, telling it where to keep the job's
plan and its record (`jobs/<name>/`, never in the target) and where to build. No
machine sees the student's own agent configuration. Stopping the factory
part-way leaves the job in a sane state, and the next run carries on.

New here: you can talk to a machine while it is working. A message names
the machine it is for, reaches it at that machine's next step, and lives
only as long as that machine's run. A message to a machine that is not
running is refused, not held.

Nothing on the assembly line changes, and no machine changes what it is
for. Steering is a way in, not a new stage.

New since part 1: `steering.feature`. Everything else is unchanged.
