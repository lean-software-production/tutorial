Feature: Assembly line

  The assembly line is the route through the factory's machines, written
  as a Graphviz graph the factory reads before it does any work. A
  factory can hold several lines. These rules are about a line itself —
  which lines the factory will accept — not about running along one.
  Running is in orchestration.feature.

  start and finish mark where the line begins and ends. Every other node
  names a machine. A retry edge carries the limit on how many attempts it
  may be taken. The planner decides whether there is more to do: it is
  the only machine with an edge to finish.

  Background:
    Given a copy of the factory
    And this assembly line:
      """
      digraph assembly_line {
        start -> planner
        planner -> doer        [label="more"]
        planner -> finish      [label="complete"]
        doer -> validator
        validator -> doer      [label="not satisfied", max_attempts=3]
        validator -> planner   [label="satisfied"]
      }
      """

  Rule: The factory accepts an assembly line it can run

    Example: The line as it stands
      When the factory reads the assembly line
      Then it accepts it

    Example: The validator is taken out
      Given the validator has been taken out, so the doer goes straight to the planner
      When the factory reads the assembly line
      Then it accepts it

  Rule: The factory refuses an assembly line naming a machine it does not have

    Example: A misspelt validator
      Given "validator" is misspelt "validater" throughout the assembly line
      When the factory reads the assembly line
      Then it refuses it
      And it reports that it has no machine called "validater"

  Rule: The factory refuses an assembly line that cannot reach finish

    Example: Satisfied work has nowhere to go
      Given the edge from validator to planner has been taken out
      When the factory reads the assembly line
      Then it refuses it
      And it reports that finish cannot be reached from validator
