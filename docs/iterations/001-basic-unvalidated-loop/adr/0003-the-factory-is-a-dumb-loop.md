# 3. The factory is a dumb loop

Date: 2026-09-17

## Status

accepted

## Context

It is tempting to build a framework — task queues, planners, storage
layers. The factory's only job is to turn a crank a fixed number of times.

## Decision

The factory is a short loop around a single agent call. All intelligence
lives in the agent and in the on-disk state (spec and plan). The reference
shape is a handful of lines:

    for pass in 1 2 3 4 5; do
      pi -p < prompt.md
    done

The language is irrelevant; the shape is the point.

## Consequences

The factory stays small and easy to read.
