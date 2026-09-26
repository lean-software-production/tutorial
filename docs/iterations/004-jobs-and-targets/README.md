# Homework 4 — Jobs and targets

Read `FACTORY.md`, then the feature files in `features/`. Together they
are the whole spec of the factory at this point, not just the new parts.

Until now your factory has built one thing: the codebase it sits in, from
the one seed, along the one assembly line it keeps in its own folder.
This homework separates the factory from what it builds.

- **The factory moves out.** It gets a codebase of its own, beside the
  ones it builds. In your starter repo, fetch-iteration moves
  `tetris/.factory` to `factory/`; open your coding agent there from now
  on.
- **The assembly lines move into the target.** A target holds its
  product and, in `.assembly-lines/`, the lines that build it, with the
  machines they name in `.assembly-lines/.machines/`. A machine's name is
  unique in its target: every line there that names the doer runs the
  same doer. Move your line and machines from homework 3 into
  `tetris/.assembly-lines/`.
- **Each run is for a job.** You name the job, and the first time you
  run it you give it a target, one of that target's lines, and a seed.
  The job remembers all three; after that, its name is enough. It keeps
  its plan with the factory, in `jobs/<name>/`. Move your plan there, or
  start the tetris job afresh.

Once the route is data, a target can hold more than one line. Write a
second one — the same line without the validator will do — and have each
job say which line it runs.

## The commands you'll end up with

The exact shape is your choice. Run from `factory/`, using `./factory`
as a stand-in:

```sh
# a new job: its target, its line and its seed
$ ./factory --job tetris --target ../tetris --line careful --seed ../tetris/seeds/tetris.md

# after that, its name is enough
$ ./factory --job tetris

# a second target: a new codebase, with a line and machines of its own
$ git init ../snake
$ cp -r ../tetris/.assembly-lines ../snake/
$ ./factory --job snake --target ../snake --line quick --seed ../tetris/seeds/snake.md
```

The factory should build whatever the new seed describes, without
disturbing the first job.

The checks still run against a copy of your factory, because jobs live
with the factory. From here on the copy builds in new targets beside it,
each holding its own lines and machines.
