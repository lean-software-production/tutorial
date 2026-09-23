# Homework 7 — Skills

*Set after day 5.*

Read `FACTORY.md`, then the feature files in `features/`. Together they
are the whole spec of the factory at this point, not just the new parts.

You are implementing an open standard this time: <https://agentskills.io>.
A skill is a folder with a `SKILL.md` in it, holding a name, a description
of what the skill is for and when to use it, and the instructions
themselves. Read the specification before you start. The format is small;
the loading is where the work is.

The part that is not in the standard is the gate. Your machines cannot run
commands at all today. This homework gives them that and bounds it in the
same breath: a machine may run a command that an activated skill names,
and nothing else. A skill is then two things at once — how to do the job,
and the authority to do it.

Write at least two skills and give them to different machines: something
you always want the doer to do, and something you want a reviewer to look
for. Give one of them a script in `scripts/` and see what your gate makes
of it.

The three-step loading is the other half of the homework, and homework 5
is how you check it. Watch a job: a machine that has not activated a skill
should not be paying for that skill's instructions.
