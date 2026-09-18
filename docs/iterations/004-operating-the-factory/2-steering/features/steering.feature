Feature: Steering

  Talking to a machine while it works.

  Rule: A message reaches the machine at its next step

    Example: The doer is mid-attempt
      Given the doer is part-way through an attempt
      When I say "use curses, not print" to the doer
      Then the doer is given the message before its next step
      And the attempt is not abandoned

  Rule: A message names the machine it is for

    More than one machine can be working at once, so there is no such
    thing as "the machine that is running". The names you can use are the
    ones watching reports as running, which is every machine the factory
    has — not only the ones that appear on the assembly line.

    Example: Three reviewers at once
      Given three reviewers are running at the same time
      When I say "be strict about error handling" to the second reviewer
      Then the second reviewer is given the message
      And the other two are not

  Rule: The factory refuses a message to a machine that is not running

    Example: The machine named has not started
      Given the doer is part-way through an attempt
      When I say "be strict about error handling" to the first reviewer
      Then the factory refuses the message
      And it says that the doer is what is running

    Example: Nothing is running
      Given a job that has finished
      When I say "use curses, not print" to the doer
      Then the factory refuses the message
      And it says that nothing is running

  Rule: A message lasts as long as the run that heard it

    Example: The next attempt has not heard it
      Given the doer was told "use curses, not print" during its first attempt
      When the doer makes a second attempt
      Then it is not given that message again

    Example: The reviewers have not heard it either
      Given the doer was told "use curses, not print" during its first attempt
      When the three big brains checks that attempt
      Then no reviewer is given that message

  Rule: A message is part of the record

    Example: Reading back
      Given I told the doer "use curses, not print"
      When I read the job's record
      Then it shows the message
      And that the doer was given it
