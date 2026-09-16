# Open questions

Homework for days 1 to 4 is specced. From homework 3 the factory runs
along an assembly line and the pass is gone. The live-session
conversation prompts are drafted but weak.

Days are numbered from zero. Day 0 is the introduction and sets the
stage, so the course runs day 0 to day 7. Iteration N is the homework set
after day N.

Things we raised and deliberately did not settle. Not a backlog — each of
these needs a decision from Matt and Aldric, not an implementation.

## Naming

- ~~`build-loop.feature` is misnamed.~~ Settled: one `factory.feature`
  per iteration, holding the whole spec of the factory at that point. We
  could not see a slice better than not slicing.
- ~~The inner step has no name.~~ Settled: **attempt**, and **max
  attempts** for the limit. It names the try at the task rather than the
  machinery — you run a machine, you attempt a task — so it spans the
  doer and the validator.
- **`plan`, `pass`, `run` and `attempt` are not in the lexicon**, and all
  carry weight in the specs. The real decision is whether to fork:
  `docs/lexicon/` here is a copy of the canonical one in `workshops`, so
  adding terms here makes the two diverge. Options: add here and accept
  the fork, add upstream and refresh the copy, or leave them undefined.
  Parked — we were getting bogged down in language.

## Behaviour we have not specified

- ~~Routing was in scope for iteration 2 and we did not spec it.~~
  Settled: we move past it on purpose. Going from one agent to another is
  the nascent form of routing, and it is the core of day 3's homework,
  not this one. It stays implicit in "done and validated".
- ~~Nothing caps the doer/validator oscillation.~~ Settled: a pass gives
  up after a set number of attempts, and the limit is configurable rather
  than hard-coded — a flag or whatever suits what the student built. Real
  graph/DSL routing arrives in day 3's homework and can carry max passes
  then. "Until the validator
  is satisfied" can run forever. The lexicon's own *doer-validator loop*
  entry warns the pair can oscillate and says set a maximum count anyway.
  Options on the table: cap the rounds, escalate to the student
  (`human-escalation` is already a lexicon term), or leave it uncapped on
  purpose and let them hit it.
- ~~Findings could flow two ways: back to the doer, or into the plan as
  a new task.~~ Settled 2026-09-15: a validator only reports. The doer
  records each finding as a subtask of the task in progress, so max
  attempts bounds a task and findings never grow the plan.
- ~~Where the attempt limit lives once there is an assembly line.~~
  Settled 2026-09-15: on the retry edge, as an attribute. It bounds that
  edge, so it belongs on it, and nothing about the loop is left outside
  the line. It stays "up to the student" in iteration 2, which has no
  assembly line yet.
- **What the factory does when it discovers new work mid-plan.** Held
  back as too sophisticated; Aldric thought it might make good homework.

## Later iterations

- ~~Steering is day 3's homework.~~ Settled 2026-09-15: steering is
  iteration 4, part 2, and it is talking to a machine while it works.
  What happens when a task gives up is a different thing, and still
  unnamed.
- **Human escalation.** Matt raised it because Fabro has it as a feature.
  It is a lexicon term. No home yet.
- ~~Does the factory keep a CLI the whole way through?~~ Settled
  2026-09-15: iteration 4 makes it a daemon. You start a job, get your
  terminal back, and attach with another command. How it is attached to
  is the student's choice.
- **Tokens or money.** Iteration 4 counts tokens, per machine and per
  provider. Prices would turn that into a number people feel. Parked: it
  dates fast, and it is arithmetic rather than behaviour.
- **One job at a time.** Iteration 4 says the daemon refuses a second
  seed while a job is running. Many jobs at once is a bigger question —
  queueing, worktrees, one plan or several — and could be an iteration of
  its own.
- **A spend ceiling.** Once spend is visible, stopping at a limit is the
  obvious next lever. Deliberately not in iteration 4.

## Teaching points, not rules

Things the specs deliberately leave implicit, for the workbook tutor's
reflection questions or a live conversation prompt.

- **There is already semantic routing in homework 1**, inside the prompt:
  *if there is no plan, write a plan; otherwise do the first thing on the
  list.* That branch is routing, and nobody has named it yet. Ask them
  whether they can see it.
- **The planner is not a specialist.** The machine that writes the plan
  is the same agent doing the work, with whatever context it happens to
  have. Ask: has anybody considered a third machine responsible for
  nothing but making the plan?
- **The doer-to-validator hop is routing too.** Same question, one
  iteration later.

## Craft

- **Should fuzzy assertions look different in Gherkin?** "Every task in it
  comes from the seed" can only be judged by an LLM, not asserted
  deterministically. Matt wondered about a tell in the wording — "it sure
  looks like…" — so a reader knows which kind of check they are reading.

## Parked for a later iteration

- **Structured output from the validator.** A success/failure JSON schema
  makes the result deterministically parseable. Agreed it lands in day 2
  or day 3 homework — day 3 at the latest, since it is the only sane way
  to handle anything more complicated.
