#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
skills_dir="$HOME/.agents/skills"
commands_dir="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/commands"
legacy_skills_dir="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/skills"
shopt -s nullglob
sources=() destinations=()

for skill in "$root"/skills/*/SKILL.md; do
    dir=$(dirname -- "$skill")
    name=$(basename -- "$dir")
    sources+=("$dir")
    destinations+=("$skills_dir/$name")
    # An older OpenCode-specific copy can shadow the shared skill.
    if [[ -e "$legacy_skills_dir/$name" || -L "$legacy_skills_dir/$name" || -e "$legacy_skills_dir/$name.md" || -L "$legacy_skills_dir/$name.md" ]]; then
        printf 'Existing OpenCode-specific skill may shadow this one: %s/%s (or .md). Move it aside first.\n' "$legacy_skills_dir" "$name" >&2
        exit 1
    fi
done
for command in "$root"/commands/*.md; do
    sources+=("$command")
    destinations+=("$commands_dir/$(basename -- "$command")")
done

# Check all destinations before installing any links. Never overwrite user files.
for i in "${!sources[@]}"; do
    src=${sources[i]} dst=${destinations[i]}
    if [[ -L "$dst" && "$dst" -ef "$src" ]]; then
        continue
    fi
    if [[ -e "$dst" || -L "$dst" ]]; then
        printf 'Refusing to replace existing path: %s\nMove or back it up first, then rerun.\n' "$dst" >&2
        exit 1
    fi
done
mkdir -p -- "$skills_dir" "$commands_dir"
for i in "${!sources[@]}"; do
    src=${sources[i]} dst=${destinations[i]}
    if [[ -L "$dst" && "$dst" -ef "$src" ]]; then
        printf 'Already linked: %s\n' "$dst"
    else
        ln -sT -- "$src" "$dst"
        printf 'Linked: %s -> %s\n' "$dst" "$src"
    fi
done
printf 'Done. Start a new OpenCode session if the definitions are not refreshed.\n'
