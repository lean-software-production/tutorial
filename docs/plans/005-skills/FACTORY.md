# The factory, as of this iteration

The factory builds software from a seed. A planner writes the plan, then a
doer makes it one task at a time and the three big brains checks each
attempt, until the plan is complete. You can watch what every machine
generates and what it spends, and talk to a machine while it works.

New here: a machine can have skills. A skill is a folder with a `SKILL.md`
in it — a name, a description of what it is for, and the instructions —
and it sits beside the machine that owns it. The doer's skills are the
doer's, and a reviewer's are its own.

A machine starts a run knowing only what its skills are called and what
they are for. It reads a skill's instructions when it judges the task
calls for them, and the skill's own files only when those instructions
point at them. Nothing is paid for before it is needed.

Machines can run commands now, and a skill is what authorises them. A
machine may run a command an activated skill names, and nothing else. No
activated skill, no commands.

New since iteration 4: `skills.feature` and `command-execution.feature`.
Everything else is unchanged.
