# The factory, as of this iteration

The factory builds software from a seed. A planner writes the plan, then
a doer makes it one task at a time and the three big brains checks each
attempt, until the plan is complete.

What changes here is that you can see it work. The factory no longer runs
in front of you: you start a job, it keeps running, and a second command
attaches to it. What that command shows is what every machine generates
and what every machine spends — live, from the start of the job, and
still there after the job has finished, because the factory writes it
down as it goes.

Tokens are counted for each machine and totalled for each provider,
because the three big brains puts three providers' models on one attempt
and each of them invoices separately.

New since iteration 3: `monitoring.feature` and `observability.feature`,
and two rules in `orchestration.feature` — the factory runs as a daemon,
and it runs one job at a time. `planning`, `validation` and
`assembly-line` are unchanged.
