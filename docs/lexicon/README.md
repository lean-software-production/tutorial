# Lexicon

The vocabulary this repo uses, one file per bounded context. Each file is YAML:
the top-level key is the term's stable identifier (and, for the published
file, its public URL fragment), and the value carries the displayed `term`, a
Markdown `definition` of one to three sentences, and an optional `sortAs` for
terms that do not sort naturally. When you write, use these terms rather than
synonyms, and link a term on first use.

A term whose depth outgrows three sentences gets a Markdown file beside its
context, at `<context>/<key>.md`, named for the same key. It holds the fuller
reading, where we disagree, and how the rest of the field uses the word, and the
entry points at it with a trailing `[→ ...]` reference. Only terms that need
one have one. These files are not mounted by Hugo, so they are not published
(see [ADR-0016](../../decisions/0016-lexicon-term-depth-files.md)).

There are two bounded contexts here:

- [software-factory.yaml](software-factory.yaml) — **what we teach about**:
  the language of hands-off, agentic software development. Harness, machine,
  factory, doer, validator, RAG, context window and the rest. This is the
  participant's vocabulary, and it is rendered at
  [/lexicon/](https://lean-software-production-website.pages.dev/lexicon/)
  straight from this file (see
  [ADR-0014](../../decisions/0014-render-lexicon-from-structured-materials-data.md)).
  Anything you add here is public on the next deploy, at `/lexicon/#<key>`.

- [teaching.yaml](teaching.yaml) — **how we teach**: the adult-learning theory
  and facilitation models behind the workshop format. Andragogy, the Kolb
  cycle, the Dreyfus model, Four Cs, cognitive load. This is the instructors'
  and workshop-design agents' vocabulary. It is not published.

Writing for participants, use the first. Designing a workshop, runbook or
exercise, use both. The Factory Radar keeps its own terms in
[factory-radar/CONTEXT.md](../../factory-radar/CONTEXT.md);
[CONTEXT-MAP.md](../../CONTEXT-MAP.md) lists every context.

Why two files rather than one tagged document: the two vocabularies were split
on 2026-08-30 so that a visitor looking up *harness* is not offered
*andragogy* next to it, and the website mount is the publication boundary —
what is public is exactly what `website/hugo.toml` mounts, with no filter
logic anywhere ([ADR-0015](../../decisions/0015-lexicon-home-and-split.md)).
