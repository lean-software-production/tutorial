# Working on this tutorial

We are writing a succession of Gherkin specs. Students implement them as
homework, one per module, building a single product: **the factory**. It
starts as a basic unvalidated loop and grows from there.

## The specs

- **Gherkin describes the product** — the factory. Not the student, not
  the homework, not the course. "Build your own Ralph loop" is a homework
  title; the story it contains is a slice of factory behaviour.
- **Rules are behavioural rules of that software.** "Gherkin describes the
  product" is a principle and lives here; "the loop stops when the plan is
  complete" is a rule and lives in the spec.
- **Behaviour, not implementation.** However they build it. It may not be
  a bash loop, and we would rather it weren't.
- **One product throughout.** Each new spec lands on the factory the
  student already built and adds behaviour to it.
- **They build it themselves.** We do not hand over working code.

## Scope

The current spec is the tiniest one that moves forward. Anything we have
not explicitly said is a feature is absent from it — deliberately, so
later specs have somewhere to go.

Take the smallest step. The levers here are large: it is easy to overshoot
when confident and easy to veer when unsure.

## Layout

```
docs/plans/001-basic-unvalidated-loop/
    README.md      what the student is asked to do
    *.feature      the whole spec, as of this iteration
```

One folder per iteration of the product — which is also one homework. A
folder holds the complete set of feature files as the factory stands at
that point, not just the new ones. A later iteration may carry a modified
copy of an earlier feature file: the spec is a declaration of how the
system is now, so it changes as the product changes.
