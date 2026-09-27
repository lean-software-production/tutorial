# Steps

Every step in the iterations' feature files, as one vocabulary. A
student's step definitions carry over from one iteration to the next, so
a step's words change only when what it means changes. When an iteration
needs a new step, add it here first. `bin/step-drift` checks every step
against this list, and shows what each iteration adds and drops.

`{string}` is a quoted value, `{word}` a single word. The range says which
iterations use the phrase; "001+" means from 001 on.

Steps say what the machines do, never how a test makes them do it. "The
validator is never satisfied" is the student's to make true, usually with
a small program chosen as the validator's harness: a test double. No
feature mentions one.

No step waits a set time. A machine an example needs to see at work stays
part-way through until a step says it finishes, or the job is run to the
end, and a step that waits for something waits for it to happen, not for
a while.

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

- `the target has the machines planner, doer and validator` — 004. Their configurations, in the latest target's `.assembly-lines/.machines/`.
- `the target has the machines planner, doer and three_big_brains` — 005+. With three_big_brains's reviewers, reviewer_1 to reviewer_3, and its synthesiser, each a machine of its own; three_big_brains's configuration names them.
- `the target has the machine validator` — 005+.
- `the target has an assembly line {string} on which the doer's work is validated` — 004+. The line in `assembly-line.feature`'s Background, in the latest target's `.assembly-lines/`.
- `the target has an assembly line {string} on which the doer goes straight to the planner` — 004+. The same line, without the validator.
- `the {string} line has been copied into the target` — 004+. From the target that has it, into the latest.
- `a job named {string}, on the {string} line, with that seed and target` — 004+. The latest target and its seed; the line is one of that target's. The first job named is the current one.
- `the {string} job has been started` — 004+. It has run once, with all its settings.
- `this assembly line` — 003+. The graph that follows, as the line under test: in the factory's folder through 003, in the latest target from 004.
- `the validator has been taken out, so the doer goes straight to the planner` — 003.
- `the validator has been taken out of the {string} line, so the doer goes straight to the planner` — 004.
- `the three big brains has been taken out of the {string} line, so the doer goes straight to the planner` — 005+.
- `{string} is misspelt {string} throughout the assembly line` — 003+.
- `{string} is misspelt {string} throughout the {string} line` — 004+.
- `the edge from {word} to {word} has been taken out` — 003+.
- `the edges from {word} are labelled {string} and {string}` — 003+. Its two labelled edges, in place of `satisfied` and `not satisfied`.
- `three_big_brains has been replaced by validator throughout the assembly line` — 005+.

### Machines and their harnesses

001 has one agent, "the agent". From 002 the planner, the doer and the
validator are machines, named by those words; from 005, so are the
reviewers and the synthesiser.

What a machine does, in the examples that say. A result has the fields
the line routes on: `complete` for the planner, `satisfied` and
`findings` for a validator or synthesiser, whatever the machine was asked.

- `the agent plans the tasks alpha and beta, and does one task a pass` — 001. With no plan, writes one: `alpha`, then `beta`, and its result says the plan is not complete. Otherwise does the first task not done, marks it done, and says whether the plan is now complete.
- `the {word} plans the tasks alpha and beta` — 002+. The planner. With no plan, writes one: `alpha`, then `beta`. With a plan, marks done every task whose work is committed. Its result says whether the plan is complete.
- `the {word} does the next task in the plan` — 002+. The doer. Does the first task not done, and never touches the plan.
- `the {word} keeps its plan in prose` — 001+. A plan no factory could parse; plays any part: writes the plan, builds whichever of `alpha` and `beta` is not committed yet, and says the plan is complete once both are.
- `the {word} writes a file called SENTINEL` — 001+. And nothing else.
- `the {word} is always satisfied` — 002+. A validator or the synthesiser.
- `every reviewer is always satisfied` — 005+.
- `no reviewer finishes until all three have begun` — 005+. A factory that runs them one after another never finishes the job.
- `the {word} is never satisfied` — 002+. With a finding.
- `the {word} is not satisfied the first time` — 002+. With the finding `not satisfied the first time`; satisfied every time after.
- `every reviewer is not satisfied, with a finding of its own: "report 1", "report 2" or "report 3"` — 005+. Numbered in the order they report.
- `the second reviewer is not satisfied, with the finding {string}` — 005+. reviewer_2 only.
- `the {word} answers in prose, with no result` — 001+. Having done its work: the agent or doer writes a file called `UNREADABLE`.
- `the {word} says {string} before its result` — 001+. A line of prose, then its result.
- `the doer says {string}, then {string}` — 006+. Generates the first line; the second only once the attempt carries on to its end.
- `the doer activates {string}` — 008. Reads that skill's `SKILL.md`.
- `the doer activates {string} and asks to run {string}` — 008. Then asks the factory's `run_command` tool to run the command.
- `the doer activates {string} on its first attempt only, and asks to run {string} on every attempt` — 008.
- `the doer asks to run {string}` — 008. Without activating a skill.
- `the reviewers' lens is {word}` — 005+.
- `the reviewers run on Anthropic, Google and OpenAI models` — 006+. reviewer_1 to reviewer_3's configurations name those providers.
- `the {word} cannot be run` — 001+. Its harness is a path where no program exists.
- `no harness is chosen` — 001–002. pi, for every machine.
- `no harness is chosen for the {word}` — 003+. pi, for that machine.
- `the agent is pi` — 001, `@real-agent`.
- `every machine runs pi` — 002+, `@real-agent`.
- `the validator's lens is {word}` — 002+.

