# Homework 1 — Basic unvalidated loop

Build a **Ralph loop**: a small program (your "factory") that turns a seed
into a plan, then works the plan one task at a time, driving a coding
agent to do the real work. By the end, running your factory enough times
builds a real, playable game of Tetris in the terminal. Nothing in this
homework is a mock or a placeholder.

## What you're building

Your factory lives in `tetris/.factory`, inside the codebase it builds,
and it only ever builds that one: the `tetris/` folder around it. On each
pass, the factory:

1. Reads the seed, `tetris/seeds/tetris.md` — fetch-iteration copies
   the `spec.md` in this folder there (it says: build Tetris in the
   terminal, started with `npm start`, fitting inside 24 rows).
2. If there is no `plan.md` yet, writes it next to the factory: the seed
   broken into a few tasks. If there is one, leaves it alone.
3. Picks the first not-done task and hands it to a coding agent, which
   implements *that task* in real code, in `tetris/`.
4. Marks the task done in `plan.md` and commits the work — but not the
   factory's own folder — to the repository.

The seed and the plan live in files, not in your code. Each pass is
stateless: it reads the files, does one thing, writes the files back. The
rules below pin down the rest.

## The commands you'll end up with

The exact command name is your choice. This is the shape of what should
work by the end, run from `tetris/.factory`, using `./factory` as a
stand-in:

```sh
# first run — no plan yet, so the factory plans instead of building
$ ./factory
created plan.md (4 tasks) from ../seeds/tetris.md

# next run — one pass, one task, one commit
$ ./factory
task 1 done: set up the project
$ git -C .. log --oneline
# one new commit

# run to completion
$ ./factory --all
task 2 done: ...
task 3 done: ...
task 4 done: ...
factory stopped — plan complete

# the payoff: a real, playable Tetris
$ cd .. && npm start
```

Your task names and count will differ; the point is that real code appears
in `tetris/`, one task per pass, and `npm start` runs Tetris.

To try a stand-in agent, do what the checks do: make a new git
repository, copy the factory into a folder of its own inside it, put a
seed at `seeds/tetris.md`, and run the copy there. That way the stand-in
never touches your Tetris.

## Rules

The [ground rules](../README.md#ground-rules) apply, as they do to every
homework. It doesn't have to be a bash loop, and we'd rather it weren't.

**Hint: keep it small.** All the intelligence is in the agent and the
files; the factory is a short loop around one agent call. The reference
version is a few lines, and the language is irrelevant:

```text
if there is no plan:     ask the agent to write one from the seed
otherwise:               hand the next task to the agent, in the codebase
                         mark the task done, commit
```

You will keep this. The next homework adds checking the work: the factory
starts noticing when the agent's output is wrong.
