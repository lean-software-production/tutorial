# Homework 1 — Basic unvalidated loop

*Set after day 1, following the Ralph loop demo.*

Build a **Ralph loop**: a small program (your "factory") that turns a seed
into a plan, then works the plan one task at a time, driving a coding
agent to do the real work. By the end, running your factory enough times
builds a real, playable game of Tetris in the terminal. Nothing in this
homework is a mock or a placeholder.

## What you're building

Each run of the factory is for a **job**. You name the job, and the first
time you run it you give it a seed (what to build) and a target (the git
repository to build it in — kept separate from your factory's own repo).
The job remembers both; after that, its name is enough. On each pass, the factory:

1. Reads the seed — the `spec.md` in this folder is the sample (it says:
   build Tetris in the terminal, started with `npm start`, fitting inside
   24 rows).
2. If the job has no `plan.md` yet, writes it in the job's folder,
   `jobs/<name>/`: the spec broken into a few tasks. If it does, leaves it
   alone.
3. Picks the first not-done task and hands it to a coding agent, which
   implements *that task* in real code, in the target.
4. Marks the task done in `plan.md` and commits the work to the target.

The seed and the plan live in files, not in your code. Each pass is
stateless: it reads the files, does one thing, writes the files back. The
rules below pin down the rest.

## The commands you'll end up with

The exact command name is your choice. This is the shape of what should
work by the end, using `./factory` as a stand-in:

```sh
# first run — a new job, no plan yet, so the factory plans instead of building
$ ./factory --job tetris --seed spec.md --target ../targets/tetris
created jobs/tetris/plan.md (4 tasks) from spec.md

# next run — the job remembers its seed and target; one pass, one task,
# one commit in the target
$ ./factory --job tetris
task 1 done: set up the project
$ git -C ../targets/tetris log --oneline
# one new commit

# run to completion
$ ./factory --job tetris --all
task 2 done: ...
task 3 done: ...
task 4 done: ...
factory stopped — plan complete

# swap the agent for a run — here a stand-in, for a quick check
$ ./factory --job scratch --seed spec.md --target ../targets/scratch --agent ../tutorial/stand-ins/plan-alpha-beta
created jobs/scratch/plan.md (2 tasks) from spec.md

# the payoff: a real, playable Tetris
$ cd ../targets/tetris && npm start
```

Your task names and count will differ; the point is that real code appears
in the target, one task per pass, and `npm start` runs Tetris.

Once it works, start a second job with a different seed and a new target —
the factory should build whatever the new seed describes, without
disturbing the first job.

## Rules

The [ground rules](../README.md#ground-rules) apply, as they do to every
homework. It doesn't have to be a bash loop, and we'd rather it weren't.

**Hint: keep it small.** All the intelligence is in the agent and the
files; the factory is a short loop around one agent call. The reference
version is a few lines, and the language is irrelevant:

```text
if the job has no plan:  ask the agent to write one from the seed
otherwise:               hand the next task to the agent, in the target
                         mark the task done, commit
```

You will keep this. The next homework adds checking the work: the factory
starts noticing when the agent's output is wrong.
