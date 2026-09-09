Feature: Checking the work

  The factory now has two machines. A doer produces the work; a validator
  checks it and reports what is wrong. The validator's findings go into
  the plan, so the doer picks them up as work like any other task.

  Rule: A pass ends when the validator is satisfied

    Example: The work is right first time
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the doer has done the first task
      And the validator has checked that work
      And the pass has ended

    Example: The work is wrong first time
      Given a plan with three tasks, none of them done
      And a doer whose first attempt does not satisfy the validator
      When the factory runs one pass
      Then the doer has run again
      And the pass ends once the validator is satisfied

  Rule: The validator checks the work the doer just produced

    Example: Earlier work is not rechecked
      Given a plan whose first task is done and validated
      When the factory runs one pass
      Then the validator checks the work done in this pass
      And it does not report findings about the first task

  Rule: What the validator looks for is chosen, not fixed

    The student picks the lens the validator brings to the work —
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

  Rule: The validator changes the plan, never the work

    Example: A finding becomes a task
      Given a plan with three tasks, none of them done
      And a validator that finds the first task's work untestable
      When the factory runs one pass
      Then the plan contains a new task for that finding
      And the validator has made no change to the work itself

    Example: The doer picks up the finding
      Given a plan containing a task that came from a finding
      When the factory runs one pass
      Then the doer has done that task
