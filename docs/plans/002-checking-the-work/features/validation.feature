Feature: Validation

  How the factory decides the doer's work is good enough.

  Rule: A validator checks the work the doer just produced

    Example: Earlier work is not rechecked
      Given a plan whose first task is done and validated
      When the factory runs one pass
      Then a validator checks the work done in this pass
      And it does not report findings about the first task

  Rule: What a validator looks for is chosen, not fixed

    The student picks the lens a validator brings to the work —
    testability, single responsibility, usability, internationalisation,
    security. The factory does not care which. It is the choice that
    teaches, so this spec leaves it open on purpose.

    Example: A validator that looks at testability
      Given a validator with a lens of testability
      When the factory runs one pass
      Then its findings are about testability

    Example: A validator that looks at something else
      Given a validator with a lens of internationalisation
      When the factory runs one pass
      Then its findings are about internationalisation

  Rule: A validator changes the plan, never the work

    Example: A finding becomes a task
      Given a plan with three tasks, none of them done
      And a validator that finds the first task's work untestable
      When the factory runs one pass
      Then the plan contains a new task for that finding
      And no validator has changed the work itself

    Example: The doer picks up the finding
      Given a plan containing a task that came from a finding
      When the factory runs one pass
      Then the doer has done that task