### Limits

- `the factory allows at most three attempts per pass` — 002.
- `the factory allows at most three attempts at a task` — 003+. The orchestrator's limit; the line only routes.

### The plan

Plans in steps are in whatever format the student's machines keep. The
tasks are `first`, `second` and `third`, and a task's work is a file with
its name.

- `no plan` — 001+.
- `a plan with three tasks, none of them done` — 001+.
- `a plan whose first task is done` — 001+.
- `a plan in which every task is done` — 001+.
- `a plan for each job with three tasks of its own, none of them done` — 004+. Each job's tasks are named after the job.
- `a plan with one task, not done` — 005+.
- `a plan with one task, {string}, not done` — 008, `@real-agent`.

### Skills

A skill is `.assembly-lines/.machines/<machine>/skills/<name>/SKILL.md`,
with a name, a description `how to <name>` and instructions that start
`INSTRUCTIONS-<name>`, unless a step says otherwise.

- `the doer has the skills {string} and {string}` — 008.
- `{word} has the skill {string}` — 008.
- `the doer has a skill {string} whose SKILL.md has no description` — 008.
- `the doer has a skill {string} whose instructions say to run {string}` — 008.
- `the doer has the skill {string}, described as writing the test first` — 008, `@real-agent`.
- `the doer has the skill {string}, whose instructions point at {string}` — 008, `@real-agent`.
- `the doer has the skill {string}, which also holds {string} that its instructions never mention` — 008, `@real-agent`.

### The running factory

From 006 the factory is a daemon. These steps start a job and leave it
running, rather than running it to the end.

- `the factory has run the {string} job` — 007+. To the end.
- `the {string} job is running, with the doer part-way through an attempt` — 006+. Started, and the doer has begun an attempt it does not finish until a step says so.
- `the {string} job is running, with the doer part-way through an attempt, having said {string}` — 006+. And the doer has generated that line.
- `the {string} job is running, with every reviewer part-way through` — 006+. All three have begun, and none finishes until a step says so.
- `I am watching the {string} job` — 006+. Following it, from another command, as it goes.
- `I am watching the {string} job as it runs` — 006+. Started, and followed.
- `I have stopped the {string} job` — 006+.

## When

- `the factory runs one pass` — 001–002.
- `the factory runs to completion` — 001–002.
- `the factory runs` — 003.
- `the factory runs the {string} job` — 004+. With all its settings: naming them again is fine.
- `the factory runs the {string} job, given only its name` — 004+.
- `the factory runs the {string} job with that target` — 004+. The latest target, in place of its own.
- `the factory reads the assembly line` — 003+. Checks the line under test without running it.
- `the doer's first attempt at a task is untestable` — 002+, `@real-agent`.
- `the doer activates {string} and follows it` — 008, `@real-agent`.
- `the doer finishes its attempt` — 007+.
- `the reviewers finish` — 007+.
- `I start the {string} job` — 006+. The command returns while the job runs; the doer does not finish its first attempt until a step says so.
- `the {string} job has run to the end` — 006+. Waits until it has.
- `I stop the {string} job` — 006+.
- `I stop the factory` — 006+.
- `I watch the {string} job` — 006+. What the watch command shows now.
- `I read the {string} job's record` — 006+.
- `I say {string} to the doer` — 007+.
- `I say {string} to {word}` — 007+. A machine by name, such as reviewer_2.

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
- `it reports that it could not run the {word}` — 001+. The agent in 001; a machine from 002.
- `it reports that it could not read the {word}'s result` — 001+. Its answer was not a result.
- `it reports that the result of {word} has no field {string}` — 003+. A label on the line names a field the machine's result lacks.
- `it reports that the pass hit its limit` — 002.
- `it reports that a task hit its limit` — 003+.
- `it reports that it has no machine called {string}` — 003+.
- `it reports that finish cannot be reached from {word}` — 003+. Among the machines it names.
- `it says the {string} job already has a target` — 004+.

