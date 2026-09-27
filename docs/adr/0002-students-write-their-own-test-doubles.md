# Students write their own test doubles

Date: 2026-09-27

## Status

accepted

## Context

The course shipped a folder of stand-in agents, `stand-ins/`, that
fetch-iteration copied into every student's repo, and the feature files
named them: "the validator is the never-satisfied stand-in". They fixed
contracts that no feature stated — the fields of each result, how a
prompt names the plan and the skills, the plan's format — and they
answered with a result whether or not they were asked for one. A factory
could pass every example without its prompts ever asking for a result,
and then fail with a real agent. The students had not written, and often
had not read, the code their checks leaned on.

## Decision

We ship no doubles. The feature files say what a machine does ("the
validator is never satisfied", "the doer is part-way through an
attempt") and never how a check makes it so: no stand-ins, doubles,
holding or letting go. The contract a double would have kept is product
behaviour, specified in `machine.feature`: the factory asks each machine
for the fields its edges route on, and reads the last line of the answer
that is JSON. The iteration READMEs teach test doubles as a practice
where each is first needed, with the rules that keep checks reliable,
and students' agents write the doubles from the examples.

## Consequences

Students own every contract their factory relies on, and a factory that
never asks for a result fails a written rule. The course ships far less
code. Doubles now differ between students and can agree with a student's
own factory while disagreeing with a real agent; the `@real-agent`
examples are what catches that, and the READMEs say so. Students write
more in homework 6, where their doubles must speak ACP. We keep private
doubles to run our own reference factories against the features.
