Feature: Factory

  The factory builds software from a seed. It plans the work, then makes
  it one task at a time: a doer produces the work, three reviewers assess
  it, and a synthesiser reads their reports and decides — until the plan
  is done.

  The reviewers do not decide anything; they report. Fan out, reviewers,
  synthesiser: together that assembly is the validation step, and that
  assembly is now written down as a graph rather than wired by hand.

  There are two ways to run it. Running one pass takes one task from
  start to checked and stops. Running to completion keeps going until the
  plan is done. The examples below say which they mean.

  Rule: The seed is the factory's only input

    Example: The factory is given a seed and nothing else
      Given a seed describing a game of Tetris that runs in the terminal
      When the factory runs to completion
      Then it builds Tetris

  Rule: The factory creates the plan from the seed

    Example: A seed with no plan yet
      Given a seed describing a game of Tetris
      And no plan
      When the factory runs one pass
      Then a plan exists
      And every task in it comes from the seed
      And none of the tasks are done

    Example: A plan already exists
      Given a plan with four tasks, none of them done
      When the factory runs one pass
      Then the plan still has those four tasks

  Rule: Each pass completes one task, then stops

    Example: Three tasks remain
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the first task has been done and validated
      And the other two have not
      And the factory has stopped

  Rule: A pass ends when the synthesiser is satisfied

    Example: The work is right first time
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the doer has done the first task
      And the synthesiser is satisfied with it
      And the pass has ended

    Example: The work is wrong first time
      Given a plan with three tasks, none of them done
      And a doer whose first attempt does not satisfy the synthesiser
      When the factory runs one pass
      Then the doer has run again
      And the pass ends once the synthesiser is satisfied

  Rule: A pass gives up after a set number of attempts

    A doer and a validator can oscillate, each attempt introducing a new
    problem, so a pass cannot be allowed to run forever. How the limit is
    set is up to the student — a flag, a setting, whatever suits what
    they built.

    Example: The validator is never satisfied
      Given a factory allowing at most three attempts per pass
      And a synthesiser that is never satisfied
      When the factory runs one pass
      Then the doer has made three attempts
      And the factory has stopped
      And it reports that the pass hit its limit

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

    Example: The synthesiser rejects the work
      Given a synthesiser that rejects the doer's work
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

  Rule: The factory maintains the plan

    Example: A pass records the work it did
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then the plan shows the first task as done

    Example: The next pass carries on from the last
      Given a plan whose first task is done
      When the factory runs one pass
      Then the plan shows the first two tasks as done

  Rule: The factory commits after every pass

    Example: One pass, one commit
      Given a plan with three tasks, none of them done
      When the factory runs one pass
      Then there is one new commit

    Example: Finished work is not redone
      Given a plan whose first task is done
      When the factory runs one pass
      Then there is one new commit
      And it contains the work for the second task

  Rule: The factory stops when the plan is complete

    Example: Work remains
      Given a plan with three tasks, none of them done
      When the factory runs to completion
      Then all three tasks have been done
      And the factory has stopped

    Example: Every task is already done
      Given a plan in which every task is done
      When the factory runs to completion
      Then the factory stops without doing any work
      And there are no new commits

  Rule: The route is described as a graph, outside the code that runs it

    Example: The graph the factory already follows
      Given this route:
        """
        digraph factory {
          doer -> reviewer_one
          doer -> reviewer_two
          doer -> reviewer_three
          reviewer_one -> synthesiser
          reviewer_two -> synthesiser
          reviewer_three -> synthesiser
          synthesiser -> plan
        }
        """
      When the factory runs one pass
      Then the doer's work goes to all three reviewers
      And the synthesiser's decision goes to the plan

  Rule: Changing the graph changes what runs

    Example: A fourth reviewer is added
      Given a factory routing to three reviewers
      When a fourth is added to the route
      And the factory runs one pass
      Then the doer's work goes to all four
      And no other part of the factory changed

    Example: A reviewer is removed
      Given a factory routing to three reviewers
      When one is removed from the route
      And the factory runs one pass
      Then the doer's work goes to the remaining two

  Rule: The factory refuses a route it cannot run

    Example: The route names a machine that does not exist
      Given a route naming a reviewer the factory does not have
      When the factory runs
      Then it stops before doing any work
      And it reports which machine is missing
