Feature: Orchestration

  What a pass is, when it ends, and when the factory stops. These
  rules do not care how validation is done.

  Rule: The factory works in the target it is given

    The target is the codebase a job builds: its own git repository,
    holding only the product.

    Example: The target is not a git repository yet
      Given a seed and a target folder that is not a git repository
      When the factory runs one pass
      Then the target is a git repository
      And it has a starting commit

  Rule: The doer and the validator do not follow the student's own configuration

    What the factory puts in a prompt is all the agent works from.
    Settings on the machine running the factory — a personal AGENTS.md or
    CLAUDE.md, say — do not reach it.

    Example: The student's own configuration asks for a worktree
      Given my own agent configuration says to always work in a git worktree
      And a plan with three tasks, none of them done
      When the factory runs one pass
      Then there is one new commit on the target's current branch
      And it contains the work for the first task

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
