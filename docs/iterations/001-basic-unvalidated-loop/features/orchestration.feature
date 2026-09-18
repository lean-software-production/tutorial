Feature: Orchestration

  What a pass is, when it ends, and when the factory stops. These
  rules do not care how validation is done.

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
