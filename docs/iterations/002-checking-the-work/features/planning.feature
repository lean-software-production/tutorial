Feature: Planning

  How the factory turns a seed into a plan, and keeps that plan true.

  Rule: The seed is the only description of what to build

    Example: The factory is told what to build by the seed and nothing else
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

  Rule: A job keeps its plan with the factory, not in the target

    Example: The first pass of a job named "tetris"
      Given a job named "tetris" with a seed, a target and no plan
      When the factory runs one pass of the "tetris" job
      Then the plan is in jobs/tetris in the factory
      And there is no plan in the target

  Rule: The factory maintains the plan

    Example: A pass records the work it did
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the plan shows the first task as done

    Example: The next pass carries on from the last
      Given a plan whose first task is done
      When the factory runs one pass
      Then the plan shows the first two tasks as done

  Rule: The factory keeps nothing between passes but the files

    Example: A pass is stopped part-way through
      Given a plan with three tasks, none of them done
      And a pass that was stopped while the doer was working on the first task
      When the factory runs one pass
      Then the doer works on the first task
      And the plan shows the first task as done

  Rule: A job is picked up again by its name

    Example: The "tetris" job's second pass
      Given a job named "tetris" whose plan has its first task done
      When the factory runs one pass of the "tetris" job
      Then the doer works on the second task

  Rule: Each job has its own plan and its own target

    Example: Two jobs side by side
      Given a job named "tetris" whose seed describes Tetris
      And a job named "snake" whose seed describes Snake, with a different target
      When the factory runs one pass of each
      Then each job has its own plan
      And each target holds only its own job's work
