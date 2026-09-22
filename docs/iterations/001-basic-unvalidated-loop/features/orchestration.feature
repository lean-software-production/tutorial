Feature: Orchestration

  What a pass is, when it ends, and when the factory stops. These
  rules do not care how validation is done.

  Rule: The factory prepares a workspace to commit to

    Example: No workspace exists yet
      Given a seed and no workspace
      When the factory runs one pass
      Then the workspace is a git repository
      And it has a starting commit

  Rule: The agent does not follow the student's own configuration

    What the factory puts in the prompt is all the agent works from.
    Settings on the machine running the factory — a personal AGENTS.md or
    CLAUDE.md, say — do not reach it.

    Example: The student's own configuration asks for a worktree
      Given my own agent configuration says to always work in a git worktree
      And a plan with three tasks, none of them done
      When the factory runs one pass
      Then there is one new commit on the workspace's current branch
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
