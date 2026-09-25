# Homework 4 — Jobs and targets

Read `FACTORY.md`, then the feature files in `features/`. Together they
are the whole spec of the factory at this point, not just the new parts.

Until now your factory has built one thing: the codebase it sits in, from
the one seed, along the one assembly line. This homework takes all three
out of the factory and makes them choices.

Each run of the factory is now for a **job**. You name the job, and the
first time you run it you give it an assembly line, a seed (what to
build) and a target (the folder to build it in, inside a git repository).
The job remembers all three; after that, its name is enough. It keeps its
plan in the job's folder, `jobs/<name>/`, not next to the factory.

Once the route is data, one factory can hold more than one line. Write a
second one — the same line without the validator will do — and have each
job say which line it runs.

## The commands you'll end up with

The exact shape is your choice. Run from `tetris/.factory`, using
`./factory` as a stand-in:

```sh
# a new job: its line, its seed and its target
$ ./factory --job tetris --line lines/careful.dot --seed ../seeds/tetris.md --target ..

# after that, its name is enough
$ ./factory --job tetris

# a second job: another seed, another line, a target of its own
$ git init ../../snake
$ ./factory --job snake --line lines/quick.dot --seed ../seeds/snake.md --target ../../snake
```

The factory should build whatever the new seed describes, without
disturbing the first job.

Your factory already has a line and a plan from homework 3. Move them
where they now belong — the line into `lines/`, the plan into
`jobs/tetris/` — or start the tetris job afresh.

The factory can also be told to keep its jobs somewhere other than
`jobs/`. That is how the checks now keep out of the jobs you started.
