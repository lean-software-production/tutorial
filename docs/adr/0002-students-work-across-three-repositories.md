# 2. Students work across three repositories

Date: 2026-09-22

## Status

proposed

## Context

Students have been working inside the course repo, next to every
iteration's spec. A student's factory, the course material and the
software the factory builds each need their own history; mixing them let
one person's progress (a homework marked `Done`) get committed for
everyone.

## Decision

There are three kinds of repository:

- **Course** — this repo. Read-only for students; they `git pull` it for
  new homeworks and fixes.
- **Factory** — the student's own repo: their factory, its assembly lines,
  its jobs' state, and the snapshot of the iteration spec it is currently
  built against.
- **Target** — the codebase a job works on, one per job or more.

The coaching prompt runs in the student's factory repo. It reads specs
from the course repo, copies the current iteration's snapshot in, and
tracks the student's progress there, not in the course ledger.

The course ships Tetris as a **sample seed**. Students write their own
assembly lines.

How the factory treats jobs, targets and lines is behaviour, and is
specified in each iteration's feature files, not here.

## Consequences

The course, the student's factory and the software it builds can each be
committed, pulled and thrown away independently.

The coaching prompt, and the course ledger's role, need rewriting to
match.
