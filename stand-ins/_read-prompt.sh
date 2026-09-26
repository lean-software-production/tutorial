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

# If $STAND_IN_RECORD is set, append this stand-in's name and everything
# it was given to it, so a check can see what the factory handed it.
if [ -n "${STAND_IN_RECORD:-}" ]; then
  printf -- '--- %s\n%s\n' "$(basename "$0")" "$prompt" >> "$STAND_IN_RECORD"
fi
