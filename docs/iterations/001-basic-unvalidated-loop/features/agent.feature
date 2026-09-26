Feature: The coding agent

  The factory writes no project code and no plan. Both come from a coding
  agent — an LLM-driven tool such as pi — that the factory calls. Every
  call it makes goes to that agent. pi is the default; another agent can
  be chosen on the command line for a run.

  Most examples swap in a stand-in agent: one of the small programs the
  course ships in `stand-ins/`, which take what the factory hands them and
  do something simple and predictable. That shows what the factory gives
  the agent and what it does with the answer, and it makes checks fast. A
  stand-in is chosen from outside, the same way pi is; the factory never
  contains one. Examples tagged @real-agent need a real agent; every other
  example runs with stand-ins.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase
    And a seed describing a game of Tetris
    And the agent is the ralph-alpha-beta stand-in

  Rule: pi is the agent unless another is chosen

    Example: No agent is chosen
      Given no agent is chosen
      When the factory runs one pass
      Then pi has been called

    Example: A stand-in is chosen for the run
      When the factory runs one pass
      Then the ralph-alpha-beta stand-in has been called
      And pi has not been called

  Rule: Without an agent, nothing is built

    Example: The chosen agent cannot be run
      Given the agent cannot be run
      And no plan
      When the factory runs one pass
      Then it reports that it could not run the agent
      And there is no plan
      And there are no new commits

  Rule: The plan is what the agent wrote

    Example: A stand-in that plans two tasks
      Given no plan
      When the factory runs one pass
      Then the plan has the tasks "alpha" and "beta", and no others

  Rule: The codebase holds what the agent wrote

    Example: A stand-in that writes one file
      Given a plan with three tasks, none of them done
      And the agent is the write-sentinel stand-in
      When the factory runs one pass
      Then there is one new commit
      And it contains SENTINEL and nothing else

  Rule: The agent is pointed at the plan and the seed

    The factory cannot hand the agent a task: it never reads the plan. It
    tells the agent where the plan and the seed are, and the agent does
    the rest.

    Example: What the agent is given
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the agent was pointed at the plan and at the seed

  Rule: What gets built follows the seed

    A factory that had Tetris tucked away inside it would pass every
    example that asks for Tetris. It would not pass this one.

    @real-agent
    Example: A Tetris with different details
      Given the agent is pi
      And a seed describing Tetris on a board 8 columns wide, started with "npm run play"
      When the factory runs to completion
      Then "npm run play" in the codebase starts Tetris
      And its board is 8 columns wide
