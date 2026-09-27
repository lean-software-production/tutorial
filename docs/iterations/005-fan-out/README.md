# Homework 5 — Fan out

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

## Checks that see machines at work

Some examples need a machine caught part-way through its work: three
reviewers working at the same time, say. Never do that with a wait of a
set length. On a slow machine it is too short, on a fast one it proves
nothing, and either way the check sometimes fails for no reason.

Hold the double instead. It waits for a signal from the check (a file
appearing in the example's folder will do) and goes on only when the
check lets it. To see three reviewers working at once, hold all three
and let them go only once all three have begun. A factory that runs
them one after another never gets there, every time. Have a held double
give up if the example's folder is removed, so none outlives its
example.
