Feature: Monitoring

  What the factory is spending, while it spends it.

  Background:
    Given a copy of the factory
    And a new target, with a seed describing a game of Tetris
    And the target has the machines planner, doer and three_big_brains
    And the target has an assembly line "careful" on which the doer's work is validated
    And a job named "tetris", on the "careful" line, with that seed and target
    And the planner is the plan-alpha-beta stand-in
    And the doer is the do-next stand-in
    And every reviewer is the always-satisfied stand-in
    And the synthesiser is the always-satisfied stand-in

  Rule: Tokens are counted for each machine

    Example: The doer and the three big brains
      Given a running job in which the doer and the three big brains have each run
      When I watch the factory
      Then it shows tokens in and tokens out for the doer
      And tokens in and tokens out for the three big brains

  Rule: Tokens are totalled for each provider

    The three big brains puts three providers' models on one attempt, so
    its spend lands on three separate bills. The totals follow the bills.

    Example: Three reviewers on three providers
      Given a running job whose reviewers run on Anthropic, Google and OpenAI models
      When I watch the factory
      Then it shows a total for each of those three providers
      And a total for the whole job

  Rule: The numbers keep up with the job

    Example: The doer attempts the task again
      Given I am watching a running job
      When the doer makes a second attempt
      Then the doer's tokens go up
      And so does the job's total
