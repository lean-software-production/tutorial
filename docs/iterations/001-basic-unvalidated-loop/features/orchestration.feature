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

  Rule: The agent does not follow the student's own configuration

    What the factory puts in the prompt is all the agent works from.
    Settings on the machine running the factory — a personal AGENTS.md or
    CLAUDE.md, say — do not reach it.

    Example: The student's own configuration asks for a worktree
      Given my own agent configuration says to always work in a git worktree
      And a plan with three tasks, none of them done
      When the factory runs one pass
      Then there is one new commit on the target's current branch
      And it contains the work for the first task

  Rule: Each pass does one task, then stops

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the first task has been done
      And the other two have not
      And the factory has stopped

  Rule: The factory commits after every pass

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

  Rule: Stopping the factory part-way leaves the job in a sane state

    Stopping is something you choose to do — interrupting a pass that is
    taking too long, say. The factory marks nothing done that isn't and
    commits nothing half-finished, so the next pass can carry on from the
    files. A crash is not a stop; after one, the factory makes a best
    effort to do the same, and no more is asked of it.

    Example: I stop a pass part-way through
      Given a plan with three tasks, none of them done
      When I stop the factory while the doer is working on the first task
      Then the plan shows the first task as not done
      And there are no new commits

    Example: The next pass carries on
      Given I stopped the factory while the doer was working on the first task
      When the factory runs one pass
      Then the doer works on the first task
