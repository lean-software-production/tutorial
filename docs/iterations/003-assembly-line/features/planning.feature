Feature: Planning

  How the planner makes the plan from the seed, and keeps it true.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase
    And a seed describing a game of Tetris
    And the planner's agent is the plan-alpha-beta stand-in
    And the doer's agent is the do-next stand-in
    And the validator's agent is the always-satisfied stand-in

  Rule: The seed is the assembly line's only input

    What to build comes from the seed alone. The assembly line is given
    the seed and nothing else.

    @real-agent
    Example: The assembly line is given a seed and nothing else
      Given every agent is pi
      When the factory runs
      Then Tetris has been built in the codebase

  Rule: The seed is seeds/tetris.md in the codebase

    The factory always looks there. There is no other seed to choose.

    Example: There is no seed
      Given the codebase has no seed
      And no plan
      When the factory runs
      Then it reports that there is no seed
      And no agent has been called
      And there is no plan

  Rule: The planner writes the plan before any work is done

    Example: A seed with no plan yet
      Given no plan
      When the factory runs
      Then the planner was called before the doer
      And the plan shows every task as done

    Example: A plan already exists
      Given a plan with three tasks, none of them done
      When the factory runs
      Then the plan still has those three tasks

    @real-agent
    Example: The plan comes from the seed
      Given every agent is pi
      And no plan
      When the factory runs
      Then every task in the plan comes from the seed

  Rule: The plan is kept in the factory's folder

    There is one plan: plan.md, next to the factory. The work the factory
    commits to the codebase never includes it.

    Example: The first run
      Given no plan
      When the factory runs
      Then the plan is plan.md in the factory's folder
      And there is no plan anywhere else in the codebase

  Rule: The planner keeps the plan, and the factory never reads it

    The planner writes the plan. Once a task's work is committed, the
    planner marks it done, and it answers PLAN COMPLETE when no task is
    left. The doer works from the plan too. The factory only knows whether
    there is a plan, and what the machines' agents answer.

    Example: A run carries on from the last
      Given a plan whose first task is done
      When the factory runs
      Then the plan shows every task as done
      And there are two new commits

    Example: Work that gave up is not recorded
      Given a plan with three tasks, none of them done
      And the assembly line's retry edge allows at most three attempts
      And the validator's agent is the never-satisfied stand-in
      When the factory runs
      Then the plan shows every task as not done

    Example: A plan no factory could parse
      Given the planner's agent is the plan-in-prose stand-in
      And the doer's agent is the plan-in-prose stand-in
      And no plan
      When the factory runs
      Then the work for alpha and beta has been committed
