# Open questions

Things we raised and deliberately did not settle. Not a backlog — each of
these needs a decision from Matt and Aldric, not an implementation.

## Naming

- ~~`build-loop.feature` is misnamed.~~ Settled: one `factory.feature`
  per iteration, holding the whole spec of the factory at that point. We
  could not see a slice better than not slicing.
- **The inner step has no name.** A *pass* is a doer and a validator
  repeating until the validator is satisfied. One doer run inside that
  has no word. Matt reached for game-loop language — frame, step.
- **`plan` and `pass` are not in the lexicon**, and both carry weight in
  the specs. Looks like the lexicon needs to grow rather than us being
  sloppy. Matt: not now.

## Behaviour we have not specified

- **Nothing caps the doer/validator oscillation.** "Until the validator
  is satisfied" can run forever. The lexicon's own *doer-validator loop*
  entry warns the pair can oscillate and says set a maximum count anyway.
- **What the factory does when it discovers new work mid-plan.** Held
  back as too sophisticated; Aldric thought it might make good homework.

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
