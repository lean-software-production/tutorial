# The factory, as of this iteration

The factory builds software from a seed, one task at a time, without
anyone checking the work. Nothing validates the output, nothing feeds
findings back, and nothing decides the work was wrong. That comes later.

Each run of the factory is for a **job**, named on the command line. A
job is started with a seed and a target, and remembers both, so after
that its name is enough. The seed is a file, `spec.md`, describing a
game of Tetris for the terminal; it is the only input to the work. The
target is the codebase the job builds: its own git repository, holding
only the product. If the target isn't a git repository yet, it becomes
one, with a starting commit. The job's name and target are for the
factory — where to keep things and where to build — not for the work.

On its first pass the factory reads the seed and writes a plan,
`plan.md`, breaking the spec into a small number of tasks. The plan lives
with the factory, in the job's folder (`jobs/<name>/`), not in the
target. On every pass
after that, the factory finds the first task not yet done and hands it to
a coding agent, which implements that one task in real code. The factory
then marks the task done in `plan.md` and commits the work.

The seed and the plan live in files. The factory holds nothing in its own
code or memory between passes: each pass reads the files, does one thing,
and writes them back. Naming the same job again picks it up where it
stopped; naming a new one starts afresh, with its own plan and its own
target. The factory itself does not write the project — the
agent does.

There are two ways to run it. Running one pass does a single task (or, on
the first run, creates the plan) and stops. Running to completion keeps
going until the plan is done. The examples say which they mean.

The feature files in `features/` are the whole spec. Nothing checks the
work yet.
