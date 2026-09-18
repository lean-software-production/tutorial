# Homework 1 — Basic unvalidated loop

*Set after day 1, following the Ralph loop demo.*

Build a **Ralph loop**: a small program (your "factory") that turns a seed
into a plan, then works the plan one task at a time, driving a coding
agent to do the real work. By the end, running your factory enough times
builds a real, playable game of Tetris in the terminal. Nothing in this
homework is a mock or a placeholder.

## What you're building

On each pass, the factory:

1. Reads the seed — the `spec.md` in this folder (it says: build Tetris in
   the terminal, started with `npm start`, fitting inside 24 rows).
2. If `plan.md` doesn't exist yet, writes it: the spec broken into a few
   tasks. If it does exist, leaves it alone.
3. Picks the first not-done task and hands it to a coding agent, which
   implements *that task* in real code.
4. Marks the task done in `plan.md` and commits the work.

The seed and the plan live in files, not in your code. Each pass is
stateless: it reads the files, does one thing, writes the files back. Read
the ADRs in `adr/` — they pin down these decisions.

## The commands you'll end up with

The exact command name is your choice. This is the shape of what should
work by the end, using `./factory` as a stand-in:

```sh
# first run — no plan yet, so the factory plans instead of building
$ ./factory
created plan.md (4 tasks) from spec.md

# next run — one pass, one task, one commit
$ ./factory
task 1 done: set up the project
$ git log --oneline
# one new commit

# run to completion
$ ./factory --all
task 2 done: ...
task 3 done: ...
task 4 done: ...
factory stopped — plan complete

# the payoff: a real, playable Tetris
$ npm start
```

Your task names and count will differ; the point is that real code appears
in the working directory, one task per pass, and `npm start` runs Tetris.

Once it works, change the seed (point at a different `spec.md`) and run it
again — the factory should build whatever the new seed describes.

## Rules

- How you build it is up to you. It doesn't have to be a bash loop, and
  we'd rather it weren't. The behaviour in `features/` is the spec.
- The factory drives the agent; it does not fake the work. No placeholder
  files, no hard-coded plan.
- Keep it small. The reference version is a few lines of loop.

You will keep this. The next homework adds checking the work: the factory
starts noticing when the agent's output is wrong.
