Feature: Many validators

  One validator with one lens only sees one kind of problem. The factory
  now sends the doer's work to several validators at once, each with its
  own lens — and its own model, so they genuinely disagree.

  This file adds to the factory you already built. Everything in
  homework 2 still holds.

  Rule: The work goes to every validator, not one after another

    Example: Three lenses on the same work
      Given validators for testability, security and usability
      When the factory runs one pass
      Then all three have checked the same work
      And none of them waited for another to finish

  Rule: Validators do not share a model

    Example: Two validators, two models
      Given a validator for testability running on one model
      And a validator for security running on a different model
      When the factory runs one pass
      Then each validator's findings come from its own model

  Rule: An attempt is satisfied only when every validator is satisfied

    Example: One validator objects
      Given validators for testability and security
      And work that satisfies the security validator but not the
        testability one
      When the factory runs one pass
      Then the attempt is not satisfied
      And the doer runs again

  Rule: Every validator's findings reach the plan

    Example: Two validators both find something
      Given validators for testability and security
      And work that satisfies neither
      When the factory runs one pass
      Then the plan contains a task for the testability finding
      And the plan contains a task for the security finding
