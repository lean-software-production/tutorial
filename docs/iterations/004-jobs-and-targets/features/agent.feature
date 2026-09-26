Feature: Machines

  No machine's work is written by the factory. The planner, the doer and
  the validator are machines on the line. Each has a name, and a harness
  that runs it: a coding agent such as pi by default, or another named in
  the machine's configuration. Machines are configured in the target, in
  .assembly-lines/.machines/, under their names; every line in a target
  that names the doer runs the same doer. A machine could as well be
  ordinary code. Whatever runs it, a machine answers with a result: JSON
  describing the job it did.

  Most examples run a machine with a stand-in: one of the small programs
  the course ships in `stand-ins/`, which take what the factory hands them
  and do something simple and predictable. That shows what the factory
  gives a machine and what it does with the result, and it makes checks
  fast. A stand-in is chosen from outside, the same way pi is; the factory
  never contains one. Examples tagged @real-agent need a real agent; every
  other example runs with stand-ins.

  Background:
    Given a copy of the factory
    And a new target, with a seed describing a game of Tetris
    And the target has the machines planner, doer and validator
    And the target has an assembly line "careful" on which the doer's work is validated
    And a job named "tetris", on the "careful" line, with that seed and target
    And the planner is the plan-alpha-beta stand-in
    And the doer is the do-next stand-in
    And the validator is the always-satisfied stand-in

  Rule: A machine runs pi unless its configuration names another harness

    Example: The validator's configuration names no harness
      Given a plan with three tasks, none of them done
      And no harness is chosen for the validator
      When the factory runs the "tetris" job
      Then pi has been called
      And the do-next stand-in has been called

  Rule: A machine whose harness cannot be run does no work

    Example: The doer cannot be run
      Given a plan with three tasks, none of them done
      And the doer cannot be run
      When the factory runs the "tetris" job
      Then it reports that it could not run the doer
      And there are no new commits

  Rule: The plan is what the planner wrote

    Example: A stand-in that plans two tasks
      Given no plan
      When the factory runs the "tetris" job
      Then the plan has the tasks "alpha" and "beta", and no others

  Rule: The target holds what the doer wrote

    Example: A stand-in that writes a file for each task
      Given a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then there are three new commits
      And each new commit contains the work for one task

  Rule: The doer is pointed at the plan and the seed

    The factory cannot hand the doer a task: it never reads the plan. It
    tells the doer where the plan and the seed are, and the doer does the
    rest.

    Example: What the doer is given
      Given a plan with three tasks, none of them done
      When the factory runs the "tetris" job
      Then the doer was pointed at the plan and at the seed

  Rule: Validation is what the validator decided

    Example: A stand-in that is never satisfied
      Given a plan with three tasks, none of them done
      And the factory allows at most three attempts at a task
      And the validator is the never-satisfied stand-in
      When the factory runs the "tetris" job
      Then the doer has been called three times
      And there are no new commits

  Rule: What gets built follows the seed

    A factory that had Tetris tucked away inside it would pass every
    example that asks for Tetris. It would not pass this one.

    @real-agent
    Example: A Tetris with different details
      Given every machine runs pi
      And a seed describing Tetris on a board 8 columns wide, started with "npm run play"
      When the factory runs the "tetris" job
      Then "npm run play" in the target starts Tetris
      And its board is 8 columns wide
