# Homework 3 — Real routing

*Set after day 3. This is the weekend, so there are two of them.*

Each file is the whole spec of the factory at that point, not just the
new parts. Do them in order:

1. `1-factory.feature` — the doer's work fans out to three reviewers at
   once, same job, three different providers' models, and a synthesiser
   reads all three reports and decides. Wire it however you like.
2. `2-factory.feature` — now extract that wiring into a graph the factory
   reads, so the route can change without the factory changing.

The second file is prescriptive about Graphviz. That is to keep the
acceptance criteria clean, not because it is the only way — if you would
rather express the route some other way, say so and do that instead.

A note on words: the three machines are **reviewers**. They assess and
report; they do not decide. The synthesiser decides. Fan out, reviewers,
synthesiser — that whole assembly is the validation step.
