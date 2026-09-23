# Shared by the stand-ins: sets $prompt to the last argument that isn't a
# flag, or to stdin if there is none.
prompt=""
for arg in "$@"; do
  case "$arg" in -*) ;; *) prompt="$arg" ;; esac
done
if [ -z "$prompt" ] && [ ! -t 0 ]; then prompt=$(cat); fi
