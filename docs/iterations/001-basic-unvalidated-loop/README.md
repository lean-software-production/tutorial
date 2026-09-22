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

# the payoff: a real, playable Tetris
$ cd ../targets/tetris && npm start
```

Your task names and count will differ; the point is that real code appears
in the target, one task per pass, and `npm start` runs Tetris.

Once it works, start a second job with a different seed and a new target —
the factory should build whatever the new seed describes, without
disturbing the first job.

## Rules

- How you build it is up to you. It doesn't have to be a bash loop, and
  we'd rather it weren't. The behaviour in `features/` is the spec.
- The factory drives a coding agent (we use `pi`), and the agent does the
  work. The factory picks the task, hands it over, records the result and
  commits; it does not write the project itself, and it does not fake the
  work. No placeholder files, no hard-coded plan.
- State lives in files, not in your factory. It holds nothing in memory
  between passes: each pass reads the files, does one thing, and writes
  them back.
- Keep it small. All the intelligence is in the agent and the files; the
  factory is a short loop around one agent call. The reference version is
  a few lines of loop, and the language is irrelevant:

  ```sh
  for pass in 1 2 3 4 5; do
    pi -p < prompt.md
  done
  ```


You will keep this. The next homework adds checking the work: the factory
starts noticing when the agent's output is wrong.
