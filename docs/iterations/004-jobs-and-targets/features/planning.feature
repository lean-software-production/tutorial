Feature: Planning

  How the planner makes the plan from the seed, and keeps it true.

  Background:
    Given a copy of the factory
    And a new target, with a seed describing a game of Tetris
    And the target has the machines planner, doer and validator
    And the target has an assembly line "careful" on which the doer's work is validated
    And a job named "tetris", on the "careful" line, with that seed and target
    And the planner is the plan-alpha-beta stand-in
    And the doer is the do-next stand-in
    And the validator is the always-satisfied stand-in

  Rule: The seed is the assembly line's only input

    What to build comes from the seed alone. The assembly line is given
    the seed and nothing else.

    @real-agent
    Example: The assembly line is given a seed and nothing else
      Given every machine runs pi
      When the factory runs the "tetris" job
      Then Tetris has been built in the target

  Rule: A job's seed must exist

    Example: The seed has gone
      Given the seed has been deleted
      And no plan
      When the factory runs the "tetris" job
      Then it reports that there is no seed
      And no agent has been called
      And there is no plan

  Rule: The planner writes the plan before any work is done

    Example: A seed with no plan yet
      Given no plan
      When the factory runs the "tetris" job
      Then the planner was called before the doer
      And the plan shows every task as done

    Example: A plan already exists
      Given a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then the plan still has those three tasks

    @real-agent
    Example: The plan comes from the seed
      Given every machine runs pi
      And no plan
      When the factory runs the "tetris" job
      Then every task in the plan comes from the seed

  Rule: A job keeps its plan with the factory, not in the target

    Each job has a folder of its own, in jobs/ in the factory, and its
    plan is plan.md there.

    Example: The first run of a job named "tetris"
      Given no plan
      When the factory runs the "tetris" job
      Then the plan is plan.md in the factory's jobs folder, under tetris
      And there is no plan in the target

  Rule: The planner keeps the plan, and the factory never reads it

    The planner writes the plan. Once a task's work is committed, the
    planner marks it done, and its result says whether any task is
    left. The doer works from the plan too. The factory only knows whether
    there is a plan, and the machines' results.

    Example: A run carries on from the last
      Given a plan whose first task is done
      When the factory runs the "tetris" job
      Then the plan shows every task as done
      And there are two new commits

    Example: Work that gave up is not recorded
      Given a plan with three tasks, none of them done
      And the factory allows at most three attempts at a task
      And the validator is the never-satisfied stand-in
      When the factory runs the "tetris" job
      Then the plan shows every task as not done

    Example: A plan no factory could parse
      Given the planner is the plan-in-prose stand-in
      And the doer is the plan-in-prose stand-in
      And no plan
      When the factory runs the "tetris" job
      Then the work for alpha and beta has been committed

  Rule: A job remembers its assembly line, its seed and its target

    The line, the seed and the target are given when a job starts. After
    that, its name is enough.

    Example: The "tetris" job, run again by name
      Given the "tetris" job has been started
      And a plan whose first task is done
      When the factory runs the "tetris" job, given only its name
      Then there are two new commits
      And the validator has been called twice

  Rule: A job's settings cannot be changed once it has started

    Naming a job again with its original line, seed and target is fine,
    and so is naming it alone. Naming it with different ones is refused.

    Example: The "tetris" job is given a different target
      Given the "tetris" job has been started
      And a new target, with a seed describing a game of Tetris
      When the factory runs the "tetris" job with that target
      Then the factory refuses
      And it says the "tetris" job already has a target

    Example: The "tetris" job is given the same settings again
      Given the "tetris" job has been started
      And a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then there are three new commits

  Rule: Each job has its own plan and its own target

    Example: Two jobs, one after the other
      Given a new target, with a seed describing a game of Snake
      And the target has the machines planner, doer and validator
      And the "careful" line has been copied into the target
      And a job named "snake", on the "careful" line, with that seed and target
      When the factory runs the "tetris" job
      And the factory runs the "snake" job
      Then each job has its own plan
      And each target holds only its own job's work
