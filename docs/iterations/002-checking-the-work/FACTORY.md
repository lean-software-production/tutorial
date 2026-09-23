# The factory, as of this iteration

*A summary. The feature files in `features/` are the spec; where the two
disagree, the features win.*

The factory builds software from a seed, one task at a time. A doer
does each task and a validator checks it. The validator only reports;
the doer records each finding and tries again, and the pass gives up
after a set number of attempts.

The factory writes no project code, no plan and no verdict itself. A
coding agent does — `pi` by default, or others chosen for the run.

Each run is for a **job**: a seed, saying what to build, and a target,
the git repository to build it in. The job keeps its plan with the
factory, never in the target.

New since iteration 1: `validation.feature`, and passes that end on
validation.
