Feature: Command execution

  Machines run commands only through the factory. The factory gives each
  machine a run_command tool, on an MCP server it names in ACP's
  session/new, and switches off the machine's own shell. An activated
  skill is what authorises a command: what no activated skill names, the
  factory refuses to run.

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

  Rule: A machine may run a command an activated skill names

    Example: The skill says to run the test suite
      Given the doer has a skill "tdd" whose instructions say to run "pytest -q"
      And the doer is the scripted stand-in
      And a plan with one task, "read tdd; run pytest -q", not done
      When the factory runs the "tetris" job
      Then the factory ran "pytest -q" for the doer

    Example: The skill says to run one of its own scripts
      Given the doer has a skill "coverage" whose instructions say to run "scripts/coverage.py --min 80"
      And the doer is the scripted stand-in
      And a plan with one task, "read coverage; run scripts/coverage.py --min 80", not done
      When the factory runs the "tetris" job
      Then the factory ran "scripts/coverage.py --min 80" for the doer

  Rule: Naming a command authorises the program, not the exact line

    A machine that has been told to run "pytest -q" will sooner or later
    want "pytest -x" instead, and refusing it teaches nothing. The program
    is the unit of authority.

    Example: The same program, different arguments
      Given the doer has a skill "tdd" whose instructions say to run "pytest -q"
      And the doer is the scripted stand-in
      And a plan with one task, "read tdd; run pytest tests/test_board.py -x", not done
      When the factory runs the "tetris" job
      Then the factory ran "pytest tests/test_board.py -x" for the doer

  Rule: A machine may not run a command no activated skill names

    Example: A command the skill never mentions
      Given the doer has a skill "tdd" whose instructions say to run "pytest -q"
      And the doer is the scripted stand-in
      And a plan with one task, "read tdd; run rm -rf build", not done
      When the factory runs the "tetris" job
      Then the factory refused "rm -rf build" for the doer
      And the doer was told that no activated skill names it
      And the "tetris" job's record shows the refusal

  Rule: A machine with no activated skill runs nothing

    Example: Before any skill is activated
      Given the doer has a skill "tdd" whose instructions say to run "pytest -q"
      And the doer is the scripted stand-in
      And a plan with one task, "run pytest -q", not done
      When the factory runs the "tetris" job
      Then the factory refused "pytest -q" for the doer

  Rule: Authority lasts as long as the run that read the skill

    Example: The next attempt starts closed
      Given the doer has a skill "tdd" whose instructions say to run "pytest -q"
      And the doer is the scripted stand-in
      And a plan with one task, "on attempt 1: read tdd; run pytest -q", not done
      And the synthesiser is the not-satisfied-once stand-in
      When the factory runs the "tetris" job
      Then the factory ran "pytest -q" for the doer once
      And the factory refused "pytest -q" for the doer once
