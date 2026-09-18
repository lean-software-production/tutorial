# The factory, as of this iteration

The factory builds software from a seed, one task at a time, without
anyone checking the work. Nothing validates the output, nothing feeds
findings back, and nothing decides the work was wrong. That comes later.

The seed is a file, `spec.md`, describing a game of Tetris for the
terminal. On its first pass the factory reads the seed and writes a plan,
`plan.md`, breaking the spec into a small number of tasks. It also makes
sure it has somewhere to commit to: if the workspace isn't a git
repository yet, it becomes one, with a starting commit. On every pass
after that, the factory finds the first task not yet done and hands it to
a coding agent, which implements that one task in real code. The factory
then marks the task done in `plan.md` and commits the work.

Every call to the agent runs without the student's own personal config —
only what the factory itself puts in the prompt reaches it. Otherwise an
unrelated setting on the machine running the factory could silently change
what the agent does.

The seed and the plan live in files. The factory holds nothing in its own
code or memory between passes: each pass reads the files, does one thing,
and writes them back. The factory itself does not write the project — the
agent does.

There are two ways to run it. Running one pass does a single task (or, on
the first run, creates the plan) and stops. Running to completion keeps
going until the plan is done. The examples say which they mean.

The feature files in `features/` are the whole spec. Nothing checks the
work yet.
