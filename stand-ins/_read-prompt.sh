# Shared by the stand-ins: sets $prompt to the last argument that isn't a
# flag, or to stdin if there is none.
prompt=""
for arg in "$@"; do
  case "$arg" in -*) ;; *) prompt="$arg" ;; esac
done
if [ -z "$prompt" ] && [ ! -t 0 ]; then prompt=$(cat); fi

# If $STAND_IN_LOG is set, append this stand-in's name to it, so a check
# can see which stand-ins were called, how often and in what order.
if [ -n "${STAND_IN_LOG:-}" ]; then basename "$0" >> "$STAND_IN_LOG"; fi

# If $STAND_IN_RECORD is set, it names a folder: write everything this
# stand-in was given to a file of its own there, named for the time, the
# stand-in and its process, so a check can see what the factory handed
# each call. Stand-ins that run at the same time never share a file.
if [ -n "${STAND_IN_RECORD:-}" ]; then
  mkdir -p "$STAND_IN_RECORD"
  printf '%s\n' "$prompt" > "$STAND_IN_RECORD/$(date +%s%N)-$(basename "$0")-$$"
fi

# json_string VALUE: print VALUE as a JSON string.
json_string() { printf '"%s"' "$(printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g')"; }

# hear: under the ACP wrapper, print any message the factory has sent this
# machine since it last listened, as "heard: <message>".
hear() {
  [ -n "${STAND_IN_INBOX:-}" ] && [ -s "$STAND_IN_INBOX" ] || return 0
  sed 's/^/heard: /' "$STAND_IN_INBOX"
  : > "$STAND_IN_INBOX"
}

# hold: wait until the check lets held stand-ins go on, by making the file
# $STAND_IN_STATE/go. No stand-in ever waits a set time: a check decides
# when things move, so nothing depends on how fast anything runs. A held
# stand-in also gives up if the folder is removed, so none outlives a check.
hold() {
  state="${STAND_IN_STATE:-${TMPDIR:-/tmp}/stand-in-state}"
  mkdir -p "$state"
  while [ -d "$state" ] && [ ! -e "$state/go" ]; do sleep 0.05; done
}
