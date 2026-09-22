Feature: Observability

  Reading what the machines generate.

  Rule: What a machine generates can be read while it is generating it

    Example: The doer is working
      Given I am watching a running job
      When the doer generates a line
      Then I see it without waiting for the attempt to end

  Rule: Every line says which machine generated it

    Example: Three reviewers reporting at once
      Given a running job in which three reviewers are reporting at the same time
      When I watch the factory
      Then each line says which machine it came from

  Rule: Watching says which machines are running now

    Example: During fan out
      Given a running job in which three reviewers are running at the same time
      When I watch the factory
      Then it shows all three as running

  Rule: Attaching late catches you up

    Example: Ten minutes in
      Given a running job whose planner has finished and whose doer is on its second attempt
      When I watch the factory
      Then I see what the planner generated
      And what the doer generated in its first attempt

  Rule: Watching shows when a job is stopped

    Example: The job is stopped while I watch
      Given I am watching the running "tetris" job
      When I stop the "tetris" job
      Then I see that it was stopped

  Rule: The record outlives the job

    Example: The job finished yesterday
      Given a job that ran to completion yesterday
      When I read its record
      Then it shows what every machine generated
      And what every machine spent
      And the record is in the job's folder in the factory, not in the target
