Feature: Declarative routing

  The factory knows which machine runs next because that is written down
  somewhere, as a graph, separate from the code that runs it. Change the
  graph and the factory routes differently without being rewritten.

  Do this one after `1-many-validators.feature`. You will be extracting
  the routing you already built by hand.

  Rule: The route is described as a graph, outside the code that runs it

    Example: The graph the factory already follows
      Given this route:
        """
        digraph factory {
          doer -> testability
          doer -> security
          testability -> plan
          security -> plan
        }
        """
      When the factory runs one pass
      Then the doer's work goes to testability and security
      And both of their findings go to the plan

  Rule: Changing the graph changes what runs

    Example: A validator is added
      Given a factory routing to testability and security
      When usability is added to the route
      And the factory runs one pass
      Then the doer's work goes to all three
      And no other part of the factory changed

    Example: A validator is removed
      Given a factory routing to testability and security
      When security is removed from the route
      And the factory runs one pass
      Then the doer's work goes only to testability

  Rule: The factory refuses a route it cannot run

    Example: The route names a machine that does not exist
      Given a route naming a validator the factory does not have
      When the factory runs
      Then it stops before doing any work
      And it reports which machine is missing
