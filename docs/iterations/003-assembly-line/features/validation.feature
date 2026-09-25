Feature: Validation

  How the factory decides the doer's work is good enough.

  Background:
    Given a copy of the factory, in a folder of its own inside a new codebase

  Rule: A validator checks the work the doer just produced

    Example: Earlier work is not rechecked
      Given a plan whose first task is done and validated
      When the doer makes its first attempt at the second task
      Then a validator checks the work of that attempt
      And it does not report findings about the first task

  Rule: What a validator looks for is chosen, not fixed

    The student picks the lens a validator brings to the work —
    testability, single responsibility, usability, internationalisation,
    security. The factory does not care which. It is the choice that
    teaches, so this spec leaves it open on purpose.

    Example: A validator that looks at testability
      Given a validator with a lens of testability
      When the doer makes an attempt at a task
      Then its findings are about testability

    Example: A validator that looks at something else
      Given a validator with a lens of internationalisation
      When the doer makes an attempt at a task
      Then its findings are about internationalisation

  Rule: A validator reports findings, and changes neither the plan nor the work

    Example: The first task's work is untestable
      Given a plan with three tasks, none of them done
      And a validator that finds the first task's work untestable
      When the doer makes its first attempt at the first task
      Then the doer is given that finding
      And no validator has changed the plan or the work

  Rule: The doer records each finding as a subtask of the task in progress

    A finding is about the task the doer is working on, so it stays with
    that task. It does not become a new task in the plan, and the task is
    not done until its subtasks are.

    Example: A finding on the first task
      Given a plan with three tasks, none of them done
      And a validator that finds the first task's work untestable
      When the doer makes its first attempt at the first task
      Then the first task has a subtask for that finding
      And the plan still has three tasks

    Example: The next attempt deals with the subtask
      Given a plan whose first task has a subtask for a finding
      And a validator that is satisfied by the doer's second attempt
      When the doer makes its second attempt at the first task
      Then it has done that subtask
      And the first task is done and validated
