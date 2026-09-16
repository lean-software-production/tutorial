Feature: Monitoring

  What the factory is spending, while it spends it.

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
