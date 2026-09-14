Feature: Fan out

  One model has one set of blind spots. The factory now sends the doer's
  work to three validators at once and a fourth machine reads all three
  reports and decides.

  Three validators on three providers' models is the concrete example we
  use — not a knob. What you are building is a fan out and a fan in; the
  three models are what we happen to fan out to.

  The validator's job does not change. Whatever you set it up to look for
  in homework 2, all three now do that same job.

  This file adds to the factory you already built. Everything in
  homework 2 still holds, except where it says otherwise.

  Rule: The same work goes to every validator at once

    Example: Three reports on one piece of work
      When the factory runs one pass
      Then all three validators have checked the same work
      And all three were given the same job

  Rule: The validators run at the same time

    Example: Three validators that each take five seconds
      Given three validators that each take five seconds to report
      When the factory runs one pass
      Then all three have reported
      And validation took less than ten seconds

  Rule: One machine synthesises the reports and decides

    Example: The reports disagree
      Given two validators are satisfied and one is not
      When the factory runs one pass
      Then a synthesiser has read all three reports
      And the synthesiser decides whether the attempt is satisfied

    Example: Nobody but the synthesiser decides
      Given every validator is satisfied
      When the factory runs one pass
      Then the attempt is satisfied because the synthesiser said so

  Rule: A rejected attempt goes back to the doer with the synthesis

    Example: The synthesiser rejects the work
      Given a synthesiser that rejects the doer's work
      When the factory runs one pass
      Then the doer runs again
      And it is given the synthesiser's report, not the three separate ones
