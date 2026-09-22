# Homework 3, part 1 — The assembly line

*Set after day 3. This is the weekend, so there are two parts.*

Read `FACTORY.md`, then the feature files in `features/`. Together they
are the whole spec of the factory at this point, not just the new parts.

The factory does the same work it did for homework 2. What changes is
where the route lives. Until now it was hidden: the plan-or-work branch in
your prompt, the retry in your code, and the looping in the pass. All of
it comes out into an **assembly line** — a graph the factory reads — and
the planner becomes a machine of its own on it.

That takes the pass with it. There is no more running one pass: the
factory runs the assembly line, and the line says what happens next.

Once the route is data, one factory can hold more than one line. Write a
second one — the same line without the validator will do — and have each
job say which line it runs:

```sh
$ ./factory --job tetris --line lines/careful.dot --seed spec.md --target ../targets/tetris
$ ./factory --job snake  --line lines/quick.dot   --seed snake.md --target ../targets/snake
```

`assembly-line.feature` is prescriptive about Graphviz. That is to keep
the acceptance criteria clean, not because it is the only way — if you
would rather express the assembly line some other way, say so and do that
instead.

Do part 2 after this one.
