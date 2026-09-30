# Homework 2 — Checking the work

Read `FACTORY.md`, then the feature files in `features/`, and make them true
of the factory you built for homework 1. Together they are the whole spec,
not just the new parts: the rules you already satisfied are still there, and
some of them have changed. A pass is no longer one agent call: a planner
keeps the plan, a doer does the work and a validator checks it. Your one
prompt from homework 1 splits in three.

Before you start, pick what your validator should look for. Testability,
single responsibility, usability, internationalisation, security — any lens
will do, and the interesting part is what your factory does with the
findings. Choose one and write it down.

Your doubles now play three machines. A validator's double answers with
whether it is satisfied and, if not, why: the fields `satisfied` and
`findings` that `machine.feature` has your factory ask for.

## Once your suite passes

Keep the game you built in homework 1 in `tetris/tetris1/`. Use your
upgraded factory with a real coding agent to build from the same seed in
a new target. From the repository root:

```sh
bin/factory --seed tetris/spec.md --target tetris/tetris2 --all
git add -- tetris/tetris2/.factory/plan.md
git commit --only -m "Save Tetris 2 plan" -- tetris/tetris2/.factory/plan.md
npm --prefix tetris/tetris2 start
```

Keep this generation's plan in Git as you did for v1. The factory leaves
plans out of its per-task work commits; the separate plan commit preserves
this generation's record without including unrelated staged edits.

The new target gets its own plan. Running against `tetris/tetris1` again
would find its completed plan and stop. Changing the target gives the
upgraded factory fresh work without deleting v1 or changing the seed.

What difference did validation make? **None is a fine answer.** Start by
looking at `tetris/tetris2/.factory/plan.md`: any validator findings are
recorded there as subtasks. Then compare the two games.

Your agent should offer to compare `tetris/tetris1` with `tetris/tetris2`,
summarise what differs, and build an HTML report of the comparison at
`tetris/comparison.html`. Review it together. Two builds from the same seed
can differ anyway; the report should distinguish differences supported by
recorded validator findings from other differences between the generations.
It should also say when there are no recorded findings.

You can play both versions in separate terminals:

```sh
npm --prefix tetris/tetris1 start
npm --prefix tetris/tetris2 start
```

For your Maven submission, include screenshots of both versions, name your
validator's lens, and explain what difference validation made to the code,
if any. Use the plan and comparison report to help explain what you observed.
