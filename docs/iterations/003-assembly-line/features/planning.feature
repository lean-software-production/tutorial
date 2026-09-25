Feature: Planning

  How the planner turns a seed into a plan, and how the plan is kept true.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase

  Rule: The seed is the assembly line's only input

    What to build comes from the seed alone. The assembly line is given
    the seed and nothing else.

    @real-agent
    Example: The assembly line is given a seed and nothing else
      Given a seed describing a game of Tetris that runs in the terminal
      When the factory runs
      Then the machines' agents have built Tetris in the codebase

  Rule: The seed is seeds/tetris.md in the codebase

    The factory always looks there. There is no other seed to choose.

    Example: There is no seed
      Given nothing at seeds/tetris.md in the codebase
      And no plan
      When the factory runs
      Then it reports that it has no seed
      And there is no plan

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

  Rule: The factory keeps its plan in its own folder

    There is one plan: plan.md, next to the factory. The work the factory
    commits to the codebase never includes it.

    Example: The first run
      Given no plan
      When the factory runs
      Then the plan is plan.md in the factory's folder
      And there is no plan anywhere else in the codebase

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
