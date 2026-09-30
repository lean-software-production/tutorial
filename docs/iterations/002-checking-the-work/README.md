# Homework 2 — Checking the work

Read `FACTORY.md`, then the feature files in `features/`, and make them
true of the factory you built for homework 1. Together they are the whole
spec, not just the new parts: the rules you already satisfied are still
there, and some of them have changed. A pass is no longer one agent
call: a planner keeps the plan, a doer does the work and a validator
checks it. Your one prompt from homework 1 splits in three.

Before you start, pick what your validator should look for. Testability,
single responsibility, usability, internationalisation, security — any
lens will do, and the interesting part is what your factory does with the
findings. Choose one and write it down.

Make the lens concrete enough to check. For testability, you might ask:
"Can the new control be tested through an ordinary module API, without a
live terminal or replacing process and timer globals?"

Your doubles now play three machines. A validator's double answers with
whether it is satisfied and, if not, why: the fields `satisfied` and
`findings` that `machine.feature` has your factory ask for.

## Save v1 before fetching 002

Iterations 001 and 002 are both due this weekend. Keep your playable Tetris
from 001 as v1. Run `npm start` from `tetris/` and take a screenshot.

From the repository root, inspect `git status`, stage your game, seed and
factory source changes, and commit them. Do not commit credentials,
`node_modules`, or other generated files.

Check that all files needed to run the game are tracked. Then create a local
checkpoint:

```sh
git tag tetris-v1
```

If that tag already exists, inspect it rather than replacing it. Save the
completed plan too: it may be ignored by Git, so the tag alone may not
contain it. From `tetris/.factory`:

```sh
mkdir -p evidence/v1
# Stop if either destination already exists; keep the earlier evidence.
cp -i ../seeds/tetris.md evidence/v1/seed.md
cp -i plan.md evidence/v1/plan.md
```

Keep these copies locally; you do not need to submit the whole plan.

Now say "fetch iteration" in your coding agent. Fetching 002 replaces the
spec and progress marker, not your Tetris, seed or plan.

If you already fetched 002 without changing the game, save v1 now and
continue below; do not fetch again (that would adopt 003).

If you have already changed the game, use `git log` to find the last playable
001 commit. Tag that commit with `git tag tetris-v1 <commit>` instead of
tagging today's version.

If v1 was never saved and cannot be recovered, ask an instructor; do not
label your new game as the original v1.

## Make a small v2, without deleting v1

First upgrade the factory and make the 002 feature suite pass. The suite
uses new codebases: passing it does not mean your existing Tetris was
checked.

A completed 001 plan stays complete, and running the upgraded
factory against it stops without calling the doer. That is expected.

Give the factory some new work instead:

1. In `tetris/seeds/tetris.md`, keep the original game requirements and add
   one small change to the existing game. Do not ask for a rewrite.

   For example: "Keep the existing Tetris. Add P to pause and resume. While
   paused, pieces must not fall or respond to movement keys, and the terminal
   must show that it is paused."

   Choose a change your validator can examine through your chosen lens.
   For testability, pause is something you can check without a live terminal
   or a real-time wait.

   Check v1 first: if it already meets that requirement, choose a different
   change, such as N to show/hide the next-piece preview without changing
   the board or consuming the next piece.

2. Make sure your validator receives the lens you wrote down. The seed
   describes what to build; the lens describes how the validator checks
   the doer's new work. The validator does not retrospectively review all
   of v1.

3. After saving the v1 plan above, move the completed `plan.md` out of the
   way. From `tetris/.factory`:

   ```sh
   # Stop if this destination already exists; do not overwrite it.
   mv -i plan.md evidence/v1/completed-plan.md
   ```

   Do not delete the game or uncheck the old tasks. The next pass should
   create a new `plan.md` from the revised seed, with tasks for the change
   to the existing game. Inspect that plan before continuing.

   If it plans a rebuild or no new work, stop and clarify the seed/planner
   prompt; keep v1 intact. The factory itself still never reads the plan.

4. Run subsequent passes with the real planner, doer and validator. Keep
   one validator finding, the doer's response, and the resulting code diff
   or test. Use the actual validator output, not a finding reconstructed by
   the doer.

   A finding should become a subtask of the task in progress, not a separate
   new task.

   If the attempt limit is reached, keep the work and findings, diagnose the
   problem, and rerun; do not call v2 complete yet.

5. Run the resulting game with `npm start` from `tetris/` and try the new
   behaviour. Take a v2 screenshot. Run its tests as well.

   For a lens such as testability, the visible game may look almost unchanged:
   explain the code/test change, rather than claiming the screenshot proves it.

If the validator reports no findings, do not invent one or force a failure.
Check that it actually ran with your lens and saw the new work. Keep its
result and explain honestly what it checked.

If you cannot identify any code difference attributable to the lens, ask an
instructor before
claiming this part is complete.

To run v1 again without rolling back your upgraded factory, open a separate
copy from the repository root (pick a different path if this one exists):

```sh
git worktree add --detach ../tetris-v1-view tetris-v1
cd ../tetris-v1-view/tetris
# Install dependencies using the game's own instructions, if needed.
npm start
```

Do not use `git reset --hard` or delete `tetris/`. Stay in your original
checkout to continue 002. Jobs and separate targets arrive in 004; you do
not need them for this homework.

## Submit one Maven project

Include:

- A screenshot of playable Tetris v1 from 001 and a screenshot of playable
  Tetris v2 from 002, labelled so we can tell them apart.
- The validator lens you chose and the small seed change you made for v2.
- A concrete explanation of what difference the lens made to the code:
  a validator finding, how the doer addressed it, and the relevant code
  diff or test result. Distinguish the feature you requested from the
  change the validator prompted. If there were no findings, include the
  result and discuss it with an instructor as described above.

Keep both versions and your upgraded factory for the next session.
