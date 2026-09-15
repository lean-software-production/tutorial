Feature: Routing

  How the factory knows which machine runs next.

  Rule: The route is described as a graph, outside the code that runs it

    Example: The graph the factory already follows
      Given this route:
        """
        digraph factory {
          doer -> reviewer_one
          doer -> reviewer_two
          doer -> reviewer_three
          reviewer_one -> synthesiser
          reviewer_two -> synthesiser
          reviewer_three -> synthesiser
          synthesiser -> plan
        }
        """
      When the factory runs one pass
      Then the doer's work goes to all three reviewers
      And the synthesiser's decision goes to the plan

  Rule: Changing the graph changes what runs

    Example: A fourth reviewer is added
      Given a factory routing to three reviewers
      When a fourth is added to the route
      And the factory runs one pass
      Then the doer's work goes to all four
      And no other part of the factory changed

    Example: A reviewer is removed
      Given a factory routing to three reviewers
      When one is removed from the route
      And the factory runs one pass
      Then the doer's work goes to the remaining two

  Rule: The factory refuses a route it cannot run

    Example: The route names a machine that does not exist
      Given a route naming a reviewer the factory does not have
      When the factory runs
      Then it stops before doing any work
      And it reports which machine is missing
