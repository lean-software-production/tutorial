# The factory, as of this iteration

*A summary. The feature files in `features/` are the spec; where the two
disagree, the features win.*

The factory builds software from a seed. A planner writes the plan, then
a doer makes it one task at a time and the three big brains checks each
attempt. Once a task's work is committed, the planner marks it done, and
it says when the plan is complete.

The factory writes none of its machines' work itself, and never reads
the plan. A machine has a name and a harness that runs it: `pi` by
default, or another named in the machine's configuration. Each machine
answers with a result: JSON describing the job it did.

The route through the machines is an **assembly line**: a graph the
factory reads before it does any work. An edge only routes: its label
names a field of the result of the machine it leaves. The planner
decides whether there is more to do; the line holds the loop back to it
and the retry after failed validation, and the factory limits how many
attempts a task gets. Lines live in the target, in `.assembly-lines/`,
with the machines they name each in a folder of its own in
`.assembly-lines/.machines/`. A target can hold several lines, and every
line in it that names the doer runs the same doer. A line never names a
target.

Validation is done by the **three big brains**, one machine on the line:
three reviewers on different providers' models report on each attempt,
and a synthesiser reads their reports and decides.

Each run is for a **job**: one of the target's assembly lines, a seed,
saying what to build, and a target, the codebase to build it in. The
factory has a codebase of its own, outside any target. The job keeps its
plan with the factory, never in the target.

New since iteration 4: the three big brains replaces the validator.
