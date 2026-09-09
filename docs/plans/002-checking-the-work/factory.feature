Feature: Factory

  The factory builds software from a seed. It plans the work, then makes
  it one task at a time: a doer produces the work and a validator checks
  it, until the plan is done.

  There are two ways to run it. Running one pass takes one task from
  start to checked and stops. Running to completion keeps going until the
  plan is done. The examples below say which they mean.

  Rule: The seed is the factory's only input

    Example: The factory is given a seed and nothing else
      Given a seed describing a game of Tetris that runs in the terminal
      When the factory runs to completion
      Then it builds Tetris

  Rule: The factory creates the plan from the seed

    Example: A seed with no plan yet
      Given a seed describing a game of Tetris
      And no plan
      When the factory runs one pass
      Then a plan exists
      And every task in it comes from the seed
      And none of the tasks are done

    Example: A plan already exists
      Given a plan with four tasks, none of them done
      When the factory runs one pass
      Then the plan still has those four tasks

  Rule: Each pass completes one task, then stops

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the first task has been done and validated
      And the other two have not
      And the factory has stopped

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

  Rule: The factory maintains the plan

    Example: A pass records the work it did
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the plan shows the first task as done

    Example: The next pass carries on from the last
      Given a plan whose first task is done
      When the factory runs one pass
      Then the plan shows the first two tasks as done

  Rule: The factory commits after every pass

    Example: One pass, one commit
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then there is one new commit

    Example: Finished work is not redone
      Given a plan whose first task is done
      When the factory runs one pass
      Then there is one new commit
      And it contains the work for the second task

  Rule: The factory stops when the plan is complete

    Example: Work remains
      Given a plan with three tasks, none of them done
      When the factory runs to completion
      Then all three tasks have been done
      And the factory has stopped

    Example: Every task is already done
      Given a plan in which every task is done
      When the factory runs to completion
      Then the factory stops without doing any work
      And there are no new commits
