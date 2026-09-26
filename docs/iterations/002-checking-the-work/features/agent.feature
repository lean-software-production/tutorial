Feature: Machines

  The factory writes no project code, no plan and no verdict. That work
  is done by three machines — the planner, the doer and the validator —
  each run by a harness: a coding agent such as pi by default, or another
  chosen on the command line for a run. A machine could as well be
  ordinary code; the factory doesn't mind, so long as the machine answers
  with a result: JSON describing the job it did.

  Most examples run a machine with a stand-in: one of the small programs
  the course ships in `stand-ins/`, which take what the factory hands them
  and do something simple and predictable. That shows what the factory
  gives a machine and what it does with the result, and it makes checks
  fast. A stand-in is chosen from outside, the same way pi is; the factory
  never contains one. Examples tagged @real-agent need a real agent; every
  other example runs with stand-ins.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase
    And a seed describing a game of Tetris
    And the planner is the plan-alpha-beta stand-in
    And the doer is the do-next stand-in
    And the validator is the always-satisfied stand-in

  Rule: Each machine runs pi unless another harness is chosen

    Example: No harness is chosen
      Given no harness is chosen
      When the factory runs one pass
      Then pi has been called

    Example: A stand-in is chosen for the run
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the do-next stand-in has been called
      And pi has not been called

  Rule: A machine whose harness cannot be run does no work

    Example: The doer cannot be run
      Given a plan with three tasks, none of them done
      And the doer cannot be run
      When the factory runs one pass
      Then it reports that it could not run the doer
      And there are no new commits

  Rule: The plan is what the planner wrote

    Example: A stand-in that plans two tasks
      Given no plan
      When the factory runs one pass
      Then the plan has the tasks "alpha" and "beta", and no others

  Rule: The codebase holds what the doer wrote

    Example: A stand-in that writes one file
      Given a plan with three tasks, none of them done
      And the doer is the write-sentinel stand-in
      When the factory runs one pass
      Then there is one new commit
      And it contains SENTINEL and nothing else

  Rule: The doer is pointed at the plan and the seed

    The factory cannot hand the doer a task: it never reads the plan. It
    tells the doer where the plan and the seed are, and the doer does the
    rest.

    Example: What the doer is given
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the doer was pointed at the plan and at the seed

  Rule: Validation is what the validator decided

    Example: A stand-in that is never satisfied
      Given a plan with three tasks, none of them done
      And the factory allows at most three attempts per pass
      And the validator is the never-satisfied stand-in
      When the factory runs one pass
      Then the doer has been called three times
      And there are no new commits

  Rule: What gets built follows the seed

    A factory that had Tetris tucked away inside it would pass every
    example that asks for Tetris. It would not pass this one.

    @real-agent
    Example: A Tetris with different details
      Given every machine runs pi
      And a seed describing Tetris on a board 8 columns wide, started with "npm run play"
      When the factory runs to completion
      Then "npm run play" in the codebase starts Tetris
      And its board is 8 columns wide
