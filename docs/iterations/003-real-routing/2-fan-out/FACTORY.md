# The factory, as of this iteration

*A summary. The feature files in `features/` are the spec; where the two
disagree, the features win.*

The factory builds software from a seed. A planner writes the plan,
then a doer makes it one task at a time and the three big brains checks
each attempt, until the plan is complete.

The factory writes none of its machines' work itself. Each machine calls
a coding agent — `pi` by default, or another named in the machine's
configuration.

The route through the machines is an **assembly line**: a graph the
factory reads before it does any work. The line holds the loop over the
plan and the retry after failed validation. A factory can hold several
lines, and a line never names a target.

Validation is done by the **three big brains**, one machine on the
line: three reviewers on different providers' models report on each
attempt, and a synthesiser reads their reports and decides.

Each run is for a **job**: an assembly line, a seed, saying what to
build, and a target, the git repository to build it in. The job keeps
its plan with the factory, never in the target.

New since part 1: the three big brains replaces the validator.
