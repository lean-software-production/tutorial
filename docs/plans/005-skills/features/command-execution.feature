Feature: Command execution

  Machines can run commands, and an activated skill is what authorises
  them. What no activated skill names, the machine cannot run.

  Rule: A machine may run a command an activated skill names

    Example: The skill says to run the test suite
      Given the doer has activated a skill whose instructions say to run "pytest -q"
      When the doer runs "pytest -q"
      Then the command runs

    Example: The skill says to run one of its own scripts
      Given the doer has activated a skill whose instructions say to run "scripts/coverage.py --min 80"
      When the doer runs that script
      Then the command runs

  Rule: Naming a command authorises the program, not the exact line

    A machine that has been told to run "pytest -q" will sooner or later
    want "pytest -x" instead, and refusing it teaches nothing. The program
    is the unit of authority.

    Example: The same program, different arguments
      Given the doer has activated a skill whose instructions say to run "pytest -q"
      When the doer runs "pytest tests/test_board.py -x"
      Then the command runs

  Rule: A machine may not run a command no activated skill names

    Example: A command the skill never mentions
      Given the doer has activated a skill whose instructions say to run "pytest -q"
      When the doer tries to run "rm -rf build"
      Then the command does not run
      And the doer is told that no activated skill names it
      And the record shows the refusal

  Rule: A machine with no activated skill runs nothing

    Example: Before any skill is activated
      Given the doer has activated no skill
      When the doer tries to run "pytest -q"
      Then the command does not run

  Rule: Authority lasts as long as the run that read the skill

    Example: The next attempt starts closed
      Given the doer activated a skill naming "pytest -q" during its first attempt
      When the doer makes a second attempt
      And tries to run "pytest -q" before activating anything
      Then the command does not run
