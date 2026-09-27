Feature: Skills

  How a machine gets a way of working it was not built with. A skill is a
  folder holding a SKILL.md: a name, a description of what the skill is
  for, and the instructions. A machine's skills sit in its own folder, in
  .assembly-lines/.machines/<name>/skills/.

  A machine activates a skill by reading its SKILL.md. The factory sees
  the read in the machine's ACP tool calls, whose locations name the files
  read.

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

  Rule: A machine's skills are the ones that sit beside it

    Example: The doer and a reviewer have different skills
      Given the doer has the skills "tdd" and "commit-style"
      And reviewer_1 has the skill "security-review"
      And a plan with one task, not done
      When the factory runs the "tetris" job
      Then the doer was given "tdd"
      And the doer was given "commit-style"
      And the doer was not given "security-review"

    Example: The doer brings the same skills to every line
      Given the doer has the skills "tdd" and "commit-style"
      And the target has an assembly line "quick" on which the doer goes straight to the planner
      And a job named "quick", on the "quick" line, with that seed and target
      And a plan for each job with three tasks of its own, none of them done
      When the factory runs the "quick" job
      Then the doer was given "tdd"
      And the doer was given "commit-style"

  Rule: A machine starts knowing what its skills are for, and no more

    Example: Two skills, neither of them read yet
      Given the doer has the skills "tdd" and "commit-style"
      And a plan with one task, not done
      When the factory runs the "tetris" job
      Then the doer was given the name and description of "tdd" and of "commit-style"
      And it was given the instructions of neither

  Rule: The machine decides when a skill applies

    Nothing matches keywords on its behalf. The machine reads the
    descriptions and judges, which is the same judgement that did the
    routing in homework 1.

    @real-agent
    Example: A task the skill is for
      Given every machine runs pi
      And the doer has the skill "tdd", described as writing the test first
      And a plan with one task, "build a board model that is under test", not done
      When the factory runs the "tetris" job
      Then the doer activated "tdd"

    @real-agent
    Example: A task the skill is not for
      Given every machine runs pi
      And the doer has the skill "tdd", described as writing the test first
      And a plan with one task, "write the README", not done
      When the factory runs the "tetris" job
      Then the doer did not activate "tdd"

  Rule: A skill's own files are read only when its instructions point at them

    @real-agent
    Example: A reference the instructions send it to
      Given every machine runs pi
      And the doer has the skill "tdd", whose instructions point at "references/fixtures.md"
      When the doer activates "tdd" and follows it
      Then the doer read references/fixtures.md

    @real-agent
    Example: A file nothing points at
      Given every machine runs pi
      And the doer has the skill "tdd", which also holds "references/history.md" that its instructions never mention
      When the doer activates "tdd" and follows it
      Then the doer did not read references/history.md

  Rule: A skill that does not say what it is for is not loaded

    A description is what the machine judges from, so a skill without one
    cannot be chosen. It is left out rather than guessed at.

    Example: A SKILL.md with no description
      Given the doer has a skill "mystery" whose SKILL.md has no description
      And a plan with one task, not done
      When the factory runs the "tetris" job
      Then the doer was not given "mystery"
      And the "tetris" job's record says the skill "mystery" was skipped, and why

  Rule: What a machine activated is in the record

    Example: Reading back
      Given the doer has the skills "tdd" and "commit-style"
      And the doer is the scripted stand-in
      And a plan with one task, "read tdd", not done
      When the factory runs the "tetris" job
      And I read the "tetris" job's record
      Then it shows that the doer activated "tdd"
      And it does not show that the doer activated "commit-style"
