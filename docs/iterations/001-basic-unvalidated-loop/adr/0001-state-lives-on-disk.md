# 1. State lives on disk

Date: 2026-09-17

## Status

accepted

## Context

The factory must survive between passes and between runs. The plan has to
remember which tasks are done, and the work in progress has to persist.

## Decision

All state lives in files in the working directory, not in the factory's
code or memory:

- `spec.md` — the seed: the project to build.
- `plan.md` — the plan: the spec broken into tasks, each marked done or not.
- the project's own source files — the work produced so far.

The factory holds nothing in memory between passes. Each pass reads the
files it needs, does one thing, and writes the files back.

## Consequences

The factory can be stopped and restarted freely; a pass is a pure
read-do-write step. The files are the source of truth, so the factory must
read them fresh on every pass rather than caching state.
