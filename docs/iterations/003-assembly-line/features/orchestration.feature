Feature: Orchestration

  How the factory runs along its assembly line: when a task is finished,
  when to give up and when to stop. These rules do not care how
  validation is done.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase
    And a seed describing a game of Tetris
    And the planner's agent is the plan-alpha-beta stand-in
    And the doer's agent is the do-next stand-in
    And the validator's agent is the always-satisfied stand-in

  Rule: The factory works in the codebase around it

    The factory sits in a folder of its own inside the codebase it builds,
    and builds in the folder around it. The codebase is a git repository;
    the factory commits its work there, and leaves its own folder out of
    those commits.

    A new codebase, for an example, is a new git repository with a copy
    of the factory in it. That is how an example keeps out of the codebase
    you are building.

  Rule: The factory runs the machines its assembly line gives it

    Example: An assembly line with no validator on it
      Given the validator has been taken out, so the doer goes straight to the planner
      And a plan with three tasks, none of them done
      When the factory runs
      Then the plan shows every task as done
      And the validator has not been called

  Rule: The factory does no work on an assembly line it refuses

    Example: The assembly line names a machine the factory does not have
      Given "validator" is misspelt "validater" throughout the assembly line
      And a plan with three tasks, none of them done
      When the factory runs
      Then no agent has been called
      And there are no new commits

  Rule: The doer works on one task at a time

    Which task comes next is the planner's business, not the factory's.

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs
      Then there are three new commits
      And each new commit contains the work for one task

  Rule: A task is finished when validation is satisfied

    Example: The work is right first time
      Given a plan with three tasks, none of them done
      When the factory runs
      Then the doer has been called three times

    Example: The work is wrong first time
      Given a plan with three tasks, none of them done
      And the validator's agent is the not-satisfied-once stand-in
      When the factory runs
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
      And the assembly line's retry edge allows at most three attempts
      And the validator's agent is the never-satisfied stand-in
      When the factory runs
      Then the doer has been called three times
      And it reports that a task hit its limit
      And there are no new commits
      And the factory has stopped

  Rule: The factory commits each time a task is finished

    Example: Three tasks, three commits
      Given a plan with three tasks, none of them done
      When the factory runs
      Then there are three new commits

    Example: Finished work is not redone
      Given a plan whose first task is done
      When the factory runs
      Then there are two new commits
      And no new commit contains the work for the first task

  Rule: The factory stops when the planner says the plan is complete

    The planner keeps the plan, so only the planner knows when it is
    complete. It says so by answering PLAN COMPLETE, and the line goes to
    finish.

    Example: Work remains
      Given a plan with three tasks, none of them done
      When the factory runs
      Then the plan shows every task as done
      And the factory has stopped

    Example: Every task is already done
      Given a plan in which every task is done
      When the factory runs
      Then the doer has not been called
      And there are no new commits
      And the factory has stopped
