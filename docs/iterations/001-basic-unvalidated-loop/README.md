# Homework 1 — Basic unvalidated loop

Build a **Ralph loop**: a small program (your "factory") that turns a seed
into a plan, then works the plan one task at a time, driving a coding
agent to do the real work. By the end, running your factory enough times
builds a real, playable game of Tetris in the terminal. Nothing in this
homework is a mock or a placeholder.

## What you're building

Your factory lives in `tetris/.factory`, inside the codebase it builds,
and it only ever builds that one: the `tetris/` folder around it. Its
seed is `tetris/seeds/tetris.md` — fetch-iteration copies the `spec.md`
in this folder there (it says: build Tetris in the terminal, started with
`npm start`, fitting inside 24 rows). On each pass, the factory calls a
coding agent, pointing it at the seed and at `plan.md` next to the
factory, and the agent:

1. If there is no plan yet, writes one: the seed broken into a few tasks.
2. Otherwise, picks the first task that isn't done, implements it in real
   code in `tetris/`, and marks it done in the plan.
3. If no task is left, answers `PLAN COMPLETE`.

All of that is in your prompt. The factory never reads the plan: it
commits what the agent did — but not the factory's own folder — and stops
when the agent says the plan is complete.

The seed and the plan live in files, not in your code. Each pass is
stateless: the agent reads the files, does one thing, writes the files
back. The rules below pin down the rest.

## The commands you'll end up with

The exact command name is your choice. This is the shape of what should
work by the end, run from `tetris/.factory`, using `./factory` as a
stand-in:

```sh
# first run — no plan yet, so the agent writes one instead of building
$ ./factory
agent: wrote plan.md — 4 tasks from ../seeds/tetris.md

# next run — one pass, one task, one commit
$ ./factory
agent: set up the project
$ git -C .. log --oneline
# one new commit

# run to completion
$ ./factory --all
agent: ...
agent: ...
agent: ...
agent: PLAN COMPLETE
factory stopped

# the payoff: a real, playable Tetris
$ cd .. && npm start
```

What the agent says will differ; the point is that real code appears in
`tetris/`, one task per pass, and `npm start` runs Tetris.

To try a stand-in agent, do what the checks do: make a new git
repository, copy the factory into a folder of its own inside it, put a
seed at `seeds/tetris.md`, and run the copy there. That way the stand-in
never touches your Tetris.

## Rules

The [ground rules](../README.md#ground-rules) apply, as they do to every
homework. It doesn't have to be a bash loop, and we'd rather it weren't.

**Hint: keep it small.** All the intelligence is in the agent, its
prompt and the files; the factory is a short loop around one agent call.
The reference version is a few lines, and the language is irrelevant:

```text
call the agent: "write the plan, or do the next task and mark it done"
if it answered PLAN COMPLETE: stop
otherwise:                    commit
```

You will keep this. The next homework adds checking the work: the factory
starts noticing when the agent's output is wrong.
