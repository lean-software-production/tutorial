Feature: Orchestration

  What a pass is, when it ends, and when the factory stops. These
  rules do not care how validation is done.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase

  Rule: The factory works in the codebase around it

    The factory sits in a folder of its own inside the codebase it builds,
    and builds in the folder around it. The codebase is a git repository;
    the factory commits its work there, and leaves its own folder out of
    those commits.

    A new codebase, for an example, is a new git repository with a copy
    of the factory in it. That is how an example keeps out of the codebase
    you are building.

  Rule: Each pass completes one task, then stops

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the first task has been done and validated
      And the other two have not
      And the factory has stopped

  Rule: A pass ends when validation is satisfied

    Example: The work is right first time
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the doer has done the first task
      And validation is satisfied
      And the pass has ended

    Example: The work is wrong first time
      Given a plan with three tasks, none of them done
      And a doer whose first attempt does not satisfy validation
      When the factory runs one pass
      Then the doer has run again
      And the pass ends once validation is satisfied

  Rule: A pass gives up after a set number of attempts

    An attempt is the doer producing work and validation deciding on it.
    A doer and a validator can oscillate, each attempt introducing a new
    problem, so a pass cannot be allowed to run forever. How the limit is
    set is up to the student — a flag, a setting, whatever suits what
    they built. A pass that gives up is not committed: the work is left
    where it is, for whoever comes looking.

    Example: Validation is never satisfied
      Given a factory allowing at most three attempts per pass
      And validation that is never satisfied
      When the factory runs one pass
      Then the doer has made three attempts
      And the factory has stopped
      And it reports that the pass hit its limit
      And there are no new commits

  Rule: The factory commits a pass that ends with validation satisfied

    Example: One pass, one commit
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then there is one new commit

    Example: Finished work is not redone
      Given a plan whose first task is done
      When the factory runs one pass
      Then there is one new commit
      And it contains the work for the second task

  Rule: The factory stops when the plan is complete

    Example: Work remains
      Given a plan with three tasks, none of them done
      When the factory runs to completion
      Then all three tasks have been done
      And the factory has stopped

    Example: Every task is already done
      Given a plan in which every task is done
      When the factory runs to completion
      Then the factory stops without doing any work
      And there are no new commits
