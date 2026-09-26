# Steps

Every step in the iterations' feature files, as one vocabulary. A
student's step definitions carry over from one iteration to the next, so
a step's words change only when what it means changes. When an iteration
needs a new step, add it here first. `bin/step-drift` checks every step
against this list, and shows what each iteration adds and drops.

`{string}` is a quoted value, `{word}` a single word. The range says which
iterations use the phrase; "001+" means from 001 on.

This file is for authors of the course. `fetch-iteration` does not copy
it to students.

## Given

### The factory, the codebase and the seed

- `a copy of the factory, in a folder of its own inside a new codebase` — 001–003. A new git repository, with the factory copied into a folder inside it.
- `a seed describing a game of Tetris` — 001–003. `seeds/tetris.md` in the codebase, committed.
- `the codebase has no seed` — 001–003.
- `a seed describing Tetris on a board 8 columns wide, started with {string}` — 001+, `@real-agent`.
- `a copy of the factory` — 004+. The factory copied into a new folder of its own, with no jobs.
- `a new target, with a seed describing a game of {word}` — 004+. A new git repository, with the seed in `seeds/`, committed.
- `the seed has been deleted` — 004+. The current job's seed.

### Jobs and lines

- `an assembly line {string} on which the doer's work is validated` — 004+. The line in `assembly-line.feature`'s Background.
- `an assembly line {string} on which the doer goes straight to the planner` — 004+. The same line, without the validator.
- `a job named {string}, on the {string} line, with that seed and target` — 004+. The latest target and its seed. The first job named is the current one.
- `the {string} job has been started` — 004+. It has run once, with all its settings.
- `this assembly line` — 003+. The graph that follows, as the line under test.
- `the validator has been taken out, so the doer goes straight to the planner` — 003.
- `the validator has been taken out of the {string} line, so the doer goes straight to the planner` — 004.
- `the three big brains has been taken out of the {string} line, so the doer goes straight to the planner` — 005+.
- `{string} is misspelt {string} throughout the assembly line` — 003+.
- `{string} is misspelt {string} throughout the {string} line` — 004+.
- `the edge from {word} to {word} has been taken out` — 003+.
- `three_big_brains has been replaced by validator throughout the assembly line` — 005+.

### Agents

- `the agent is the {word} stand-in` — 001. The one agent.
- `the agent is pi` — 001, `@real-agent`.
- `the agent cannot be run` — 001. A path where no program exists.
- `no agent is chosen` — 001–002. pi, for every agent.
- `every agent is pi` — 002+, `@real-agent`.
- `the {word}'s agent is the {word} stand-in` — 002+. planner, doer or validator; from 005, reviewer or synthesiser for the three big brains. Chosen on the command line in 002, and in the machine's configuration from 003.
- `every reviewer's agent is the {word} stand-in` — 005+.
- `the {word}'s agent cannot be run` — 002+.
- `no agent is chosen for the {word}` — 003+. pi, for that machine.
- `the validator's lens is {word}` — 002+.

### Limits

- `the factory allows at most three attempts per pass` — 002.
- `the assembly line's retry edge allows at most three attempts` — 003.
- `the {string} line's retry edge allows at most three attempts` — 004+.

### The plan

Plans in steps use the stand-ins' format: one task per line, `- [ ] name`
or `- [x] name`. The tasks are `first`, `second` and `third`, and a
task's work is a file with its name.

- `no plan` — 001+.
- `a plan with three tasks, none of them done` — 001+.
- `a plan whose first task is done` — 001+.
- `a plan in which every task is done` — 001+.
- `a plan for each job with three tasks, none of them done` — 004+.

## When

- `the factory runs one pass` — 001–002.
- `the factory runs to completion` — 001–002.
- `the factory runs` — 003.
- `the factory runs the {string} job` — 004+. With all its settings: naming them again is fine.
- `the factory runs the {string} job, given only its name` — 004+.
- `the factory runs the {string} job with that target` — 004+. The latest target, in place of its own.
- `the factory reads the assembly line` — 003+. Checks the line under test without running it.
- `the doer's first attempt at a task is untestable` — 002+, `@real-agent`.

