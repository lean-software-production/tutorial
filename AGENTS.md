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

## Language

Use the terms in `docs/lexicon/` — `software-factory.yaml` for what we
teach about, `teaching.yaml` for how we teach. Prefer the lexicon's word
to a synonym, in specs, READMEs and conversation alike. The students learn
the vocabulary from these materials, so the materials have to be
consistent.

The lexicon is not finished. When you hear us using a word that is not in
it, or using a term differently from how it is defined there, say so and
ask. Sometimes we are being sloppy and you should correct us; sometimes
the lexicon needs to grow. Either way it is worth the interruption — do
not quietly translate what we said into the nearest lexicon term, and do
not quietly adopt a word that is missing from it.

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
    FACTORY.md     what the factory is, at this point
    features/
        planning.feature        seed to plan, and keeping the plan true
        orchestration.feature   running the factory: tasks, attempts, when to stop
        validation.feature      deciding the work is good enough
        assembly-line.feature   the route through the machines, as a graph
```

One folder per iteration of the product — which is also one homework. A
folder holds the complete set of feature files as the factory stands at
that point, not just the new ones. A later iteration may carry a modified
copy of an earlier feature file: the spec is a declaration of how the
system is now, so it changes as the product changes.

Feature files are split by capability, not by what changed. A file
appears when the factory first has that capability and is carried forward
after that. Keep the altitudes apart: `orchestration.feature` says
"validation is satisfied" and must not know that validation is the three
big brains; `assembly-line.feature` knows the three big brains is one
machine and must not know it is three reviewers and a synthesiser — that
belongs in `validation.feature`.

Where one iteration is too big for a single homework, it gets numbered
parts, each a complete spec in its own right:
`003-real-routing/1-assembly-line/` and `.../2-fan-out/`.
