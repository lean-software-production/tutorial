# Shared by the stand-ins that keep a plan. Sets $plan_path to the first
# path ending in plan.md that the prompt names (empty if there is none).
# A plan is one task per line, "- [ ] name" or "- [x] name"; work for a
# task is a file with the task's name, in the current directory.
plan_path=$(printf '%s\n' "$prompt" | grep -o '[^[:space:]`"'"'"']*plan\.md' | head -n 1)

new_plan='- [ ] alpha
- [ ] beta'

write_new_plan() {
  mkdir -p "$(dirname "$plan_path")"
  printf '%s\n' "$new_plan" > "$plan_path"
}

unticked() { sed -n 's/^- \[ \] //p' "$plan_path"; }

first_unticked() { unticked | head -n 1; }

# A task's work is a file named after it, with anything but letters,
# digits, dots and dashes turned into dashes.
work_file() { printf '%s' "$1" | tr -c 'A-Za-z0-9.-' '-'; }

is_committed() { [ -n "$(git log -1 --format=%H -- "$(work_file "$1")" 2>/dev/null)" ]; }

tick() {
  awk -v t="$1" '$0 == "- [ ] " t { print "- [x] " t; next } { print }' \
    "$plan_path" > "$plan_path.tmp" && mv "$plan_path.tmp" "$plan_path"
}

do_task() { echo "done by a stand-in" > "$(work_file "$1")"; }
