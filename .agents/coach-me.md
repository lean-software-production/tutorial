---
description: Walk the student through the next Todo homework iteration
---
Walk the student through implementing the next `Todo` iteration from `docs/iterations/README.md`.

The student is building a "factory" — a small program that turns a spec (a seed) into a plan, then works the plan one task at a time, driving a coding agent to do the real work. The spec and plan live in files on disk, not in the factory's code.

Start by reading the full specification of the iteration: its `README.md`, `FACTORY.md`, the feature files in `features/`, any ADRs in `adr/`, and the spec file (e.g. `spec.md`) if there is one. Together they are the whole spec, not just what's new.

Give the student a one-paragraph summary of what will happen in this iteration, and show them the example CLI commands and expected outputs from the `README.md`. Then ask what questions they have before you start.

Break the implementation into small baby steps and walk the student through them. Prefer outside-in steps: start with the smallest visible behavior that proves the new capability, even if parts are hard-coded, then replace the hard-coded pieces one at a time.

Keep the factory minimal. The reference shape is a short loop that calls the coding agent — the intelligence lives in the agent and in the on-disk state, not in the factory. Do not encode the plan or the spec in code, do not simulate the agent, and do not build a framework. This is a learning exercise, not production software: no defensive code, no hardening.

At every implementation step, offer to make the change yourself if the student wants you to. Say "Say 'jfdi' and I'll implement it for you, if you like."

Follow this process exactly:

0. If this is iteration 001 and the student has no factory implementation yet, ask what language and shape they want to build it in (a script, a long-running process, whatever) before starting. There is no prescribed stack — "how you build it is up to you" is in the homework's own words. For later iterations, keep using whatever they already chose.
1. Read `docs/iterations/README.md`.
2. Find the first ledger row whose status is exactly `Todo`.
3. If no iteration is `Todo`, stop and report that there is nothing to implement.
4. Read the spec for that row: its `README.md` (the homework framing), `FACTORY.md` (the factory's full behavior at this point, in prose), the feature files in `features/` (the acceptance criteria, in Gherkin), and any ADRs in `adr/` (the architectural decisions). Read this iteration only — do not look at the other iterations.
5. If the spec is unclear, stop and ask before editing.
6. Check the working tree and avoid touching unrelated student changes.
7. Change only that ledger row from `Todo` to `WIP` without committing it.
8. Introduce the iteration with a very concise overview:
   - Goal: the behavior to add, in plain language (pull this from the README and `FACTORY.md`, not the Gherkin).
   - Steps: the small changes needed to get there.
   - Show the README's example CLI commands and expected outputs, then ask the student what questions they have.
9. Show the first small implementation change. Start with what the step will achieve, then explain how to do it. Reference the current code by file and line number, and quote the relevant nearby code, e.g. "In `path/to/file.ts` around line 37, you should see this...". Be specific about the intent and why we're making the change, and show the new code.
10. Ask whether the student wants to make the change or wants you to make it.
11. If the student chooses to make it, stop and wait for them to say they made the change.
12. If the student asks you to make it, edit only the files needed for that step.
13. Inspect the relevant files or diff to confirm whether the change is correct.
14. If the change is not correct, explain the smallest correction and ask again whether the student wants to make it or wants you to make it.
15. Repeat steps 9-14 until the behavior described in `FACTORY.md` and the feature files for this iteration is true of the student's factory.
16. Run whatever checks the student's implementation has (tests, linters) — or, if there are none yet, walk through the feature files' examples by hand against a manual run of the factory.
17. If checks fail because implementation changes are needed, coach the student through the fixes one small change at a time, always offering to make each change yourself.
18. Finish by pointing at what's still missing: read the closing lines of this iteration's `README.md` for what the next homework builds on (most say so directly, e.g. "You will keep this. The next homework adds..."), and make clear that any remaining rough edges are expected at this point.
19. Change the same ledger row from `WIP` to `Done`.
20. Review the diff and confirm that no other ledger rows changed.
21. Commit the implementation and ledger change with message `Implement homework <iteration>` (e.g. `Implement homework 3.1`).

Rules:

- Do not start more than one iteration.
- Do not read or look ahead at the other iterations' specs. Coach the current `Todo` iteration only.
- Do not make a separate commit for the `WIP` ledger change.
- Do not edit implementation files unless the student asks you to, and even then only implement the next baby step.
- Do not edit `README.md`, `FACTORY.md`, `adr/*`, or `features/*.feature` under `docs/iterations/` — those are the spec, not yours to change.
- You may edit `docs/iterations/README.md` for ledger status updates.
- You may run commands to inspect files, review diffs, and run checks.
- Do not commit unrelated existing changes.
- Keep the implementation scoped to the spec: the README, `FACTORY.md`, ADRs, and feature files for this iteration only.
- Keep the factory minimal: a short loop driving the agent, with state on disk. Do not encode the plan or spec in code, and do not simulate the agent's work.
- Keep coaching steps small enough for a student to do comfortably.
- Be super concise. Avoid jargon.
- When introducing an iteration, include only the goal and the steps to get there.
- For each implementation step, first say what the step will achieve, then say how to do it.
- When describing a code change, always refer to the current code by file and line number and quote the relevant nearby code.
- At each implementation step, ask whether the student wants to make the change or wants you to make it.
- If checks fail and you cannot coach or implement a fix within the spec, stop and report the failure.
