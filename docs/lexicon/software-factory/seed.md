# Seed

Depth behind the [`seed`](../software-factory.yaml) entry: what we mean, where
we disagree, and how the rest of the field uses the word. Not published.

## What we mean

A seed is the raw material an assembly line runs on. Whatever the orchestrator feeds in at the front
of an assembly line is that assembly line's seed, which makes something a seed only in
relation to the assembly line it feeds.

Matt, 2026-08-31:

> If you've got a factory, which is like a bunch of machinery, but you need some
> raw materials to go in to put through the factory, and the seed is that.

The framing came to us from Roberto, as "a factory needs a seed and a harness".
The pair matters: the seed sets the direction, the harness keeps the line on it.

## What counts as a seed depends on the line

The intuition that a seed is the spec breaks as soon as the factory is building
something other than features. Matt again, on how his own understanding moved
while writing the "what is a factory" lesson:

> So I was like, oh, so a seed is the spec for what you're building. And then I
> realized, but a factory isn't always building features. It might be like
> porting a codebase from one language to another, in which case the seed is
> the original codebase.

So the seed for a feature line is a spec; for a porting line it is the original
codebase; for a bug-fixing line it is a ticket. Same slot in the machine,
different material.

## Curated, but not everything

Seeds reward care, because everything downstream is built from them. They do not
carry the whole run, though, and the entry should not imply that they do. Matt,
closing the discussion:

> I think the point is that it's heavily curated. It's like the compass bearing
> that you use at the start of a voyage. It's not everything, because the
> harness will continue to steer and correct as the wind and waves take you off
> course. But it's very important.

## Where we do not agree

**Seed against spec and plan.** David's reading, 2026-08-31, was "the initial
prompt you kick off a project with", and on hearing the porting example he said
"then I don't understand what a seed is at all. So that's definitely a
contentious one." He settled on seed, spec and plan being "all the same related
terms that get intermingled."

Matt's distinction, which the entry now leads on:

> I think seeds are only like relevant in the context of a factory, whereas
> plans and specs you can kinda use them more in a REPL style.

This is unresolved. Treat the entry as Matt's reading pending another pass.

## How the field uses it

**strongDM**, <https://factory.strongdm.ai/principles>. Their whole frame is
`Seed → Validation harness → Feedback loop. Tokens are the fuel.`

> Every piece of software needs an initial seed. Historically, you might have
> called this a PRD or a spec. Today, this could equally be a few sentences, a
> screenshot, or an existing codebase.

**Navan**, [How to Build Your Own Software Factory](https://web.navan.dev/posts/2026-05-06-how-to-build-your-own-software-factory.html),
2026-05-06. The bluntest published statement of the variability:

> Whatever goes in is the seed. For a bug-fixing line that's a Jira ticket; for
> a security line it's a CVE advisory plus the list of repos in scope; for a
> flaky-test line it's the test name, its run history, the recent commits, and a
> pile of build logs. Different line, different seed.

And on quality:

> Almost every bad run I've seen started with a bad seed. [...] A vague prompt
> is a vague definition of done, and a vague definition of done means the agent
> never knows when to stop.

Both agree with us that the seed is the entry point and that its content varies
by line. Neither draws Matt's line between a seed and a spec, and neither bounds
the seed the way the compass bearing does.

## Sources

- Matt and David, canvas room, 2026-08-31, 17:58-18:01 and 19:31.
- Matt, July 2026 cohort, `01-from-repl-to-plans`, 01:07:30: "handcraft your
  seed and think carefully about the tokens that are in this file, because this
  is the thing that's going to get amplified by the transformers."
- Matt, July 2026 cohort, `02-load-human-context`, 00:09:49: expanding a small
  seed into a plan requires invention, shrinking a codebase into a summary does
  not.
