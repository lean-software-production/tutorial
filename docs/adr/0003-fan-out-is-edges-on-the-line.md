# Fan out is edges on the line

Date: 2026-09-27

## Status

accepted

## Context

In homework 5 the three big brains replaced the validator: a special
machine, ordinary code whose configuration named three reviewers and a
synthesiser, sitting on the course's "careful" line. Every Background
from 005 to 008 inherited it, so features about stopping, watching,
steering, skills and commands were full of reviewers and a synthesiser
they had nothing to do with. From 004 on, the features should specify the
factory's features, not track how the course's own line grows. And the
factory learned one fixed shape, not something a line could use.

## Decision

Fan out and fan in are part of what a line can say, in plain Graphviz
edges. A machine with several unlabelled edges out runs every machine
they lead to, at the same time, each with its own prompt. Each branch's
one unlabelled edge leads to the same machine, which runs once they have
all finished and is given their results and nothing else. The factory
refuses a line whose branches do not meet, and a branch that fails stops
the run. The three big brains stays as the course's example of a fan
out: three reviewers configured alike on different models, meeting at a
synthesiser. The examples run on a single-validator line from 004 on, and
bring in the three big brains only where several machines at once are
the point.

## Consequences

The homework is a graph feature rather than a hard-coded machine, and a
line can fan out to anything. Features from 006 on read as being about
their subject. What makes the reviewers alike is now their configuration,
not the factory. Branches are one machine deep; a longer branch would
need join points worked out from the graph, and the factory refuses one
for now.
