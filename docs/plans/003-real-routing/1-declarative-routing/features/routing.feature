Feature: Routing

  How the factory knows which machine runs next.

  Rule: The route is described as a graph, outside the code that runs it

    Example: The graph the factory already follows
      Given this route:
        """
        digraph factory {
          doer -> validator
          validator -> plan
        }
        """
      When the factory runs one pass
      Then the doer's work goes to the validator
      And the validator's findings go to the plan

  Rule: Changing the graph changes what runs

    Example: A second validator is added
      Given a factory routing to one validator
      When a second is added to the route
      And the factory runs one pass
      Then the doer's work goes to both
      And no other part of the factory changed

    Example: A validator is removed
      Given a factory routing to two validators
      When one is removed from the route
      And the factory runs one pass
      Then the doer's work goes only to the remaining one

  Rule: The factory refuses a route it cannot run

    Example: The route names a machine that does not exist
      Given a route naming a validator the factory does not have
      When the factory runs
      Then it stops before doing any work
      And it reports which machine is missing
