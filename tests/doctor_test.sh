#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
scratch=$(mktemp -d)
trap 'rm -rf "$scratch"' EXIT
fake_bin="$scratch/bin"
fake_home="$scratch/home"
mkdir -p "$fake_bin" "$fake_home"

fake() {
  local name="$1" body="$2"
  printf '#!/usr/bin/env bash\n%s\n' "$body" >"$fake_bin/$name"
  chmod +x "$fake_bin/$name"
}

for tool in node npm git pi claude codex; do
  fake "$tool" 'case "$1 ${2-}" in *status*) exit 1 ;; *) echo "fake 1.0" ;; esac'
done

run_doctor() {
  PATH="$fake_bin:$PATH" HOME="$fake_home" NO_COLOR=1 /bin/bash "$repo_root/bin/doctor" "$@"
}

if run_doctor --agent nope >/dev/null 2>&1; then
  echo 'expected invalid agent to fail' >&2
  exit 1
fi
if run_doctor --agent pi >/dev/null 2>&1; then
  echo 'expected selected unconfigured agent to fail' >&2
  exit 1
fi
if run_doctor >/dev/null 2>&1; then
  echo 'expected no configured agents to fail' >&2
  exit 1
fi

fake pi 'case "$1 ${2-}" in *status*) exit 1 ;; *) echo "fake 1.0" ;; esac'
if ! OPENAI_API_KEY=present run_doctor --agent pi >/dev/null; then
  echo 'expected Pi environment-key configuration to pass' >&2
  exit 1
fi
if ! OPENAI_API_KEY=present run_doctor >/dev/null; then
  echo 'expected default mode to pass with one configured agent' >&2
  exit 1
fi
if OPENAI_API_KEY=present run_doctor --agent all >/dev/null 2>&1; then
  echo 'expected --agent all to require every configured agent' >&2
  exit 1
fi

fake claude 'case "$1 ${2-}" in *auth\ status*) exit 0 ;; *) echo "fake 1.0" ;; esac'
if ! run_doctor --agent claude >/dev/null; then
  echo 'expected Claude configured state to pass' >&2
  exit 1
fi

fake codex 'case "$1 ${2-}" in *login\ status*) exit 0 ;; *) echo "fake 1.0" ;; esac'
if ! run_doctor --agent codex >/dev/null; then
  echo 'expected Codex configured state to pass' >&2
  exit 1
fi

printf 'doctor tests passed\n'
