# Tutorial slides

This Reveal.js deck introduces the tutorial, gets a student into Homework 1, and previews the capability added by every iteration.

## Preview

From the repository root:

```sh
python3 -m http.server --directory docs 8000
```

Open <http://localhost:8000/slides/>. Use the arrow keys to move, `f` for full screen, `o` for the overview, and `s` for speaker notes.

## Maintain

Use the project skill:

```text
/skill:build-tutorial-slides
```

The source is `index.html`; deck-specific layouts are in `tutorial.css`. The page loads Reveal.js from jsDelivr and the hosted [Lean Software Production Sketchbook kit](https://lean-software-production.github.io/brand/kit/).

After a change, run:

```sh
python3 .agents/skills/build-tutorial-slides/scripts/validate_deck.py
```

The validator checks Reveal and brand integration, local links, onboarding content, and one slide for every numbered directory under `docs/iterations/`.

GitHub Actions publishes `docs/` to GitHub Pages after every push to `main`. The Pages root redirects here, and this repository is configured to use GitHub Actions as its Pages source. If the deck moves to another repository, an administrator must select **GitHub Actions** under **Settings → Pages → Build and deployment → Source** once.
