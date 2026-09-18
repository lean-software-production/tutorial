# 2. The factory drives a coding agent

Date: 2026-09-17

## Status

accepted

## Context

The factory is meant to build software — Tetris — but the factory itself
does not know how to write a game.

## Decision

The factory does not implement the work. On each pass it hands the current
task to a coding agent (`pi`), which reads the spec and the plan and writes
real code for that task. The factory's job is to orchestrate: pick the
task, invoke the agent, record the result, commit.

## Consequences

The output is real software. But the factory now depends on the agent
being available and doing the work correctly — which, at this iteration,
nothing checks.
