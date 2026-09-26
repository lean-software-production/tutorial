# The factory, as of this iteration

*A summary. The feature files in `features/` are the spec; where the two
disagree, the features win.*

The factory builds software from a seed, one task at a time. A planner
keeps the plan, a doer does each task and a validator checks it. The
validator only reports; the doer records each finding and tries again,
and the pass gives up after a set number of attempts. Once the work is
committed, the planner marks the task done, and it says when the plan is
complete.

The factory writes no project code, no plan and no verdict itself, and
never reads the plan. Coding agents do — `pi` by default, or others
chosen for the run.

The factory sits in a folder of its own inside the codebase it builds,
and builds in the folder around it. Its seed, saying what to build, is
`seeds/tetris.md` in the codebase. It keeps its one plan in its own
folder.

New since iteration 1: `validation.feature`; passes that end on
validation; and a planner, which takes the plan over from the one agent.
