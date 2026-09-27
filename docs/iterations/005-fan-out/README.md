# Homework 5 — Fan out

Read `FACTORY.md`, then the feature files in `features/`.

Until now an assembly line has been a single path: one machine, then the
next. This time the line itself learns a new move. A machine with several
edges out and no labels on them **fans out**: every machine those edges
lead to runs, at the same time. The branches **fan in** where they meet:
each branch's one edge leads to the same machine, which runs once all of
them have finished, and is given what each of them answered and nothing
else. The factory refuses a line whose branches do not meet, and a
branch that fails, by crashing or by answering with no result, stops the
job.

That is all the factory learns. What you fan out to is up to the line.
The course's example is **the three big brains**: the doer's work fans
out to three reviewers, the same job on three different providers'
models, and a synthesiser reads their reports and decides.

```dot
doer -> reviewer_1
doer -> reviewer_2
doer -> reviewer_3
reviewer_1 -> synthesiser
reviewer_2 -> synthesiser
reviewer_3 -> synthesiser
synthesiser -> doer     [label="not satisfied"]
synthesiser -> planner  [label="satisfied"]
```

The reviewers being alike is the three big brains' choice, not something
fanning out needs: each branch is run as that machine would be run
anywhere, with its own prompt.

A note on words: the three reviewers assess and report; they do not
decide. The synthesiser decides, and the line routes on its result, as it
did on the validator's.

The examples still run most of the factory on a line with a single
validator, and bring in the three big brains only where a fan out is the
point. Your own target's line is yours: put the three big brains on it
when you want it there.

## Checks that see machines at work

Some examples need a machine caught part-way through its work: three
reviewers working at the same time, say. Never do that with a wait of a
set length. On a slow machine it is too short, on a fast one it proves
nothing, and either way the check sometimes fails for no reason.

Hold the double instead. It waits for a signal from the check (a file
appearing in the example's folder will do) and goes on only when the
check lets it. To see three reviewers working at once, hold all three
and let them go only once all three have begun. A factory that runs
them one after another never gets there, every time. Have a held double
give up if the example's folder is removed, so none outlives its
example.
