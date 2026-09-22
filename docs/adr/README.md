# Architecture Decision Records

Decisions about how this tutorial is built, recorded so we can see what we
decided, when, and why. Each record follows [adr_template.md](adr_template.md).

## Adding one

1. Copy `adr_template.md` to `NNNN-short-title.md` (next number).
2. Fill in the title, date, status, context, decision, and consequences.
3. Add a row to the ledger below.

`adrgen` (see `adrgen.config.yml`) automates steps 1 and 3.

## Ledger

| ADR | Title | Status |
|---|---|---|
| [0001](0001-use-adrs.md) | use ADRs | accepted |
| [0002](0002-students-work-across-three-repositories.md) | students work across three repositories | proposed |

## Iteration ADRs

The architectural decisions that shape a given iteration's factory live in
that iteration's own `adr/` folder (e.g.
`docs/iterations/001-basic-unvalidated-loop/adr/`). They are part of the
iteration spec, not of this ledger.
