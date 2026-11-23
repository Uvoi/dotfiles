#!/usr/bin/env bash

set -euo pipefail

focused_workspace="$(
    niri msg --json workspaces |
        jq -r '.[] | select(.is_focused) | .idx'
)"

if [[ "$focused_workspace" == "11" ]]; then
    niri msg action focus-workspace-previous
else
    niri msg action focus-workspace 11
fi
