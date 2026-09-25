Feature: Assembly line

  The assembly line is the route through the factory's machines, written
  as a Graphviz graph the factory reads before it does any work. The
  factory has one assembly line, kept in its own folder. These rules are
  about the line itself — which lines the factory will accept — not about
  running along one. Running is in orchestration.feature.

  start and finish mark where the line begins and ends. Every other node
  names a machine. A retry edge carries the limit on how many attempts it
  may be taken.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase
    And this assembly line:
      """
      digraph assembly_line {
        start -> planner
        planner -> plan_complete
        plan_complete -> doer       [label="no"]
        plan_complete -> finish     [label="yes"]
        doer -> validator
        validator -> doer           [label="not satisfied", max_attempts=3]
        validator -> plan_complete  [label="satisfied"]
      }
      """

  Rule: The factory accepts an assembly line it can run

    Example: The line as it stands
      When the factory reads the assembly line
      Then it accepts it

    Example: The validator is taken out
      Given the validator has been taken out, so the doer goes straight to plan_complete
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
      Given the edge from validator to plan_complete has been taken out
      When the factory reads the assembly line
      Then it refuses it
      And it reports that finish cannot be reached from validator
