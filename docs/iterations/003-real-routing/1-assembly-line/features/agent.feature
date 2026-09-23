Feature: The coding agent

  No machine's work is written by the factory. The planner's plan, the
  doer's code and the validator's verdict all come from a coding agent — an
  LLM-driven tool such as pi — that the machine calls. Each machine's
  agent is part of that machine's configuration; pi is the default.

  Several examples give a machine a stand-in agent: one of the small
  programs the course ships in `stand-ins/`, which take what the machine
  hands them and do something simple and predictable. That shows what the machine gives its agent and what it
  does with the answer, and it makes checks fast — other features'
  examples may use a stand-in too. A stand-in is configured from outside,
  the same way pi is; the factory never contains one. Examples that build
  real software need real agents.

  Rule: A machine uses pi unless its configuration names another agent

    Example: The doer is configured with a stand-in
      Given the doer's configuration names a stand-in agent
      And the planner's names no agent
      When the factory runs
      Then the planner has called pi
      And the doer has called the stand-in, and not pi

  Rule: Without an agent, a machine does no work

    Example: The doer's agent cannot be run
      Given a plan with three tasks, none of them done
      And a doer whose agent cannot be run
      When the factory runs
      Then it reports that the doer could not run its agent
      And there are no new commits in the target

  Rule: The plan is what the planner's agent wrote

    Example: A stand-in planner that plans two tasks
      Given a job with no plan
      And a planner configured with the plan-alpha-beta stand-in
      When the factory runs
      Then the plan has the tasks "alpha" and "beta", and no others

  Rule: The target holds what the doer's agent wrote

    Example: A stand-in doer that writes one file
      Given a plan with three tasks, none of them done
      And a doer configured with the write-sentinel stand-in
      When the factory runs
      Then each new commit in the target contains SENTINEL and nothing else

  Rule: The doer's agent is given the task and the seed

    Example: A stand-in doer that records what it is given
      Given a plan whose first task is done and whose second is "add a score display"
      And a doer configured with the record-input stand-in
      When the factory runs
      Then the stand-in was given "add a score display"
      And it was pointed at the seed

  Rule: Validation is what the validator's agent decided

    Example: A stand-in that is never satisfied
      Given an assembly line whose retry edge allows at most three attempts
      And a validator configured with the never-satisfied stand-in
      When the factory runs
      Then the doer has made three attempts at the first task
      And there are no new commits in the target

  Rule: What gets built follows the seed

    A factory that had Tetris tucked away inside it would pass every
    example that asks for Tetris. It would not pass this one.

    Example: A Tetris with different details
      Given a seed describing Tetris on a board 8 columns wide, started with "npm run play"
      When the factory runs the job with real agents
      Then "npm run play" in the target starts Tetris
      And its board is 8 columns wide
