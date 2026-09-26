Feature: Assembly line

  The assembly line is the route through the factory's machines, written
  as a Graphviz graph the factory reads before it does any work. A
  factory can hold several lines. These rules are about a line itself —
  which lines the factory will accept — not about running along one.
  Running is in orchestration.feature.

  start and finish mark where the line begins and ends. Every other node
  names a machine. A retry edge carries the limit on how many attempts it
  may be taken. The planner decides whether there is more to do: it is
  the only machine with an edge to finish. The three big brains is one
  machine here; what is inside it is in validation.feature.

  Background:
    Given a copy of the factory
    And this assembly line:
      """
      digraph assembly_line {
        start -> planner
        planner -> doer        [label="more"]
        planner -> finish      [label="complete"]
        doer -> three_big_brains
        three_big_brains -> doer     [label="not satisfied", max_attempts=3]
        three_big_brains -> planner  [label="satisfied"]
      }
      """

  Rule: The factory accepts an assembly line it can run

    Example: The line as it stands
      When the factory reads the assembly line
      Then it accepts it

    Example: The single validator goes back in
      Given three_big_brains has been replaced by validator throughout the assembly line
      When the factory reads the assembly line
      Then it accepts it

  Rule: The factory refuses an assembly line naming a machine it does not have

    Example: A misspelt machine
      Given "three_big_brains" is misspelt "three_big_brain" throughout the assembly line
      When the factory reads the assembly line
      Then it refuses it
      And it reports that it has no machine called "three_big_brain"

  Rule: The factory refuses an assembly line that cannot reach finish

    Example: Satisfied work has nowhere to go
      Given the edge from three_big_brains to planner has been taken out
      When the factory reads the assembly line
      Then it refuses it
      And it reports that finish cannot be reached from three_big_brains
