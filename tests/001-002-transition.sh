#!/usr/bin/env bash
# File/Git integration check, not a factory or real-agent acceptance suite.
# Runs the actual starter fetcher at pinned revisions in a disposable clone.
set -euo pipefail
starter_ref=${STARTER_REF:-ad0919cf9efb8eec966a94fb0f0752699ed1d329}
export COURSE_REF=${COURSE_REF:-572b2797c91c4c414aab309d7f1c36de613bf2d8}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

git clone -q https://github.com/lean-software-production/capstone-project-starter.git "$tmp/student"
cd "$tmp/student"
student_root=$PWD
git checkout -q --detach "$starter_ref"
git config user.name 'Transition test'
git config user.email 'transition-test@example.invalid'
cd tetris/.factory
fetch=../../.agents/skills/fetch-iteration/fetch.sh
bash "$fetch"
grep -qx '001 WIP' ITERATION
test -s ../seeds/tetris.md

# A completed student's game and ignored plan. No real Tetris is built here.
printf 'v1 game source\n' > ../game.txt
printf '# Plan\n- [x] Build terminal Tetris\n' > plan.md
printf '\nplan.md\nevidence/\n' >> .gitignore
printf '001 Done\n' > ITERATION
git add ../game.txt ../seeds/tetris.md .
git commit -qm 'Completed 001 fixture'
git tag tetris-v1
mkdir -p evidence/v1
cp -i ../seeds/tetris.md evidence/v1/seed.md
cp -i plan.md evidence/v1/plan.md

bash "$fetch"
grep -qx '002 WIP' ITERATION
cmp ../game.txt <(printf 'v1 game source\n')
cmp ../seeds/tetris.md evidence/v1/seed.md
cmp plan.md evidence/v1/plan.md
grep -q 'Every task is already done' spec/features/orchestration.feature
printf 'PASS: fetch 001 then 002 preserves game, seed and completed ignored plan\n'

cat >> ../seeds/tetris.md <<'SEED'

Keep the existing Tetris. Add P to pause and resume. While paused, pieces must
not fall or respond to movement keys, and the terminal must show it is paused.
SEED
mv -i plan.md evidence/v1/completed-plan.md
test ! -e plan.md
cmp evidence/v1/plan.md evidence/v1/completed-plan.md
cmp ../game.txt <(printf 'v1 game source\n')
printf 'PASS: revised seed and archived plan leave the game intact\n'

# Simulate subsequent game work; the v1 checkpoint must remain recoverable.
printf 'v2 game source\n' > ../game.txt
git add ../game.txt ../seeds/tetris.md
git commit -qm 'V2 fixture'
git worktree add -q --detach "$tmp/v1-view" tetris-v1
cmp "$tmp/v1-view/tetris/game.txt" <(printf 'v1 game source\n')
cmp "$tmp/v1-view/tetris/seeds/tetris.md" evidence/v1/seed.md
cmp ../game.txt <(printf 'v2 game source\n')
test ! -e "$tmp/v1-view/tetris/.factory/plan.md"
printf 'PASS: detached v1 view restores original source/seed without rolling back v2\n'

# Retaining the game does not obstruct the later factory move in 004.
git add .
git commit -qm 'Adopt 002 fixture spec'
bash "$fetch"
grep -qx '003 WIP' ITERATION
git add .
git commit -qm 'Adopt 003 fixture spec'
bash "$fetch"
cd "$student_root/factory"
grep -qx '004 WIP' ITERATION
test ! -d ../tetris/.factory
cmp ../tetris/game.txt <(printf 'v2 game source\n')
cmp evidence/v1/plan.md evidence/v1/completed-plan.md
printf 'PASS: 003 then 004 retain game and evidence while moving the factory\n'
printf 'Revisions: starter=%s course=%s\n' "$starter_ref" "$COURSE_REF"
