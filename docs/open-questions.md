# Open questions

Homework for days 2 and 3 is specced. Next: the live-session conversation
prompts for those days, then homework for day 4.

One homework is one iteration. Iteration 1 is set after day 2, iteration
2 after day 3 — so iteration N is the homework for day N+1, for now.

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
  the nascent form of routing, and it is the core of day 4's homework,
  not this one. It stays implicit in "done and validated".
- ~~Nothing caps the doer/validator oscillation.~~ Settled: a pass gives
  up after a set number of attempts, and the limit is configurable rather
  than hard-coded — a flag or whatever suits what the student built. Real
  graph/DSL routing arrives in day 4's homework and can carry max passes
  then. "Until the validator
  is satisfied" can run forever. The lexicon's own *doer-validator loop*
  entry warns the pair can oscillate and says set a maximum count anyway.
  Options on the table: cap the rounds, escalate to the student
  (`human-escalation` is already a lexicon term), or leave it uncapped on
  purpose and let them hit it.
- **What the factory does when it discovers new work mid-plan.** Held
  back as too sophisticated; Aldric thought it might make good homework.

## Later iterations

- **Steering is day 4's homework.** Aldric: what happens when the
  validator stops and you have to decide what to do next *is* steering,
  though we would not call it that yet. Whether iteration 2's give-up
  behaviour is the seed of that, or something separate, is undecided.
- **Human escalation.** Matt raised it because Fabro has it as a feature.
  It is a lexicon term. No home yet.
- **Does the factory keep a CLI the whole way through?** Aldric: that is
  how we start, but by observability and monitorability there is probably
  a server and a daemon, and the student chooses at that point.

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
  makes the result deterministically parseable. Agreed it lands in day 3
  or day 4 homework — day 4 at the latest, since it is the only sane way
  to handle anything more complicated.
