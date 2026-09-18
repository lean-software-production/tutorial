# The factory, as of this iteration

The factory builds software from a seed, one task at a time, without
anyone checking the work. Nothing validates the output, nothing feeds
findings back, and nothing decides the work was wrong. That comes later.

The seed is a file, `spec.md`, describing a game of Tetris for the
terminal. On its first pass the factory reads the seed and writes a plan,
`plan.md`, breaking the spec into a small number of tasks. On every pass
after that, the factory finds the first task not yet done and hands it to
a coding agent, which implements that one task in real code. The factory
then marks the task done in `plan.md` and commits the work.

The seed and the plan live in files. The factory holds nothing in its own
code or memory between passes: each pass reads the files, does one thing,
and writes them back. The factory itself does not write the project — the
agent does.

There are two ways to run it. Running one pass does a single task (or, on
the first run, creates the plan) and stops. Running to completion keeps
going until the plan is done. The examples say which they mean.

The feature files in `features/` are the whole spec. Nothing checks the
work yet.
