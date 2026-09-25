# The factory, as of this iteration

*A summary. The feature files in `features/` are the spec; where the two
disagree, the features win.*

The factory builds software from a seed. A planner writes the plan,
then a doer makes it one task at a time and a validator checks each
attempt, until the plan is complete.

The factory writes none of its machines' work itself. Each machine calls
a coding agent — `pi` by default, or another named in the machine's
configuration.

The route through the machines is an **assembly line**: a graph the
factory reads before it does any work. The line holds the loop over the
plan and the retry after failed validation. The factory has one
assembly line, kept in its own folder.

The factory sits in a folder of its own inside the codebase it builds,
and builds in the folder around it. Its seed, saying what to build, is
`seeds/tetris.md` in the codebase. It keeps its one plan in its own
folder.

New since iteration 2: `assembly-line.feature`. The pass is gone — the
line says what runs next — and each machine's agent is set in its
configuration.
