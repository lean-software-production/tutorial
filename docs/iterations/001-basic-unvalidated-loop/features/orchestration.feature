Feature: Orchestration

  What a pass is, when it ends, and when the factory stops. These
  rules do not care how validation is done.

  Background:
    Given a copy of the factory
    And a new target
    And a seed describing a game of Tetris
    And the agent plans the tasks alpha and beta, and does one task a pass

  Rule: The factory works in the target selected on the command line

    The factory source lives in factory/. The target argument selects a
    plain output folder. Agent calls work there. The factory uses the
    containing Git repository and initializes one only if none contains
    the target. Both staging and committing are limited to the target's
    paths, excluding .factory/plan.md. Unrelated staged and unstaged
    changes, including the student's factory edits, are left alone.

    Each example uses a fresh factory copy and a separate target. That
    keeps checks out of both your factory and your generated games.

  Rule: Each pass does one task, then stops

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the plan shows the first task as done
      And the plan shows the other two as not done
      And the factory has stopped

  Rule: The factory commits after every pass that does a task

    Example: One pass, one commit
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then there is one new commit
      And it contains the work for the first task

    Example: Finished work is not redone
      Given a plan whose first task is done
      When the factory runs one pass
      Then there is one new commit
      And it contains the work for the second task

  Rule: The factory stops when the agent says the plan is complete

    The agent keeps the plan, so only the agent knows when it is
    complete. It says so in its result: a small piece of JSON describing
    the job it did, such as {"complete": true}. The factory reads the
    result's fields; it never looks for words in what the agent says.

    Example: Work remains
      Given a plan with three tasks, none of them done
      When the factory runs to completion
      Then the plan shows every task as done
      And there are three new commits
      And the factory has stopped

    Example: Every task is already done
      Given a plan in which every task is done
      When the factory runs to completion
      Then the agent has been called once
      And there are no new commits
      And the factory has stopped

  Rule: The factory stops at a result it cannot read

    Example: The agent answers in prose
      Given a plan with three tasks, none of them done
      And the agent answers in prose, with no result
      When the factory runs one pass
      Then it reports that it could not read the agent's result
      And there are no new commits
      And the factory has stopped
