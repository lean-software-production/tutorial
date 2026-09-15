Feature: Validation

  How the factory decides the doer's work is good enough.

  Rule: The same work goes to every reviewer at once

    Three reviewers on three providers' models is the concrete example we
    use — not a knob. What you are building is a fan out and a fan in; the
    three models are what we happen to fan out to.

    Example: Three reports on one piece of work
      When the factory runs one pass
      Then all three reviewers have assessed the same work
      And all three were given the same job

  Rule: The reviewers run at the same time

    Example: Three reviewers that each take five seconds
      Given three reviewers that each take five seconds to report
      When the factory runs one pass
      Then all three have reported
      And validation took less than ten seconds

  Rule: One machine synthesises the reports and decides

    Example: The reports disagree
      Given two reviewers are satisfied and one is not
      When the factory runs one pass
      Then the synthesiser has read all three reports
      And the synthesiser decides whether the attempt is satisfied

    Example: Nobody but the synthesiser decides
      Given every reviewer is satisfied
      When the factory runs one pass
      Then the attempt is satisfied because the synthesiser said so

  Rule: A rejected attempt goes back to the doer with the synthesis

    Example: The synthesiser rejects what the reviewers reported
      Given a synthesiser that rejects the reviewers' reports
      When the factory runs one pass
      Then the doer runs again
      And it is given the synthesiser's report, not the three separate ones

  Rule: The reviewers check the work the doer just produced

    Example: Earlier work is not rechecked
      Given a plan whose first task is done and validated
      When the factory runs one pass
      Then the reviewers check the work done in this pass
      And they do not report findings about the first task

  Rule: What the reviewers look for is chosen, not fixed

    The student picks the lens the reviewers bring to the work —
    testability, single responsibility, usability, internationalisation,
    security. All three reviewers are given the same one. The factory does
    not care which. It is the choice that teaches, so this spec leaves it
    open on purpose.

    Example: Reviewers that look at testability
      Given reviewers with a lens of testability
      When the factory runs one pass
      Then their findings are about testability

  Rule: Validation changes the plan, never the work

    Example: A finding becomes a task
      Given a plan with three tasks, none of them done
      And a synthesis finding the first task's work untestable
      When the factory runs one pass
      Then the plan contains a new task for that finding
      And no reviewer has changed the work itself

    Example: The doer picks up the finding
      Given a plan containing a task that came from a finding
      When the factory runs one pass
      Then the doer has done that task
