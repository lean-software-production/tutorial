# The factory, as of this iteration

The factory builds software from a seed. It plans the work, then makes it
one task at a time: a doer produces the work, a validator checks it, until
the plan is done.

What changes here is not what the factory does but how it knows to do it.
The route from doer to validator to plan is no longer wired into the code.
It is written down as a graph the factory reads.

There are two ways to run it. Running one pass takes one task from start
to checked and stops. Running to completion keeps going until the plan is
done. The examples say which they mean.

New since iteration 2: `routing.feature`. `planning`, `orchestration` and
`validation` are unchanged.
