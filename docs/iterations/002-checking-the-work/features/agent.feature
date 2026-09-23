Feature: The coding agent

  The factory writes no project code and no plan. Both come from a coding
  agent — an LLM-driven tool such as pi — that the factory calls. Every call it makes — for the plan, for each task, and to check the work —
  goes to that agent. pi is the default; another agent can be chosen on
  the command line for a run.

  Several examples swap in a stand-in agent: a small program that takes
  what the factory hands it and does something simple and predictable.
  That shows what the factory gives the agent and what it does with the
  answer, and it makes checks fast — other features' examples may use a
  stand-in too. A stand-in is chosen from outside, the same way pi is;
  the factory never contains one. Examples that build real software need
  a real agent.

  Rule: pi is the agent unless another is chosen

    Example: No agent is chosen
      Given a job named "tetris"
      When the factory runs one pass of the "tetris" job
      Then pi has been called

    Example: A stand-in is chosen for the run
      Given a job named "tetris"
      When the factory runs one pass of the "tetris" job with a stand-in agent
      Then the stand-in has been called
      And pi has not

  Rule: Without an agent, nothing is built

    Example: The chosen agent cannot be run
      Given a job named "tetris" with no plan
      And an agent that cannot be run
      When the factory runs one pass of the "tetris" job with that agent
      Then it reports that it could not run the agent
      And there is no plan
      And there are no new commits in the target

  Rule: The plan is what the agent wrote

    Example: A stand-in that plans two tasks
      Given a job named "tetris" with no plan
      And a stand-in agent that, asked for a plan, gives the tasks "alpha" and "beta"
      When the factory runs one pass with the stand-in
      Then the plan has the tasks "alpha" and "beta", and no others

  Rule: The target holds what the agent wrote

    Example: A stand-in that writes one file
      Given a plan with three tasks, none of them done
      And a stand-in agent that writes a file called SENTINEL and nothing else
      When the factory runs one pass with the stand-in
      Then the new commit in the target contains SENTINEL and nothing else

  Rule: The agent is given the task and the seed

    Example: A stand-in that records what it is given
      Given a plan whose first task is done and whose second is "add a score display"
      And a stand-in agent that records what it is given
      When the factory runs one pass with the stand-in
      Then the stand-in was given "add a score display"
      And it was pointed at the seed

  Rule: Validation is what the agent decided

    Example: A stand-in that is never satisfied
      Given a factory allowing at most three attempts per pass
      And a stand-in agent that, asked to check work, is never satisfied
      When the factory runs one pass with the stand-in
      Then the doer has made three attempts
      And there are no new commits in the target

  Rule: What gets built follows the seed

    A factory that had Tetris tucked away inside it would pass every
    example that asks for Tetris. It would not pass this one.

    Example: A Tetris with different details
      Given a seed describing Tetris on a board 8 columns wide, started with "npm run play"
      When the factory runs the job to completion with a real agent
      Then "npm run play" in the target starts Tetris
      And its board is 8 columns wide
