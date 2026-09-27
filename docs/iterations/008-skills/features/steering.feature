Feature: Steering

  Talking to a machine while it works. The factory passes the message to
  the running machine with ACP's _session/steering request, as the ACP
  adapters for Claude Code and Codex accept it, and the machine picks it
  up at its next step.

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

  Rule: A message reaches the machine at its next step

    Example: The doer is mid-attempt
      Given the doer is the scripted stand-in
      And a plan with one task, "say started; wait; say finished", not done
      And the "tetris" job is running, with the doer part-way through an attempt
      When I say "use curses, not print" to the doer
      And the held stand-ins are let go
      And the "tetris" job has run to the end
      Then the doer heard "use curses, not print" before it said "finished"
      And there is one new commit

  Rule: A message names the machine it is for

    More than one machine can be working at once, so there is no such
    thing as "the machine that is running". A message names a machine
    that watching shows as running.

    Example: Three reviewers at once
      Given a plan with one task, not done
      And every reviewer is the held stand-in
      And the "tetris" job is running, with every reviewer part-way through
      When I say "be strict about error handling" to reviewer_2
      And the held stand-ins are let go
      And the "tetris" job has run to the end
      Then reviewer_2 heard "be strict about error handling"
      And neither reviewer_1 nor reviewer_3 heard it

  Rule: The factory refuses a message to a machine that is not running

    Example: The machine named has not started
      Given the doer is the scripted stand-in
      And a plan with one task, "wait", not done
      And the "tetris" job is running, with the doer part-way through an attempt
      When I say "be strict about error handling" to reviewer_1
      Then the factory refuses
      And it says that the doer is what is running

    Example: Nothing is running
      Given a plan with one task, not done
      And the factory has run the "tetris" job
      When I say "use curses, not print" to the doer
      Then the factory refuses
      And it says that nothing is running

  Rule: A message lasts as long as the run that heard it

    Example: The next attempt has not heard it
      Given the doer is the scripted stand-in
      And a plan with one task, "wait", not done
      And the synthesiser is the not-satisfied-once stand-in
      And the "tetris" job is running, with the doer part-way through an attempt
      When I say "use curses, not print" to the doer
      And the held stand-ins are let go
      And the "tetris" job has run to the end
      Then the doer has been called twice
      And the doer heard "use curses, not print" once

    Example: The reviewers have not heard it either
      Given the doer is the scripted stand-in
      And a plan with one task, "wait", not done
      And the "tetris" job is running, with the doer part-way through an attempt
      When I say "use curses, not print" to the doer
      And the held stand-ins are let go
      And the "tetris" job has run to the end
      Then no reviewer heard "use curses, not print"

  Rule: A message is part of the record

    Example: Reading back
      Given the doer is the scripted stand-in
      And a plan with one task, "wait", not done
      And the "tetris" job is running, with the doer part-way through an attempt
      When I say "use curses, not print" to the doer
      And the held stand-ins are let go
      And the "tetris" job has run to the end
      And I read the "tetris" job's record
      Then it shows that the doer was told "use curses, not print"
