# Dotfiles

Personal configuration for a Niri/Hyprland desktop with DankMaterialShell,
Fish and Kitty.

## Packages

- `niri` — compositor configuration, persistent workspaces and key bindings.
- `hypr` — Hyprland Lua configuration, Hypridle, Hyprlock and Waybar/Wofi themes.
- `dms` — DankMaterialShell settings and visual overrides.
- `fish` — prompt, aliases, functions and key bindings.
- `kitty` — terminal configuration and themes.

Generated compositor files, machine state and private VPN/certificate settings
are intentionally excluded.

## Installation

Clone the repository into your home directory, review the configuration and run
the interactive installer:

```bash
./install.sh
```

You can also select packages directly or install everything:

```bash
./install.sh niri fish kitty
./install.sh all
```

The installer creates per-file symbolic links into `$HOME`. Existing files are
moved to a timestamped directory under `~/.local/state/dotfiles-backups/` before
links are created.

After installation:

1. Adjust monitor names and modes in `hypr/.config/hypr/conf/monitors.lua`.
2. Adjust the Niri output names in `niri/.config/niri/custom-workspaces.kdl`.
3. Set wallpaper paths in `hyprlock.conf` and `hyprpaper.conf`.
4. Start DMS once so it can generate its compositor integration files.
5. Validate Niri with `niri validate`.

## Notes

The Niri configuration treats generated `dms/*.kdl` files as optional, so it
can load before DMS has generated them. Work-specific aliases, URLs, credentials,
certificates and shell state are not part of this repository.
