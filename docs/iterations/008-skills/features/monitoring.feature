Feature: Monitoring

  What the factory is spending, while it spends it. Each machine reports
  the tokens it used, in and out, at the end of every turn: the usage in
  its ACP prompt response. Which provider a machine's model is from is in
  the machine's configuration.

  Background:
    Given a copy of the factory
    And a new target, with a seed describing a game of Tetris
    And the target has the machines planner, doer and three_big_brains
    And the target has an assembly line "careful" on which the doer's work is validated
    And a job named "tetris", on the "careful" line, with that seed and target
    And the planner plans the tasks alpha and beta
    And the doer does the next task in the plan
    And every reviewer is always satisfied
    And the synthesiser is always satisfied

  Rule: Tokens are counted for each machine

    Example: The doer and the three big brains
      Given a plan with one task, not done
      When the factory runs the "tetris" job
      And I watch the "tetris" job
      Then it shows tokens in and tokens out for the doer
      And it shows tokens in and tokens out for the three big brains

  Rule: Tokens are totalled for each provider

    The three big brains puts three providers' models on one attempt, so
    its spend lands on three separate bills. The totals follow the bills.

    Example: Three reviewers on three providers
      Given the reviewers run on Anthropic, Google and OpenAI models
      And a plan with one task, not done
      When the factory runs the "tetris" job
      And I watch the "tetris" job
      Then it shows a total for each of Anthropic, Google and OpenAI
      And it shows a total for the whole job

  Rule: The numbers keep up with the job

    Example: The doer attempts the task again
      Given a plan with one task, not done
      And the synthesiser is not satisfied the first time
      And I am watching the "tetris" job as it runs
      When the "tetris" job has run to the end
      Then what I watched showed the doer's tokens go up
      And what I watched showed the job's total go up
