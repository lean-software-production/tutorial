# The factory, as of this iteration

The factory builds software from a seed. A planner writes the plan, then
a doer makes it one task at a time and a validator checks each attempt,
until the plan is complete.

The factory itself writes none of its machines' work. Each machine calls
a coding agent — an LLM-driven tool such as `pi`, the default — named in
that machine's own configuration, which is also where a stand-in can be
swapped in for quick checks (see `agent.feature`).

What changes here is not what the factory does but how it knows to do it.
The route through its machines is an **assembly line**: a Graphviz graph
the factory reads before it does any work.

- `start` and `finish` mark where the line begins and ends. Every other
  node is a machine.
- `plan_complete` is the loop. It sends the line to the doer while tasks
  remain, and to `finish` when none do.
- `validator -> doer` is the retry. Work that does not satisfy validation
  goes back for another attempt, and the edge says how many attempts it
  will carry before the factory gives up.

A factory can hold more than one assembly line, and each job says which
one it runs. A line is a recipe, not an address: it never names a
target, so the same line can build any number of them.

Each run is for a **job**, named on the command line. A job is started
with an assembly line, a seed and a target — the codebase it builds, its
own git repository — and remembers all three, so after that its name is
enough. The seed is the assembly line's only input; the name and the
target are for the orchestrator, telling it where to keep the job's plan
(`jobs/<name>/`, never in the target) and where to build. The factory
can be told to keep its jobs in another folder instead, as its tests do.

The pass is gone. It used to do the looping, and the loop is on the line
now. The factory runs; the assembly line says what runs next.

The feature files in `features/` are the whole spec. New since iteration
2: `assembly-line.feature`. `agent.feature` moves the choice of
agent from the command line into each machine's configuration.
`orchestration` and `planning` are rewritten
without the pass, and gain the rules for choosing a line for each job. `validation` is unchanged.
