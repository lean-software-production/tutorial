# Homework 3, part 2 — Fan out

*Do this after part 1.*

Read `FACTORY.md`, then the feature files in `features/`.

Now that the route is a graph, changing it is cheap. The doer's work fans
out to three reviewers at once — same job, three different providers'
models — and a synthesiser reads all three reports and decides.

Most of this homework is a change to the graph.

A note on words: the three machines are **reviewers**. They assess and
report; they do not decide. The synthesiser decides. Fan out, reviewers,
synthesiser — that whole assembly is the validation step.
