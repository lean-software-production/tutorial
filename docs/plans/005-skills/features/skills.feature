Feature: Skills

  How a machine gets a way of working it was not built with. A skill is a
  folder holding a SKILL.md: a name, a description of what the skill is
  for, and the instructions.

  Rule: A machine's skills are the ones that sit beside it

    Example: The doer and a reviewer have different skills
      Given the doer has the skills "tdd" and "commit-style"
      And the first reviewer has the skill "security-review"
      When the doer starts an attempt
      Then it knows about "tdd" and "commit-style"
      And it does not know about "security-review"

  Rule: A machine starts knowing what its skills are for, and no more

    Example: Two skills, neither of them read yet
      Given the doer has the skills "tdd" and "commit-style"
      When the doer starts an attempt
      Then it has been given the name and description of both
      And the instructions of neither

  Rule: The machine decides when a skill applies

    Nothing matches keywords on its behalf. The machine reads the
    descriptions and judges, which is the same judgement that did the
    routing in homework 1.

    Example: A task the skill is for
      Given the doer has the skill "tdd", described as writing the test first
      And a task to build a board model that is under test
      When the doer attempts the task
      Then it has read the instructions of "tdd"

    Example: A task the skill is not for
      Given the doer has the skill "tdd", described as writing the test first
      And a task to write the README
      When the doer attempts the task
      Then it has not read the instructions of "tdd"

  Rule: A skill's own files are read only when its instructions point at them

    Example: A reference the instructions send it to
      Given the doer has activated "tdd"
      And its instructions point at "references/fixtures.md"
      When the doer follows them
      Then it has read references/fixtures.md

    Example: A file nothing points at
      Given the doer has activated "tdd"
      And the skill also holds "references/history.md", which its instructions never mention
      When the doer follows them
      Then it has not read references/history.md

  Rule: A skill that does not say what it is for is not loaded

    A description is what the machine judges from, so a skill without one
    cannot be chosen. It is left out rather than guessed at.

    Example: A SKILL.md with no description
      Given a skill folder beside the doer whose SKILL.md has no description
      When the doer starts an attempt
      Then it does not know about that skill
      And the record says the skill was skipped, and why

  Rule: What a machine activated is in the record

    Example: Reading back
      Given the doer activated "tdd" during its first attempt
      When I read the job's record
      Then it shows that the doer activated "tdd"
