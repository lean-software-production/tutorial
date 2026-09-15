# The factory, as of this iteration

The factory builds software from a seed. A planner writes the plan, then
a doer makes it one task at a time and the three big brains checks each
attempt, until the plan is complete.

The three big brains is one machine on the assembly line, where the
validator used to be. Inside it, the doer's work fans out to three
reviewers on three providers' models at once, and a synthesiser reads
their reports — never the work itself — and decides. The reviewers report;
only the synthesiser decides.

Each file knows only its own altitude. `orchestration.feature` says
"validation" and does not care how it is done. `assembly-line.feature`
knows the three big brains is one machine and nothing about what is inside
it. `validation.feature` is what is inside it.

New since part 1: the validator is replaced by the three big brains in
`assembly-line.feature`, and `validation.feature` describes what is inside
it. `planning` and `orchestration` are unchanged.