### Fan out

- `every reviewer has been called once` — 005+.
- `every reviewer was given the same prompt` — 005+.
- `every reviewer was given the work for the {word} task` — 005+.
- `every reviewer was given {string}` — 005+.
- `the synthesiser was given {string}, {string} and {string}` — 005+.
- `it was not given {string}` — 005+.
- `the reviewers' findings are about {word}` — 005+, `@real-agent`.
- `no reviewer or synthesiser has changed the plan or the work` — 005+, `@real-agent`.

### The daemon, watching and the record

What watching and the record show is the student's to lay out; the
steps only need each line of generated text to say which machine it came
from, and the tokens in and out per machine.

- `the command has returned while the {string} job is running` — 006+.
- `the factory is running` — 006+.
- `the factory is not running` — 006+.
- `the {string} job is running` — 006+.
- `the {string} job is not running` — 006+.
- `what I am watching shows that the {string} job was stopped` — 006+.
- `I see {string} from the doer` — 006+. Waits a little for it.
- `I do not see {string}` — 006+.
- `I see {string} from reviewer_1, reviewer_2 and reviewer_3` — 006+.
- `it shows reviewer_1, reviewer_2 and reviewer_3 as running` — 006+.
- `I see what the planner generated` — 006+.
- `it shows what every machine generated` — 006+.
- `it shows what every machine spent` — 006+.
- `the record is in the job's folder in the factory, not in the target` — 006+.
- `it shows tokens in and tokens out for the doer` — 006+.
- `it shows tokens in and tokens out for the three big brains` — 006+. What its reviewers and synthesiser spent.
- `it shows a total for each of Anthropic, Google and OpenAI` — 006+.
- `it shows a total for the whole job` — 006+.
- `what I watched showed the doer's tokens go up` — 006+.
- `what I watched showed the job's total go up` — 006+.

### Steering

A machine "heard" a message when its generated text shows it did, at the
point it heard it.

- `it says that the doer is what is running` — 007+.
- `it says that nothing is running` — 007+.
- `the doer heard {string} before it said {string}` — 007+.
- `{word} heard {string}` — 007+.
- `neither reviewer_1 nor reviewer_3 heard it` — 007+.
- `the doer heard {string} once` — 007+.
- `no reviewer heard {string}` — 007+.
- `it shows that the doer was told {string}` — 007+.

### Skills and commands

- `the {word} was not given {string}` — 008.
- `the doer was given the name and description of {string} and of {string}` — 008.
- `it was given the instructions of neither` — 008.
- `the {string} job's record says the skill {string} was skipped, and why` — 008.
- `it shows that the doer activated {string}` — 008.
- `it does not show that the doer activated {string}` — 008.
- `the factory ran {string} for the doer` — 008.
- `the factory ran {string} for the doer once` — 008.
- `the factory refused {string} for the doer` — 008.
- `the factory refused {string} for the doer once` — 008.
- `the doer was told that no activated skill names it` — 008.
- `the {string} job's record shows the refusal` — 008.
- `the doer activated {string}` — 008, `@real-agent`.
- `the doer did not activate {string}` — 008, `@real-agent`.
- `the doer read {word}` — 008, `@real-agent`.
- `the doer did not read {word}` — 008, `@real-agent`.

### Agents

Counted over the latest run.

- `no agent has been called` — 001+.
- `the agent has been called once` — 001.
- `pi has been called` — 001+.
- `pi has not been called` — 001+.
- `the chosen agent has been called` — 001.
- `the {word}'s chosen harness has been called` — 002+.
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

What a machine (or 001's agent) was given:

- `the {word} was asked for a result with the field {string}` — 001+.
- `the {word} was asked for a result with the fields {string} and {string}` — 002+.
- `every reviewer was asked for a result with the fields {string} and {string}` — 005+.

- `the {word} was pointed at the plan and at the seed` — 001+.
- `the {word} was given the work for the {word} task` — 002+.
- `it was not given the work for the {word} task` — 002+.
- `the {word} was given {string}` — 002+.
- `the {word} was given the validator's findings` — 002+. The findings in the validator's (or from 005 the synthesiser's) result.
- `the validator has changed neither the plan nor the work` — 002+, `@real-agent`.
- `the validator's findings are about {word}` — 002+, `@real-agent`.
