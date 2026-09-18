# The factory, as of this iteration

The factory builds software from a seed. A planner writes the plan, then
a doer makes it one task at a time and a validator checks each attempt,
until the plan is complete.

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

The pass is gone. It used to do the looping, and the loop is on the line
now. The factory runs; the assembly line says what runs next.

The feature files in `features/` are the whole spec. New since iteration
2: `assembly-line.feature`. `orchestration` and `planning` are rewritten
without the pass. `validation` is unchanged.
