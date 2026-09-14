Feature: Many validators

  One model has one set of blind spots. The factory now sends the doer's
  work to three validators at once — the same job, the same prompt, three
  different providers' models — and a fourth machine reads all three
  reports and decides.

  The validator's job does not change. Whatever you set it up to look for
  in homework 2, all three now do that same job.

  This file adds to the factory you already built. Everything in
  homework 2 still holds.

  Rule: The same work goes to three validators at once

    Example: Three reports on one piece of work
      Given validators on Anthropic, OpenAI and Google models
      When the factory runs one pass
      Then all three have checked the same work
      And all three were given the same job

  Rule: No two validators use the same provider

    Example: A second Anthropic validator is not a second opinion
      Given a validator on an Anthropic model
      When another validator is added on an Anthropic model
      Then the factory reports that the providers must differ

  Rule: The validators run at the same time

    Example: Three validators that each take five seconds
      Given three validators that each take five seconds to report
      When the factory runs one pass
      Then all three have reported
      And validation took less than ten seconds

  Rule: One machine synthesises the reports and decides

    Example: The reports disagree
      Given three validators, two satisfied and one not
      When the factory runs one pass
      Then a synthesiser has read all three reports
      And the synthesiser decides whether the attempt is satisfied

    Example: Nobody but the synthesiser decides
      Given three validators that are all satisfied
      When the factory runs one pass
      Then the attempt is satisfied because the synthesiser said so

  Rule: A rejected attempt goes back to the doer with the synthesis

    Example: The synthesiser rejects the work
      Given a synthesiser that rejects the doer's work
      When the factory runs one pass
      Then the doer runs again
      And it is given the synthesiser's report, not the three separate ones
