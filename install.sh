#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
skills_dir="$HOME/.agents/skills"
commands_dir="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/commands"
legacy_skills_dir="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/skills"
shopt -s nullglob

install_link() {
    local src=$1 dst=$2

    if [[ "$dst" -ef "$src" ]]; then
        printf 'Already installed: %s\n' "$dst"
        return
    fi

    if [[ -e "$dst" || -L "$dst" ]]; then
        rm -rf -- "$dst"
    fi

    ln -sT -- "$src" "$dst"
    printf 'Linked: %s -> %s\n' "$dst" "$src"
}

mkdir -p -- "$skills_dir" "$commands_dir"

for skill in "$root"/skills/*/SKILL.md; do
    dir=$(dirname -- "$skill")
    name=$(basename -- "$dir")

    install_link "$dir" "$skills_dir/$name"

    if [[ ! "$legacy_skills_dir" -ef "$skills_dir" ]]; then
        for legacy in "$legacy_skills_dir/$name" "$legacy_skills_dir/$name.md"; do
            if [[ -e "$legacy" || -L "$legacy" ]]; then
                if [[ ! -L "$legacy" && "$legacy" -ef "$dir" ]]; then
                    continue
                fi
                rm -rf -- "$legacy"
                printf 'Removed: %s\n' "$legacy"
            fi
        done
    fi
done

for command in "$root"/commands/*.md; do
    install_link "$command" "$commands_dir/$(basename -- "$command")"
done

printf 'Done. Start a new OpenCode session if the definitions are not refreshed.\n'
