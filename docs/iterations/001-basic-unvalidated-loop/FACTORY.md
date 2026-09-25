# The factory, as of this iteration

*A summary. The feature files in `features/` are the spec; where the two
disagree, the features win.*

The factory builds software from a seed, one task at a time. It asks
the agent to turn the seed into a plan, then hands it one task per pass,
marking each done and committing it to the target. Nothing checks the
work yet.

The factory writes no project code and no plan itself. A coding agent
does — `pi` by default, or another chosen for the run.

Each run is for a **job**: a seed, saying what to build, and a target,
the folder to build it in. The job keeps its plan with the
factory, never in the target.

Running one pass does one task, or writes the plan. Running to
completion keeps going until the plan is done.
