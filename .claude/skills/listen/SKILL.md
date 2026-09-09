---
name: listen
description: Use when asked to listen, catch up, or do what was just said out loud - reads the room's recent voice transcript and acts on the instruction in it
---

# Listen

Read the last few minutes of the room's voice transcript and do what was
said. The room is talking faster than they can type; this is how a spoken
instruction reaches you.

## Run It

```sh
.claude/skills/listen/scripts/recent-transcript 5   # minutes, default 5
```

Widen the window if the tail starts mid-thought. Speech-to-text is lossy:
expect mangled jargon and read through it. "Rough loop", "route loop" and
"Ralph loop" are the same thing.

## Act On It

1. Find the **latest** instruction. Earlier talk is context, not the ask.
2. Take the decision they landed on, not the options they explored on the
   way. Discarded ideas sound identical to chosen ones in a transcript.
3. Say in one line what you heard before you do it, so a mishearing is
   caught cheaply.
4. Do it. Ask only if two readings would send you somewhere genuinely
   different.

## Watch For

- **They were talking to each other, not to you.** Then there is no
  instruction. Report what you heard and stop.
- **They answered a question you asked.** Fold the answers in; do not
  re-ask.
- **"Don't do that yet."** A held-back idea is a decision. Respect it.
