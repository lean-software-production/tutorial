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

## Build a second version

Keep the game you built in homework 1 in `tetris/tetris1/`. Once your
upgraded factory passes this homework's suite, build from the same seed in a
new target, from the repository root:

```sh
$ bin/factory --seed tetris/spec.md --target tetris/tetris2 --all
$ npm --prefix tetris/tetris2 start
```

`bin/factory` links to the entry point you built. The new target gets its
own plan. Commits touch only that target's work, so `git log --
tetris/tetris1` stays unchanged while v2 is built. Running against
`tetris/tetris1` again would find its completed plan and stop; changing the
target gives the upgraded factory fresh work without deleting v1 or changing
the seed.

Open v1 and v2 in separate terminals to compare them:

```sh
$ npm --prefix tetris/tetris1 start
$ npm --prefix tetris/tetris2 start
```

Capture screenshots of both versions for the weekend's Maven submission,
record your validator's lens, and look for a finding that caused the doer to
change the code. Explain that change alongside the screenshots: a lens such
as testability may improve the code without changing how the game looks.
Generation also varies between runs, so use the validator's findings and the
resulting code as evidence of what validation changed.
