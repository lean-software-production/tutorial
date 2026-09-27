Feature: Observability

  Reading what the machines generate. Each machine streams what it
  generates to the factory as it goes, and the factory keeps it all in the
  job's record: every line, which machine it came from, and what each
  machine spent.

  Background:
    Given a copy of the factory
    And a new target, with a seed describing a game of Tetris
    And the target has the machines planner, doer and three_big_brains
    And the target has an assembly line "careful" on which the doer's work is validated
    And a job named "tetris", on the "careful" line, with that seed and target
    And the planner is the plan-alpha-beta stand-in
    And the doer is the do-next stand-in
    And every reviewer is the rubber-stamp stand-in
    And the synthesiser is the always-satisfied stand-in

  Rule: What a machine generates can be read while it is generating it

    Example: The doer is working
      Given the doer is the scripted stand-in
      And a plan with one task, "say first line; sleep 3; say second line", not done
      And the "tetris" job is running, with the doer part-way through an attempt
      When I watch the "tetris" job
      Then I see "first line" from the doer
      And I do not see "second line"

  Rule: Every line says which machine generated it

    Example: Three reviewers reporting at once
      Given a plan with one task, not done
      And every reviewer is the slow-satisfied stand-in, taking two seconds
      When the factory runs the "tetris" job
      And I watch the "tetris" job
      Then I see "checking" from reviewer_1, reviewer_2 and reviewer_3

  Rule: Watching says which machines are running now

    Example: During fan out
      Given a plan with one task, not done
      And every reviewer is the slow-satisfied stand-in, taking two seconds
      And the "tetris" job is running, with every reviewer part-way through
      When I watch the "tetris" job
      Then it shows reviewer_1, reviewer_2 and reviewer_3 as running

  Rule: Attaching late catches you up

    Example: Well into the job
      Given the doer is the scripted stand-in
      And a plan with one task, "say started; sleep 3", not done
      And the "tetris" job is running, with the doer part-way through an attempt
      When I watch the "tetris" job
      Then I see what the planner generated
      And I see "started" from the doer

  Rule: Watching shows when a job is stopped

    Example: The job is stopped while I watch
      Given the doer is the scripted stand-in
      And a plan with one task, "sleep 5", not done
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
