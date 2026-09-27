Feature: Validation

  How the factory decides the doer's work is good enough. On the assembly
  line that is one machine, the three big brains. This file is about what
  happens inside it.

  The three big brains is a machine the factory runs itself: ordinary
  code, not an agent. Its configuration names the machines it runs — three
  reviewers, reviewer_1 to reviewer_3, and a synthesiser — each configured
  in .assembly-lines/.machines/ like any other. It answers with the
  synthesiser's result.

  Background:
    Given a copy of the factory
    And a new target, with a seed describing a game of Tetris
    And the target has the machines planner, doer and three_big_brains
    And the target has an assembly line "careful" on which the doer's work is validated
    And a job named "tetris", on the "careful" line, with that seed and target
    And the planner plans the tasks alpha and beta
    And the doer does the next task in the plan
    And every reviewer is always satisfied
    And the synthesiser is always satisfied

  Rule: The same work goes to every reviewer at once

    Three reviewers on three providers' models is the concrete example we
    use — not a knob. What you are building is a fan out and a fan in; the
    three models are what we happen to fan out to.

    Example: Three reports on one attempt
      Given a plan with one task, not done
      When the factory runs the "tetris" job
      Then every reviewer has been called once
      And every reviewer was given the same prompt

  Rule: The reviewers run at the same time

    No reviewer waits for another to finish before it starts. Reviewers
    that each wait until all three have begun can only finish if they run
    at the same time.

    Example: Reviewers that wait for each other
      Given a plan with one task, not done
      And no reviewer finishes until all three have begun
      When the factory runs the "tetris" job
      Then every reviewer has been called once
      And there is one new commit

  Rule: One machine synthesises the reports and decides

    Example: The reports disagree
      Given a plan with one task, not done
      And the second reviewer is not satisfied, with the finding "report 1"
      When the factory runs the "tetris" job
      Then the synthesiser was given "report 1"
      And there is one new commit

    Example: Nobody but the synthesiser decides
      Given a plan with three tasks, none of them done
      And the factory allows at most three attempts at a task
      And the synthesiser is never satisfied
      When the factory runs the "tetris" job
      Then the doer has been called three times
      And there are no new commits

  Rule: The synthesiser decides from the reports, not the work

    Example: What the synthesiser is given
      Given a plan with one task, not done
      And every reviewer is not satisfied, with a finding of its own: "report 1", "report 2" or "report 3"
      When the factory runs the "tetris" job
      Then the synthesiser was given "report 1", "report 2" and "report 3"
      And it was not given the work for the first task

  Rule: A rejected attempt goes back to the doer with the synthesis

    Example: The synthesiser rejects the doer's first attempt
      Given a plan with one task, not done
      And every reviewer is not satisfied, with a finding of its own: "report 1", "report 2" or "report 3"
      And the synthesiser is not satisfied the first time
      When the factory runs the "tetris" job
      Then the doer was given the validator's findings
      And it was not given "report 1"

  Rule: The reviewers check the work the doer just produced

    Example: Earlier work is not rechecked
      Given a plan whose first task is done
      When the factory runs the "tetris" job
      Then every reviewer was given the work for the second task
      And it was not given the work for the first task

  Rule: What the reviewers look for is chosen, not fixed

    The student picks the lens the reviewers bring to the work —
    testability, single responsibility, usability, internationalisation,
    security. All three reviewers are given the same one. The factory does
    not care which. It is the choice that teaches, so this spec leaves it
    open on purpose.

    Example: The lens goes to every reviewer
      Given a plan with one task, not done
      And the reviewers' lens is testability
      When the factory runs the "tetris" job
      Then every reviewer was given "testability"

    @real-agent
    Example: Reviewers that look at testability
      Given every machine runs pi
      And the reviewers' lens is testability
      When the factory runs the "tetris" job
      Then the reviewers' findings are about testability

  Rule: Validation changes neither the plan nor the work

    @real-agent
    Example: The first task's work is untestable
      Given every machine runs pi
      And the reviewers' lens is testability
      When the doer's first attempt at a task is untestable
      Then no reviewer or synthesiser has changed the plan or the work

  Rule: The doer records each finding as a subtask of the task in progress

    A finding is about the task the doer is working on, so it stays with
    that task. It does not become a new task in the plan, and the task is
    not done until its subtasks are.

    @real-agent
    Example: A finding on the first task
      Given every machine runs pi
      And the reviewers' lens is testability
      When the doer's first attempt at a task is untestable
      Then that task has a subtask for the finding
      And the plan has no new task
