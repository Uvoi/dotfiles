#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-backups/$(date +%Y%m%d-%H%M%S)"
available_packages=(niri hypr dms fish kitty)
selected_packages=()
backed_up=false

usage() {
    cat <<'EOF'
Usage:
  ./install.sh                     Select packages interactively
  ./install.sh niri fish kitty     Install specific packages
  ./install.sh all                 Install every package

Available packages: niri hypr dms fish kitty
EOF
}

add_package() {
    local candidate="$1"
    local available
    local selected

    for available in "${available_packages[@]}"; do
        if [[ "$candidate" == "$available" ]]; then
            for selected in "${selected_packages[@]-}"; do
                [[ "$selected" == "$candidate" ]] && return 0
            done

            selected_packages+=("$candidate")
            return 0
        fi
    done

    printf 'Unknown package: %s\n' "$candidate" >&2
    usage >&2
    exit 1
}

select_all() {
    selected_packages=("${available_packages[@]}")
}

if (( $# > 0 )); then
    for argument in "$@"; do
        case "$argument" in
            all|--all|-a)
                select_all
                break
                ;;
            --help|-h)
                usage
                exit 0
                ;;
            *)
                add_package "$argument"
                ;;
        esac
    done
else
    printf '%s\n' \
        'Select configurations to install:' \
        '  [1] Niri' \
        '  [2] Hyprland' \
        '  [3] DankMaterialShell' \
        '  [4] Fish' \
        '  [5] Kitty' \
        '  [A] All'
    printf 'Selection (for example: 1 4 5): '
    read -r selection
    selection="${selection//,/ }"

    for choice in $selection; do
        case "${choice,,}" in
            1|niri) add_package niri ;;
            2|hypr|hyprland) add_package hypr ;;
            3|dms|dankmaterialshell) add_package dms ;;
            4|fish) add_package fish ;;
            5|kitty) add_package kitty ;;
            a|all) select_all; break ;;
            *)
                printf 'Unknown selection: %s\n' "$choice" >&2
                exit 1
                ;;
        esac
    done
fi

if (( ${#selected_packages[@]} == 0 )); then
    printf 'Nothing selected. No changes were made.\n'
    exit 0
fi

printf 'Installing: %s\n\n' "${selected_packages[*]}"

for package in "${selected_packages[@]}"; do
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
