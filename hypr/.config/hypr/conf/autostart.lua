-- Autostart

hl.on("hyprland.start", function()
    hl.exec_cmd(
        "waybar -c ~/.config/hypr/themes/main/waybar.jsonc -s ~/.config/hypr/themes/main/waybar.css"
    )

    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("wl-clip-persist --clipboard regular --display wayland-1")

    hl.exec_cmd("hyprpaper -c ~/.config/hypr/hyprpaper.conf")
    hl.exec_cmd("mako")

    hl.exec_cmd(
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP && systemctl --user restart hypr-wob.service hypridle.service"
    )
end)
