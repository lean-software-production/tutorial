# Tutorial

A hands-on course for building an agentic software factory. Work through the
iterations one homework at a time, as directed by your instructor.

## Get started

Fire up your favourite coding agent harness (Claude Code, Codex, Pi, etc) and say "coach me".

### Codespaces and Dev Containers

This repository includes a Dev Container for GitHub Codespaces and local Dev
Container users. It provides Node.js plus Pi, Claude Code, and Codex. Open the
repository in a container, then authenticate the agent you want to use as the
non-root `node` user—credentials are not included in the image or repository.

```sh
# Pick one. Codespaces users can use the device-code flow when browser callback
# login is inconvenient.
pi                 # then enter /login
claude auth login
codex login --device-auth

# Confirm the environment without contacting a model.
bin/doctor
bin/doctor --agent codex
```

`bin/doctor` checks Node.js, Git, Bash, and all three agent CLIs. By default it
requires the tools and at least one configured agent; `--agent pi`,
`--agent claude`, or `--agent codex` checks a specific choice, and
`--agent all` requires every agent to be configured. It does not read credential
contents or make a model request. For Pi, it uses `pi auth check --no-refresh`
against a saved/uniquely identifiable provider; ambiguous Pi configuration is
reported as unknown rather than ready. Once it reports ready, start Pi with `pi`,
Claude Code with `claude`, or Codex with `codex`, and say **coach me**.

The coaching workflow is available through `AGENTS.md` (Codex and Pi),
`.claude/commands/coach-me.md` (Claude Code's `/coach-me` command), and
`.pi/prompts/coach-me.md` (Pi's `/coach-me` prompt). In any harness, plain
`coach me` is the documented starting phrase.

## Where things live

- [Iterations](docs/iterations/README.md) — the homeworks, one folder each.
- [Architecture decisions](docs/adr/README.md) — the ADR ledger.
- [Lexicon](docs/lexicon.yaml) — the vocabulary we use.
- [Reference](docs/reference/README.md) — outside material we borrow from.
