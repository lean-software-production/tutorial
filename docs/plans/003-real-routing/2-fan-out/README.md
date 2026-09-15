# Homework 3, part 2 — Fan out

*Do this after part 1.*

Read `FACTORY.md`, then the feature files in `features/`.

Now that the route is an assembly line, swapping a machine on it is a
one-word change. The validator is replaced by a new machine, **the three
big brains**: the doer's work fans out to three reviewers at once — same
job, three different providers' models — and a synthesiser reads all
three reports and decides.

On the assembly line it is still a single node. The fan out and the fan in
happen inside it, and building that is where the work is.

A note on words: the three machines inside are **reviewers**. They assess
and report; they do not decide. The synthesiser decides. From outside, the
three big brains is the validation step.
