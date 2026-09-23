Feature: Orchestration

  How the factory runs along its assembly line: which task is next, when
  a task is finished, when to give up and when to stop. These rules do
  not care how validation is done.

  Background:
    Given the factory keeps its jobs in a new, empty folder
    And every target is a new folder

  Rule: The factory works in the target it is given

    The target is the codebase a job builds: its own git repository,
    holding only the product.

    Example: The target is not a git repository yet
      Given a seed and a target folder that is not a git repository
      When the factory runs
      Then the target is a git repository
      And it has a starting commit

  Rule: The factory runs the machines its assembly line gives it

    Example: An assembly line with no validator on it
      Given an assembly line on which the doer goes straight to plan_complete
      And a plan with three tasks, none of them done
      When the factory runs
      Then all three tasks have been done
      And nothing has validated the work

  Rule: Each job runs the assembly line it is given

    A factory can hold more than one assembly line. Which one a job runs
    is chosen when the job starts; a line never names a target.

    Example: Two lines, one factory
      Given an assembly line "careful" on which the doer's work is validated
      And an assembly line "quick" on which the doer goes straight to plan_complete
      When the factory runs the "tetris" job on "careful"
      And the factory runs the "snake" job on "quick"
      Then the "tetris" job's work has been validated
      And nothing has validated the "snake" job's work

  Rule: An assembly line works on any target

    Example: One line, two targets
      Given an assembly line "careful"
      When the factory runs the "tetris" job on "careful" against one target
      And the factory runs the "snake" job on "careful" against another
      Then each target holds only its own job's work

  Rule: The factory does no work on an assembly line it refuses

    Example: The assembly line names a machine the factory does not have
      Given an assembly line naming a machine the factory does not have
      When the factory runs
      Then it stops before doing any work
      And there are no new commits

  Rule: The doer works on one task at a time, in plan order

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs
      Then the second task was started only once the first was done and validated
      And the third only once the second was

  Rule: A task is finished when validation is satisfied

    Example: The work is right first time
      Given a plan with three tasks, none of them done
      And validation that is satisfied by every first attempt
      When the factory runs
      Then the doer has made one attempt at each task

    Example: The work is wrong first time
      Given a plan with three tasks, none of them done
      And validation that is not satisfied by the first attempt at the first task
      When the factory runs
      Then the doer has made two attempts at the first task
      And the second task was started only once the second attempt satisfied validation

  Rule: A task gives up after a set number of attempts

    An attempt is the doer producing work and validation deciding on it.
    A doer and a validator can oscillate, each attempt introducing a new
    problem, so a task cannot be allowed to run forever. The limit belongs
    with the retry it bounds, so it is an attribute of the retry edge on
    the assembly line. A task that gives up is not committed: the work is
    left where it is, for whoever comes looking.

    Example: Validation is never satisfied
      Given an assembly line whose retry edge allows at most three attempts
      And a plan with three tasks, none of them done
      And validation that is never satisfied by the first task
      When the factory runs
      Then the doer has made three attempts at the first task
      And the factory has stopped without starting the second
      And it reports that the first task hit its limit
      And there are no new commits

  Rule: The factory commits each time a task is finished

    Example: Three tasks, three commits
      Given a plan with three tasks, none of them done
      When the factory runs
      Then there are three new commits, one for each task

    Example: Finished work is not redone
      Given a plan whose first task is done
      When the factory runs
      Then no new commit contains work for the first task

  Rule: The factory stops when the plan is complete

    Example: Work remains
      Given a plan with three tasks, none of them done
      When the factory runs
      Then all three tasks have been done
      And the factory has stopped

    Example: Every task is already done
      Given a plan in which every task is done
      When the factory runs
      Then the doer never runs
      And there are no new commits
