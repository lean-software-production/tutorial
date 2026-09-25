# The factory, as of this iteration

*A summary. The feature files in `features/` are the spec; where the two
disagree, the features win.*

The factory builds software from a seed, one task at a time. It asks
the agent to turn the seed into a plan, then hands it one task per pass,
marking each done and committing it to the codebase. Nothing checks the
work yet.

The factory writes no project code and no plan itself. A coding agent
does — `pi` by default, or another chosen for the run.

The factory sits in a folder of its own inside the codebase it builds,
and builds in the folder around it. Its seed, saying what to build, is
`seeds/tetris.md` in the codebase. It keeps its one plan in its own
folder.

Running one pass does one task, or writes the plan. Running to
completion keeps going until the plan is done.
