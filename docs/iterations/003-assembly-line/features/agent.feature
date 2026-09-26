Feature: The coding agent

  No machine's work is written by the factory. The planner's plan, the
  doer's code and the validator's verdict all come from a coding agent — an
  LLM-driven tool such as pi — that the machine calls. Each machine's
  agent is part of that machine's configuration; pi is the default.

  Most examples give a machine a stand-in agent: one of the small programs
  the course ships in `stand-ins/`, which take what the machine hands them
  and do something simple and predictable. That shows what the machine
  gives its agent and what it does with the answer, and it makes checks
  fast. A stand-in is configured from outside, the same way pi is; the
  factory never contains one. Examples tagged @real-agent need a real
  agent; every other example runs with stand-ins.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase
    And a seed describing a game of Tetris
    And the planner's agent is the plan-alpha-beta stand-in
    And the doer's agent is the do-next stand-in
    And the validator's agent is the always-satisfied stand-in

  Rule: A machine uses pi unless its configuration names another agent

    Example: The validator's configuration names no agent
      Given a plan with three tasks, none of them done
      And no agent is chosen for the validator
      When the factory runs
      Then pi has been called
      And the do-next stand-in has been called

  Rule: Without an agent, a machine does no work

    Example: The doer's agent cannot be run
      Given a plan with three tasks, none of them done
      And the doer's agent cannot be run
      When the factory runs
      Then it reports that it could not run the agent
      And there are no new commits

  Rule: The plan is what the planner's agent wrote

    Example: A stand-in that plans two tasks
      Given no plan
      When the factory runs
      Then the plan has the tasks "alpha" and "beta", and no others

  Rule: The codebase holds what the doer's agent wrote

    Example: A stand-in that writes a file for each task
      Given a plan with three tasks, none of them done
      When the factory runs
      Then there are three new commits
      And each new commit contains the work for one task

  Rule: The doer's agent is pointed at the plan and the seed

    The factory cannot hand the doer a task: it never reads the plan. It
    tells the doer where the plan and the seed are, and the doer does the
    rest.

    Example: What the doer's agent is given
      Given a plan with three tasks, none of them done
      When the factory runs
      Then the doer's agent was pointed at the plan and at the seed

  Rule: Validation is what the validator's agent decided

    Example: A stand-in that is never satisfied
      Given a plan with three tasks, none of them done
      And the assembly line's retry edge allows at most three attempts
      And the validator's agent is the never-satisfied stand-in
      When the factory runs
      Then the doer has been called three times
      And there are no new commits

  Rule: What gets built follows the seed

    A factory that had Tetris tucked away inside it would pass every
    example that asks for Tetris. It would not pass this one.

    @real-agent
    Example: A Tetris with different details
      Given every agent is pi
      And a seed describing Tetris on a board 8 columns wide, started with "npm run play"
      When the factory runs
      Then "npm run play" in the codebase starts Tetris
      And its board is 8 columns wide
