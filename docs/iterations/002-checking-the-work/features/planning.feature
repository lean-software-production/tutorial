Feature: Planning

  How the factory turns a seed into a plan, and keeps that plan true.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase

  Rule: The seed is the only input to the work

    What to build comes from the seed alone.

    @real-agent
    Example: The work is given a seed and nothing else
      Given a seed describing a game of Tetris that runs in the terminal
      When the factory runs to completion
      Then the coding agent has built Tetris in the codebase

  Rule: The seed is seeds/tetris.md in the codebase

    The factory always looks there. There is no other seed to choose.

    Example: There is no seed
      Given nothing at seeds/tetris.md in the codebase
      And no plan
      When the factory runs one pass
      Then it reports that it has no seed
      And there is no plan

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

  Rule: The factory keeps its plan in its own folder

    There is one plan: plan.md, next to the factory. The work the factory
    commits to the codebase never includes it.

    Example: The first pass
      Given no plan
      When the factory runs one pass
      Then the plan is plan.md in the factory's folder
      And there is no plan anywhere else in the codebase

  Rule: The factory maintains the plan

    Example: A pass records the work it did
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the plan shows the first task as done

    Example: The next pass carries on from the last
      Given a plan whose first task is done
      When the factory runs one pass
      Then the plan shows the first two tasks as done
