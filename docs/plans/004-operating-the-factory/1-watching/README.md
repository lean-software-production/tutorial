# Homework 4, part 1 — Watching

*Set after day 4. Two parts again; do this one first.*

Read `FACTORY.md`, then the feature files in `features/`. Together they
are the whole spec of the factory at this point, not just the new parts.

The factory builds the same software it built for homework 3. What is new
is that you can watch it: what every machine generates, and what every
machine costs.

This is where your factory stops being something you run and becomes
something that is running. You start a job and get your terminal back.
Watching is a separate command that attaches to a job in flight. How it
attaches — a socket, a pipe, a file the daemon appends to, an HTTP
endpoint — is yours to choose.

Before you start, look at what your factory does today. It probably
prints as it goes, and printing is not this: it is gone when the
scrollback is gone, and it belongs to the terminal that started the run.
A record you can attach to late, catch up on, and still read tomorrow is
a different piece of machinery.

Do part 2 after this one.
