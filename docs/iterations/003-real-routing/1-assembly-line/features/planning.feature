Feature: Planning

  How the planner turns a seed into a plan, and how the plan is kept true.

  Rule: The seed is the assembly line's only input

    Example: The assembly line is given a seed and nothing else
      Given a seed describing a game of Tetris that runs in the terminal
      When the factory runs
      Then it builds Tetris

  Rule: The planner writes the plan from the seed

    Example: A seed with no plan yet
      Given a seed describing a game of Tetris
      And no plan
      When the factory runs
      Then the planner has written a plan before the doer started
      And every task in it comes from the seed

  Rule: The planner keeps a plan that already exists

    Example: A plan with four tasks
      Given a plan with four tasks, none of them done
      When the factory runs
      Then the plan still has those four tasks

  Rule: The factory maintains the plan

    Example: The factory stops part-way through
      Given a plan with three tasks, none of them done
      And validation that is never satisfied by the second task
      When the factory runs
      Then the plan shows the first task as done
      And the second and third as not done

    Example: A run carries on from the last
      Given a plan whose first task is done
      When the factory runs
      Then the doer starts on the second task

  Rule: The factory keeps nothing between runs but the files

    Example: A run is stopped part-way through a task
      Given a plan with three tasks, none of them done
      And a run that was stopped while the doer was working on the first task
      When the factory runs
      Then the doer starts on the first task
