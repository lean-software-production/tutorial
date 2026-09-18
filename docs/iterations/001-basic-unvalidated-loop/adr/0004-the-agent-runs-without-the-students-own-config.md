# 4. The agent runs without the student's own config

Date: 2026-09-17

## Status

accepted

## Context

`pi` discovers `AGENTS.md`/`CLAUDE.md` files up the directory tree,
including a student's own personal, global configuration — not just files
inside the workspace. A student's own instructions there (for example,
"always work in a git worktree") can silently override the factory's
assumptions and break the one-pass-one-commit contract: the plan shows a
task as done, but the code lands on some other branch and the actual
project never changes. The bug this produces looks nothing like its
cause — it took real digging to trace a "task marked done but nothing
changed" report back to an unrelated line in a personal config file.

## Decision

Every call the factory makes to `pi` passes `--no-context-files`. The
agent only ever sees what the factory itself puts in the prompt; it never
picks up anything from a student's own environment.

## Consequences

The factory's behavior no longer depends on what happens to be installed,
or configured, on the machine it runs on. The agent also loses anything
useful a student's personal config might otherwise have offered — but at
this iteration it doesn't need any.
