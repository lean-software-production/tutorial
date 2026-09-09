Feature: Basic unvalidated loop

  The factory builds software from a seed, one task at a time, without
  anyone checking the work. Nothing validates the output, nothing feeds
  findings back, and nothing decides the work was wrong. That comes later.

  There are two ways to run it. Running one pass does a single task and
  stops. Running to completion keeps going until the plan is done. The
  examples below say which they mean.

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

  Rule: Each pass does one task, then stops

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the first task has been done
      And the other two have not
      And the factory has stopped

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
