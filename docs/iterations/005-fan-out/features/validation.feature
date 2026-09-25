Feature: Validation

  How the factory decides the doer's work is good enough. On the assembly
  line that is one machine, the three big brains. This file is about what
  happens inside it.

  Background:
    Given the factory keeps its jobs in a new, empty folder
    And every target is a new folder

  Rule: The same work goes to every reviewer at once

    Three reviewers on three providers' models is the concrete example we
    use — not a knob. What you are building is a fan out and a fan in; the
    three models are what we happen to fan out to.

    Example: Three reports on one attempt
      When the doer makes an attempt at a task
      Then all three reviewers have assessed the same work
      And all three were given the same job

  Rule: The reviewers run at the same time

    Example: Three reviewers that each take five seconds
      Given three reviewers that each take five seconds to report
      When the doer makes an attempt at a task
      Then all three have reported
      And validation took less than ten seconds

  Rule: One machine synthesises the reports and decides

    Example: The reports disagree
      Given two reviewers are satisfied and one is not
      When the doer makes an attempt at a task
      Then the synthesiser has read all three reports
      And the synthesiser decides whether the attempt is satisfied

    Example: Nobody but the synthesiser decides
      Given every reviewer is satisfied
      When the doer makes an attempt at a task
      Then the attempt is satisfied because the synthesiser said so

  Rule: The synthesiser decides from the reports, not the work

    Example: What the synthesiser is given
      When the doer makes an attempt at a task
      Then the synthesiser has been given the three reports
      And it has not been given the work

  Rule: A rejected attempt goes back to the doer with the synthesis

    Example: The synthesiser rejects the first attempt
      Given a synthesiser that rejects the doer's first attempt
      When the doer makes its first attempt at a task
      Then the doer is given the synthesiser's report, not the three separate ones

  Rule: The reviewers check the work the doer just produced

    Example: Earlier work is not rechecked
      Given a plan whose first task is done and validated
      When the doer makes its first attempt at the second task
      Then the reviewers check the work of that attempt
      And they do not report findings about the first task

  Rule: What the reviewers look for is chosen, not fixed

    The student picks the lens the reviewers bring to the work —
    testability, single responsibility, usability, internationalisation,
    security. All three reviewers are given the same one. The factory does
    not care which. It is the choice that teaches, so this spec leaves it
    open on purpose.

    Example: Reviewers that look at testability
      Given reviewers with a lens of testability
      When the doer makes an attempt at a task
      Then their findings are about testability

  Rule: Validation changes neither the plan nor the work

    Example: The first task's work is untestable
      Given a plan with three tasks, none of them done
      And a synthesiser that finds the first task's work untestable
      When the doer makes its first attempt at the first task
      Then no reviewer or synthesiser has changed the plan or the work

  Rule: The doer records each finding as a subtask of the task in progress

    A finding is about the task the doer is working on, so it stays with
    that task. It does not become a new task in the plan, and the task is
    not done until its subtasks are.

    Example: A finding on the first task
      Given a plan with three tasks, none of them done
      And a synthesiser that finds the first task's work untestable
      When the doer makes its first attempt at the first task
      Then the first task has a subtask for that finding
      And the plan still has three tasks

    Example: The next attempt deals with the subtask
      Given a plan whose first task has a subtask for a finding
      And a synthesiser that is satisfied by the doer's second attempt
      When the doer makes its second attempt at the first task
      Then it has done that subtask
      And the first task is done and validated
