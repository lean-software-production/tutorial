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
3. Answers with a **result**: a line of JSON describing what it did,
   such as `{"complete": false, "task": "set up the project"}`, with
   `"complete": true` once no task is left.

All of that is in your prompt; ask for the result there, or use your
harness's structured output if it has one. Real agents don't always
answer exactly as asked — one may put the JSON in a code fence — so take
the last line of the answer that is JSON. The factory never reads the
plan: it commits what the agent did — but not the factory's own folder —
and stops when the agent's result says the plan is complete. It never
looks for words in what the agent says.

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
{"complete": false}                  # the agent wrote plan.md

# next run — one pass, one task, one commit
$ ./factory
{"complete": false, "task": "set up the project"}
$ git -C .. log --oneline
# one new commit

# run to completion
$ ./factory --all
{"complete": false, "task": "..."}
{"complete": false, "task": "..."}
{"complete": false, "task": "..."}
{"complete": true}
factory stopped

# the payoff: a real, playable Tetris
$ cd .. && npm start
```

What the agent says will differ; the point is that real code appears in
`tetris/`, one task per pass, and `npm start` runs Tetris.

The feature files are your tests, too: start by setting up a Gherkin
runner for them in your factory's language (see the
[ground rules](../README.md#ground-rules)), and build until they pass.
Each example runs against a copy of your factory in a new git
repository, with stand-in agents from `stand-ins/` — so the checks never
touch your Tetris, and never need a real agent. The examples tagged
`@real-agent` are the exception: try those by hand, with pi.

## Rules

The [ground rules](../README.md#ground-rules) apply, as they do to every
homework. It doesn't have to be a bash loop, and we'd rather it weren't.

**Hint: keep it small.** All the intelligence is in the agent, its
prompt and the files; the factory is a short loop around one agent call.
The reference version is a few lines, and the language is irrelevant:

```text
call the agent: "write the plan, or do the next task and mark it done"
if its result says complete:  stop
otherwise:                    commit
```

You will keep this. The next homework adds checking the work: the factory
starts noticing when the agent's output is wrong.
