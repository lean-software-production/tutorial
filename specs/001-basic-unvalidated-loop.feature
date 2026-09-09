Feature: Basic unvalidated loop

  The factory builds software from a spec, one task at a time, without
  anyone checking the work. Nothing validates the output, nothing feeds
  findings back, and nothing decides the work was wrong. That comes later.

  Rule: The spec is the factory's only input

    Example: The factory is given a spec and nothing else
      Given a spec describing a game of Tetris that runs in the terminal
      When the factory runs
      Then it starts building Tetris

    Example: A different spec builds a different thing
      Given the factory has finished building Tetris
      When the spec is replaced with one describing a Sudoku solver
      And the factory runs
      Then it starts building a Sudoku solver

  Rule: The factory creates the plan from the spec

    Example: A spec with no plan yet
      Given a spec describing a game of Tetris
      And no plan
      When the factory runs
      Then a plan exists
      And every task in it comes from the spec

    Example: A plan already exists
      Given a plan with four tasks, none of them done
      When the factory runs
      Then the plan still has those four tasks

  Rule: Each pass does one task, then ends

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the first task has been done
      And the other two have not
      And the factory has ended

  Rule: The factory maintains the plan

    Example: A pass records the work it did
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the plan shows the first task as done

    Example: The next pass carries on from the last
      Given a plan whose first task is done
      When the factory runs one pass
      Then the second task has been done
      And the first is not done again

  Rule: The factory stops when the plan is complete

    Example: Every task is done
      Given a plan in which every task is done
      When the factory runs
      Then it ends without doing any work

    Example: The last task finishes
      Given a plan with one task remaining
      When the factory runs
      Then that task has been done
      And the factory ends without waiting for more work