## Then

### The plan

- `there is a plan` — 001+.
- `there is no plan` — 001+.
- `the plan shows the first task as done` — 001+.
- `the plan shows the first two tasks as done` — 001+.
- `the plan shows the other two as not done` — 001+.
- `the plan shows every task as done` — 001+.
- `the plan shows every task as not done` — 001+.
- `the plan still has those three tasks` — 001+.
- `the plan has the tasks {string} and {string}, and no others` — 001+.
- `the plan is plan.md in the factory's folder` — 001–003.
- `there is no plan anywhere else in the codebase` — 001–003.
- `the plan is plan.md in the factory's jobs folder, under tetris` — 004+.
- `there is no plan in the target` — 004+.
- `each job has its own plan` — 004+.
- `every task in the plan comes from the seed` — 001+, `@real-agent`.
- `that task has a subtask for the finding` — 002+, `@real-agent`.
- `the plan has no new task` — 002+, `@real-agent`.

### Commits and work

In 001–003 these are about the codebase; from 004, the current job's
target.

- `there is one new commit` — 001+.
- `there are two new commits` — 001+.
- `there are three new commits` — 001+.
- `there are no new commits` — 001+.
- `it contains the work for the {word} task` — 001+. The newest commit holds that task's work and nothing else.
- `it contains SENTINEL and nothing else` — 001+.
- `each new commit contains the work for one task` — 003+.
- `no new commit contains the work for the first task` — 003+.
- `the work for alpha and beta has been committed` — 001+.
- `each target holds only its own job's work` — 004+.
- `Tetris has been built in the codebase` — 001–003, `@real-agent`.
- `Tetris has been built in the target` — 004+, `@real-agent`.
- `{string} in the codebase starts Tetris` — 001–003, `@real-agent`.
- `{string} in the target starts Tetris` — 004+, `@real-agent`.
- `its board is 8 columns wide` — 001+, `@real-agent`.

### The factory

- `the factory has stopped` — 001+.
- `the factory refuses` — 004+.
- `it accepts it` — 003+. The line under test.
- `it refuses it` — 003+.
- `it reports that there is no seed` — 001+.
- `it reports that it could not run the agent` — 001+.
- `it reports that the pass hit its limit` — 002.
- `it reports that a task hit its limit` — 003+.
- `it reports that it has no machine called {string}` — 003+.
- `it reports that finish cannot be reached from {word}` — 003+. Among the machines it names.
- `it says the {string} job already has a target` — 004+.

### Agents

Counted over the latest run, from the stand-ins' `$STAND_IN_LOG`.

- `no agent has been called` — 001+.
- `the agent has been called once` — 001.
- `pi has been called` — 001+.
- `pi has not been called` — 001+.
- `the {word} stand-in has been called` — 001+.
- `the {word} has been called once` — 002+. planner, doer, validator or synthesiser.
- `the {word} has been called twice` — 002+.
- `the {word} has been called three times` — 002+.
- `the {word} has been called four times` — 002+.
- `the {word} has not been called` — 002+.
- `the planner was called before the doer` — 003+.
- `the validator was called for the {string} job` — 004.
- `the validator was not called for the {string} job` — 004.
- `the three big brains was called for the {string} job` — 005+.
- `the three big brains was not called for the {string} job` — 005+.

What an agent was given, from the stand-ins' `$STAND_IN_RECORD`:

- `the agent was pointed at the plan and at the seed` — 001.
- `the {word}'s agent was pointed at the plan and at the seed` — 002+.
- `the {word}'s agent was given the work for the {word} task` — 002+.
- `it was not given the work for the {word} task` — 002+.
- `the {word}'s agent was given {string}` — 002+.
- `the {word}'s agent was given the validator's findings` — 002+.
- `the validator has changed neither the plan nor the work` — 002+, `@real-agent`.
- `the validator's findings are about {word}` — 002+, `@real-agent`.
