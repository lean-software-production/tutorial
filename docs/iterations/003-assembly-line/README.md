# Homework 3 — The assembly line

Read `FACTORY.md`, then the feature files in `features/`. Together they
are the whole spec of the factory at this point, not just the new parts.

The factory does the same work it did for homework 2. What changes is
where the route lives. Until now it was hidden: the plan-or-work branch in
your prompt, the retry in your code, and the looping in the pass. All of
it comes out into an **assembly line** — a graph the factory reads — and
the planner becomes a machine of its own on it.

That takes the pass with it. There is no more running one pass: the
factory runs the assembly line, and the line says what happens next.

Your factory has one assembly line, kept in its own folder. Take the
validator out of it and the factory should still run, doing the work
unchecked — without a change to your code.

`assembly-line.feature` is prescriptive about Graphviz. That is to keep
the acceptance criteria clean, not because it is the only way — if you
would rather express the assembly line some other way, say so and do that
instead.
