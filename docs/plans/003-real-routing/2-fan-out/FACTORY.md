# The factory, as of this iteration

The factory builds software from a seed. It plans the work, then makes
it one task at a time: a doer produces the work, three reviewers assess
it, and a synthesiser reads their reports and decides — until the plan
is done.

A pass is every machine running once, with validation repeating until
it is satisfied.

The reviewers do not decide anything; they report, and the synthesiser
never sees the work itself — only their reports. Fan out, reviewers,
synthesiser: together that assembly is the validation step. Rules about
the pass say "validation" and do not care how it is done.

There are two ways to run it. Running one pass takes one task from
start to checked and stops. Running to completion keeps going until the
plan is done. The examples say which they mean.

New since part 1: four rules in `validation.feature`, and the route in
`routing.feature` now fans out. `planning` and `orchestration` are
unchanged.
