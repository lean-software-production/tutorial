---
name: build-tutorial-slides
description: Build or update the Reveal.js orientation deck for the Lean Software Production tutorial. Use when asked to create, revise, validate or publish the tutorial slides, explain the course journey, change onboarding steps, or add an iteration to the deck.
---

# Build the tutorial slides

Build a static Reveal.js deck in `docs/slides/`. It introduces students to the tutorial, gets them through the first iteration, and shows how every iteration grows their software factory.

Work from the repository root. Do not add a JavaScript build system: the deck is plain HTML and CSS and GitHub Pages publishes `docs/` directly.

## 1. Read the source of truth

Before changing the deck, read:

- `README.md`
- `docs/iterations/README.md`
- every `docs/iterations/[0-9][0-9][0-9]-*/README.md`
- the current starter instructions at <https://github.com/lean-software-production/capstone-project-starter>

The iteration files define the course. Do not invent capabilities, commands or ordering from memory. Discover all numbered iteration directories rather than assuming there are seven.

For setup details, prefer the starter repository's current `README.md`. Students fork and clone that repository; they do not clone this tutorial repository.

## 2. Refresh the brand guidance

Read the current brand guidance and asset catalogue:

```sh
curl -fsSL https://raw.githubusercontent.com/lean-software-production/brand/main/README.md
curl -fsSL https://lean-software-production.github.io/brand/kit/index.json
```

Use the hosted Sketchbook kit:

```html
<link rel="stylesheet" href="https://lean-software-production.github.io/brand/kit/sketchbook.css">
<script src="https://lean-software-production.github.io/brand/kit/sketchbook.js" defer></script>
```

Follow the brand, not a loose imitation:

- warm paper, wobbly ink, pastel washes
- Luckiest Guy for title capitals, Patrick Hand SC for labels, Patrick Hand for prose
- kit roles and colour modifiers; no invented colours or fonts
- one idea per slide, familiar object icons first, characters only as supporting cast
- plain, direct instructions; never cutesy, salesy or full of unexplained jargon
- body text must remain readable and high contrast

Use whole SVG files from the brand catalogue. Never edit, recolour or redraw them. If an image is decorative, use `alt=""`; otherwise write useful alt text.

## 3. Shape the narrative

The deck needs three acts:

1. **Orientation** — show the destination and the learning rhythm. The overall story is a progression from a small agent loop, through explicit composition, to an observable and steerable factory.
2. **Start now** — show how to fork and rename the starter, clone the fork, run `bin/doctor`, enter `tetris/.factory`, start Pi/Claude Code/Codex, then say `fetch iteration` and `coach me`. Explain how to run the factory produced by Homework 1.
3. **The journey** — give each iteration its own slide. State the pressure it introduces and the concrete capability the factory gains. Finish with the complete capability stack and the course's working rules.

Keep the deck useful without a presenter. Put optional presenter context in `<aside class="notes">`, not in dense slide copy.

Use student-facing words. Introduce a term when it first matters. Prefer “what you can do now” over an implementation inventory.

## 4. Implement with Reveal.js

Maintain these files:

- `docs/slides/index.html` — semantic slide content and Reveal initialization
- `docs/slides/tutorial.css` — deck-only layouts and brand-compatible overrides
- `docs/slides/README.md` — local preview and maintenance notes

Use Reveal.js 5.1.0 from jsDelivr, 1600×900, URL hashes, slide numbers and a restrained fade transition. Keep the deck navigable by keyboard. Do not put essential information behind fragments or animation. Respect reduced-motion preferences.

Keep links usable in the published deck. External links open in a new tab with `rel="noopener noreferrer"`. Use relative URLs for files under `docs/`.

`docs/index.html` redirects the Pages root to `slides/`; preserve that route. `.github/workflows/pages.yml` publishes `docs/` on pushes to `main`.

## 5. Check the result

Run the repository's deck validator:

```sh
python3 .agents/skills/build-tutorial-slides/scripts/validate_deck.py
```

Preview from the same root GitHub Pages serves:

```sh
python3 -m http.server --directory docs 8000
```

Open <http://localhost:8000/slides/> and inspect at least:

- 1600×900 desktop framing
- a narrow browser window
- every setup command
- each iteration slide
- keyboard navigation and speaker notes (`s`)
- no clipped text, stretched illustrations or broken links

If iteration feature files changed, also follow `AGENTS.md` and run `bin/step-drift`. Slide-only changes do not require `bin/step-drift`.
