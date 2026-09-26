Feature: Orchestration

  How the factory runs along its assembly line: when a task is finished,
  when to give up and when to stop. These rules do not care how
  validation is done.

  Background:
    Given a copy of the factory
    And a new target, with a seed describing a game of Tetris
    And an assembly line "careful" on which the doer's work is validated
    And a job named "tetris", on the "careful" line, with that seed and target
    And the planner's agent is the plan-alpha-beta stand-in
    And the doer's agent is the do-next stand-in
    And every reviewer's agent is the always-satisfied stand-in
    And the synthesiser's agent is the always-satisfied stand-in

  Rule: The factory works in the target it is given

    The target is the folder a job builds the product in. It sits in a
    git repository that the factory commits its work to. The factory need
    not sit inside it.

    A copy of the factory, for an example, is a copy in a new folder, with
    its own jobs. A new target is a new git repository. That is how an
    example keeps out of your factory's jobs and the codebases you are
    building.

  Rule: The factory runs as a daemon

    Example: Starting a job
      Given a job named "tetris" whose seed describes a game of Tetris
      When I start the "tetris" job
      Then the factory goes on running after the command returns
      And I can watch it

  Rule: The factory runs one job at a time

    Example: A second job while one is running
      Given a running job
      When I start another job
      Then it refuses
      And the running job carries on untouched

  Rule: The factory works in the target it is given

    The target is the folder a job builds the product in. It sits in a
    git repository that the factory commits its work to.

  Rule: The factory runs the machines its assembly line gives it

    Example: An assembly line with no validation on it
      Given the three big brains has been taken out of the "careful" line, so the doer goes straight to the planner
      And a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then the plan shows every task as done
      And the synthesiser has not been called

  Rule: Each job runs the assembly line it is given

    A factory can hold more than one assembly line. Which one a job runs
    is chosen when the job starts; a line never names a target.

    Example: Two lines, one factory
      Given an assembly line "quick" on which the doer goes straight to the planner
      And a new target, with a seed describing a game of Snake
      And a job named "snake", on the "quick" line, with that seed and target
      And a plan for each job with three tasks, none of them done
      When the factory runs the "tetris" job
      And the factory runs the "snake" job
      Then the three big brains was called for the "tetris" job
      And the three big brains was not called for the "snake" job

  Rule: An assembly line works on any target

    Example: One line, two targets
      Given a new target, with a seed describing a game of Snake
      And a job named "snake", on the "careful" line, with that seed and target
      And a plan for each job with three tasks, none of them done
      When the factory runs the "tetris" job
      And the factory runs the "snake" job
      Then each target holds only its own job's work

  Rule: The factory does no work on an assembly line it refuses

    Example: The assembly line names a machine the factory does not have
      Given "three_big_brains" is misspelt "three_big_brain" throughout the "careful" line
      And a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then no agent has been called
      And there are no new commits

  Rule: The doer works on one task at a time

    Which task comes next is the planner's business, not the factory's.

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then there are three new commits
      And each new commit contains the work for one task

  Rule: A task is finished when validation is satisfied

    Example: The work is right first time
      Given a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then the doer has been called three times

    Example: The work is wrong first time
      Given a plan with three tasks, none of them done
      And the synthesiser's agent is the not-satisfied-once stand-in
      When the factory runs the "tetris" job
      Then the doer has been called four times
      And there are three new commits

  Rule: A task gives up after a set number of attempts

    An attempt is the doer producing work and validation deciding on it.
    A doer and a validator can oscillate, each attempt introducing a new
    problem, so a task cannot be allowed to run forever. The limit belongs
    with the retry it bounds, so it is an attribute of the retry edge on
    the assembly line. A task that gives up is not committed: the work is
    left where it is, for whoever comes looking.

    Example: Validation is never satisfied
      Given a plan with three tasks, none of them done
      And the "careful" line's retry edge allows at most three attempts
      And the synthesiser's agent is the never-satisfied stand-in
      When the factory runs the "tetris" job
      Then the doer has been called three times
      And it reports that a task hit its limit
      And there are no new commits
      And the factory has stopped

  Rule: The factory commits each time a task is finished

    Example: Three tasks, three commits
      Given a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then there are three new commits

    Example: Finished work is not redone
      Given a plan whose first task is done
      When the factory runs the "tetris" job
      Then there are two new commits
      And no new commit contains the work for the first task

  Rule: The factory stops when the planner says the plan is complete

    The planner keeps the plan, so only the planner knows when it is
    complete. It says so by answering PLAN COMPLETE, and the line goes to
    finish.

    Example: Work remains
      Given a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then the plan shows every task as done
      And the factory has stopped

    Example: Every task is already done
      Given a plan in which every task is done
      When the factory runs the "tetris" job
      Then the doer has not been called
      And there are no new commits
      And the factory has stopped

  Rule: Stopping a job leaves the factory running

    Example: Stopping the "tetris" job
      Given the "tetris" job is running
      When I stop the "tetris" job
      Then the "tetris" job is no longer running
      And the factory is still running

  Rule: Stopping the factory stops its job too

    Example: Stopping the factory while a job runs
      Given the "tetris" job is running
      When I stop the factory
      Then the factory is no longer running
      And neither is the "tetris" job

  Rule: A stop interrupts the work at once and leaves the job in a sane state

    Stopping is something you choose to do. Whatever machine is working
    is interrupted there and then, and its attempt is abandoned: nothing is
    marked done that isn't, and nothing half-finished is committed. What it
    had written is left in the target, for whoever comes looking. A crash
    is not a stop; after one, the factory makes a best effort to do the
    same, and no more is asked of it.

    Example: The doer is mid-attempt
      Given the "tetris" job's plan has three tasks, none of them done
      And the doer is part-way through its first attempt at the first task
      When I stop the "tetris" job
      Then the doer's attempt has been abandoned
      And the plan shows the first task as not done
      And there are no new commits

  Rule: A stopped job carries on when it is started again

    Example: Starting the "tetris" job again
      Given I stopped the "tetris" job while the doer was working on the first task
      When I start the "tetris" job again, by name alone
      Then the doer starts on the first task
