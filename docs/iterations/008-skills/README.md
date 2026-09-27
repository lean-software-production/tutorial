# Homework 8 — Skills

Read `FACTORY.md`, then the feature files in `features/`. Together they
are the whole spec of the factory at this point, not just the new parts.

You are implementing an open standard this time: <https://agentskills.io>.
A skill is a folder with a `SKILL.md` in it, holding a name, a description
of what the skill is for and when to use it, and the instructions
themselves. Read the specification before you start. The format is small;
the loading is where the work is.

The part that is not in the standard is the gate. This homework takes
away your machines' own shells and gives them one back through the
factory, bounded in the same breath: a machine may run a command that an
activated skill names, and nothing else. A skill is then two things at
once — how to do the job, and the authority to do it.

- **Where skills live.** A machine's skills sit in its own folder:
  `.assembly-lines/.machines/<name>/skills/<skill>/SKILL.md`. The factory
  gives the machine each one's name, description and path, and nothing
  more.
- **Activation.** A machine activates a skill by reading its `SKILL.md`.
  The factory sees the read in the machine's ACP tool calls, whose
  `locations` name the files read.
- **The gate.** The factory names an MCP server of its own in ACP's
  `session/new`, with one tool, `run_command`, and switches off the
  harness's own shell (each harness has a setting for it). The tool runs
  a command only if an activated skill names its program.

Write at least two skills and give them to different machines: something
you always want the doer to do, and something you want a reviewer to look
for. Give one of them a script in `scripts/` and see what your gate makes
of it.

The three-step loading is the other half of the homework, and homework 6
is how you check it. Watch a job: a machine that has not activated a skill
should not be paying for that skill's instructions.

## Doubles that read and ask

A double activates a skill the way a real agent does: it reads the
`SKILL.md`, as an ACP tool call whose `locations` name the file. And it
asks to run a command by calling the `run_command` tool on the MCP server
your factory named in `session/new`, never by running it itself.
