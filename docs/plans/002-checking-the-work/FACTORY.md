# The factory, as of this iteration

The factory builds software from a seed. It plans the work, then makes
it one task at a time: a doer produces the work and a validator checks
it, until the plan is done.

There are two ways to run it. Running one pass takes one task from
start to checked and stops. Running to completion keeps going until the
plan is done. The examples say which they mean.

New since iteration 1: `validation.feature`, and two rules in
`orchestration.feature` — a pass now ends on validation, and gives up
after a set number of attempts.
