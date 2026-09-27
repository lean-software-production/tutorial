Feature: Observability

  Reading what the machines generate. Each machine streams what it
  generates to the factory as it goes, and the factory keeps it all in the
  job's record: every line, which machine it came from, and what each
  machine spent.

  A machine an example sees at work, part-way through or in a job just
  started, goes on working until the example says it finishes, or the job
  is stopped or run to the end.

  Background:
    Given a copy of the factory
    And a new target, with a seed describing a game of Tetris
    And the target has the machines planner, doer and validator
    And the target has an assembly line "careful" on which the doer's work is validated
    And a job named "tetris", on the "careful" line, with that seed and target
    And the planner plans the tasks alpha and beta
    And the doer does the next task in the plan
    And the validator is always satisfied

  Rule: What a machine generates can be read while it is generating it

    Example: The doer is working
      Given a plan with one task, not done
      And the doer says "first line", then "second line"
      And the "tetris" job is running, with the doer part-way through an attempt, having said "first line"
      When I watch the "tetris" job
      Then I see "first line" from the doer
      And I do not see "second line"

  Rule: Every line says which machine generated it

    Example: Three reviewers reporting at once
      Given the three big brains has replaced the validator on the "careful" line
      And every reviewer is always satisfied
      And the synthesiser is always satisfied
      And a plan with one task, not done
      When the factory runs the "tetris" job
      And I watch the "tetris" job
      Then I see "satisfied" from reviewer_1, reviewer_2 and reviewer_3

  Rule: Watching says which machines are running now

    Example: During fan out
      Given the three big brains has replaced the validator on the "careful" line
      And every reviewer is always satisfied
      And the synthesiser is always satisfied
      And a plan with one task, not done
      And the "tetris" job is running, with every reviewer part-way through
      When I watch the "tetris" job
      Then it shows reviewer_1, reviewer_2 and reviewer_3 as running

  Rule: Attaching late catches you up

    Example: Well into the job
      Given a plan with one task, not done
      And the "tetris" job is running, with the doer part-way through an attempt, having said "started"
      When I watch the "tetris" job
      Then I see what the planner generated
      And I see "started" from the doer

  Rule: Watching shows when a job is stopped

    Example: The job is stopped while I watch
      Given a plan with one task, not done
      And the "tetris" job is running, with the doer part-way through an attempt
      And I am watching the "tetris" job
      When I stop the "tetris" job
      Then what I am watching shows that the "tetris" job was stopped

  Rule: The record outlives the job

    Example: A job that has finished
      Given a plan with one task, not done
      When the factory runs the "tetris" job
      And I read the "tetris" job's record
      Then it shows what every machine generated
      And it shows what every machine spent
      And the record is in the job's folder in the factory, not in the target
