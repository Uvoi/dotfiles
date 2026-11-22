#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-backups/$(date +%Y%m%d-%H%M%S)"
packages=(niri hypr dms fish kitty)
backed_up=false

for package in "${packages[@]}"; do
    package_dir="$repo_dir/$package"

    while IFS= read -r -d '' source_file; do
        relative_path="${source_file#"$package_dir/"}"
        target_file="$HOME/$relative_path"

        mkdir -p -- "$(dirname -- "$target_file")"

        if [[ -L "$target_file" ]] && [[ "$(readlink -f -- "$target_file")" == "$source_file" ]]; then
            continue
        fi

        if [[ -e "$target_file" || -L "$target_file" ]]; then
            backup_file="$backup_root/$relative_path"
            mkdir -p -- "$(dirname -- "$backup_file")"
            mv -- "$target_file" "$backup_file"
            backed_up=true
        fi

        ln -s -- "$source_file" "$target_file"
        printf 'linked %s\n' "$relative_path"
    done < <(find "$package_dir" -type f -print0)
done

if [[ "$backed_up" == true ]]; then
    printf '\nPrevious files were backed up to %s\n' "$backup_root"
fi
