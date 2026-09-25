# Homework 5 — Watching

Read `FACTORY.md`, then the feature files in `features/`. Together they
are the whole spec of the factory at this point, not just the new parts.

The factory builds the same software it built for homework 4. What is new
is that you can watch it: what every machine generates, and what every
machine costs.

This is where your factory stops being something you run and becomes
something that is running. You start a job and get your terminal back.
Watching is a separate command that attaches to a job in flight. How it
attaches — a socket, a pipe, a file the daemon appends to, an HTTP
endpoint — is yours to choose.

## The commands you'll end up with

The exact commands are your choice. This is the shape, using `./factory`
as a stand-in:

```sh
# start a job — you get your terminal back
$ ./factory --job tetris --line lines/careful.dot --seed ../seeds/tetris.md --target ..
started job tetris

# attach to it, now or later — catches you up, then follows live
$ ./factory watch tetris
planner    | ...
doer       | ...
tokens     doer 12.4k in / 3.1k out   anthropic 15.5k   google 4.2k   openai 3.9k   job 23.6k

# a second job while one is running is refused
$ ./factory --job snake --line lines/quick.dot --seed ../seeds/snake.md --target ../../snake
refused: job tetris is running

# stop the job (the factory stays up); start it again later by name alone
$ ./factory stop tetris
$ ./factory --job tetris

# stop the factory itself — its job stops with it
$ ./factory stop
```

Before you start, look at what your factory does today. It probably
prints as it goes, and printing is not this: it is gone when the
scrollback is gone, and it belongs to the terminal that started the run.
A record you can attach to late, catch up on, and still read tomorrow is
a different piece of machinery.
