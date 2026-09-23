# The factory, as of this iteration

The factory builds software from a seed. A planner writes the plan, then a
doer makes it one task at a time and the three big brains checks each
attempt, until the plan is complete. You can watch what every machine
generates and what it spends, and talk to a machine while it works.

The factory itself writes none of its machines' work. Each machine calls
a coding agent — an LLM-driven tool such as `pi`, the default — named in
that machine's own configuration, which is also where a stand-in can be
swapped in for quick checks (see `agent.feature`).

Each run is for a **job**, named on the command line. A job is started
with an assembly line, a seed and a target — the codebase it builds, its
own git repository — and remembers all three, so after that its name is
enough. The seed is the assembly line's only input; the name and the
target are for the orchestrator, telling it where to keep the job's
plan and its record (`jobs/<name>/`, never in the target) and where to build. You can stop a
job, and the factory stays up; or stop the factory, and its job stops
with it. Either way the work in flight is interrupted, nothing
half-finished is marked done or committed, and starting the job again by
name carries on from there.

New here: a machine can have skills. A skill is a folder with a `SKILL.md`
in it — a name, a description of what it is for, and the instructions —
and it sits beside the machine that owns it. The doer's skills are the
doer's, and a reviewer's are its own. Skills belong to the machine, not
to the line: a machine brings the same skills to every line it runs on.

A machine starts a run knowing only what its skills are called and what
they are for. It reads a skill's instructions when it judges the task
calls for them, and the skill's own files only when those instructions
point at them. Nothing is paid for before it is needed.

Machines can run commands now, and a skill is what authorises them. A
machine may run a command an activated skill names, and nothing else. No
activated skill, no commands.

New since iteration 4: `skills.feature` and `command-execution.feature`.
Everything else is unchanged.
