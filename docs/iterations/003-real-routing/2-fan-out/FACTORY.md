# The factory, as of this iteration

The factory builds software from a seed. A planner writes the plan, then
a doer makes it one task at a time and the three big brains checks each
attempt, until the plan is complete.

The factory itself writes none of its machines' work. Each machine calls
a coding agent — an LLM-driven tool such as `pi`, the default — named in
that machine's own configuration, which is also where a stand-in can be
swapped in for quick checks (see `agent.feature`).

The three big brains is one machine on the assembly line, where the
validator used to be. Inside it, the doer's work fans out to three
reviewers on three providers' models at once, and a synthesiser reads
their reports — never the work itself — and decides. The reviewers report;
only the synthesiser decides.

Each run is for a **job**, named on the command line. A job is started
with an assembly line, a seed and a target — the codebase it builds, its
own git repository — and remembers all three, so after that its name is
enough. The seed is the assembly line's only input; the name and the
target are for the orchestrator, telling it where to keep the job's plan
(`jobs/<name>/`, never in the target) and where to build. The factory
can be told to keep its jobs in another folder instead, as its tests do.

Each file knows only its own altitude. `orchestration.feature` says
"validation" and does not care how it is done. `assembly-line.feature`
knows the three big brains is one machine and nothing about what is inside
it. `validation.feature` is what is inside it.

New since part 1: the validator is replaced by the three big brains in
`assembly-line.feature`, and `validation.feature` describes what is inside
it. `planning` and `orchestration` are unchanged.
