Feature: Planning

  How the plan is made from the seed, and who keeps it true.

  Background:
    Given a copy of the factory
    And a new target
    And a seed describing a game of Tetris
    And the agent plans the tasks alpha and beta, and does one task a pass

  Rule: The seed is the only input to the work

    What to build comes from the seed alone.

    @real-agent
    Example: The work is given a seed and nothing else
      Given the agent is pi
      When the factory runs to completion
      Then Tetris has been built in the target

  Rule: The seed is selected on the command line

    A seed argument is required alongside the target argument. Relative
    paths are resolved from the caller's working directory. The factory
    gives machines the resolved seed path so they can read it from the
    target. There is no default seed.

    Example: No seed argument
      Given no seed is chosen
      And no plan
      When the factory runs one pass
      Then it reports that there is no seed
      And no agent has been called
      And there is no plan

    Example: There is no seed
      Given the seed has been deleted
      And no plan
      When the factory runs one pass
      Then it reports that there is no seed
      And no agent has been called
      And there is no plan

  Rule: A pass with no plan writes one, and does nothing else

    Example: A seed with no plan yet
      Given no plan
      When the factory runs one pass
      Then there is a plan
      And the plan shows every task as not done
      And there are no new commits

    Example: A plan already exists
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the plan still has those three tasks

    @real-agent
    Example: The plan comes from the seed
      Given the agent is pi
      And no plan
      When the factory runs one pass
      Then every task in the plan comes from the seed

  Rule: Each target keeps its own plan

    The plan is .factory/plan.md inside the selected target. That folder
    holds run state, not factory code, and is excluded from work commits.
    A fresh target starts without a plan; selecting an existing target
    resumes its plan. The factory never shares a plan between targets.

    Example: The first pass
      Given no plan
      When the factory runs one pass
      Then the plan is .factory/plan.md in the target
      And there is no plan in the factory's folder

  Rule: The agent keeps the plan, and the factory never reads it

    The agent picks the next task, does it and marks it done, all from
    its prompt. The factory only knows whether there is a plan, and the
    agent's result.

    Example: A pass records the work it did
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the plan shows the first task as done

    Example: The next pass carries on from the last
      Given a plan whose first task is done
      When the factory runs one pass
      Then the plan shows the first two tasks as done

    Example: A plan no factory could parse
      Given the agent keeps its plan in prose
      And no plan
      When the factory runs to completion
      Then the work for alpha and beta has been committed
