-- Keybindings

local mainMod = "SUPER"

local lock_command = "hyprlock -c ~/.config/hypr/hyprlock.conf"

-- WINDOW

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(mainMod .. " + B", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- FOCUS

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + TAB", hl.dsp.window.cycle_next())

-- CONTROL

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Event-driven OSD. These binds do not consume the original key press,
-- so XKB still performs the layout and Caps Lock toggles normally.
hl.bind(
    "CTRL + SPACE",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/osd-event.sh layout"),
    { non_consuming = true }
)
hl.bind(
    "code:66",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/osd-event.sh caps"),
    {
        release = true,
        non_consuming = true,
        transparent = true,
        ignore_mods = true,
    }
)

-- WORKSPACES

for i = 1, 10 do
    local key = i % 10

    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({
        workspace = i,
    }))

    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({
        workspace = i,
    }))
end

hl.bind(mainMod .. " + F1", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + F2", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + F3", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + F4", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + F5", hl.dsp.focus({ workspace = 9 }))

hl.bind(mainMod .. " + SHIFT + F1", hl.dsp.window.move({
    workspace = 5,
}))
hl.bind(mainMod .. " + SHIFT + F2", hl.dsp.window.move({
    workspace = 6,
}))
hl.bind(mainMod .. " + SHIFT + F3", hl.dsp.window.move({
    workspace = 7,
}))
hl.bind(mainMod .. " + SHIFT + F4", hl.dsp.window.move({
    workspace = 8,
}))
hl.bind(mainMod .. " + SHIFT + F5", hl.dsp.window.move({
    workspace = 9,
}))

-- MAGIC WORKSPACE

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({
    workspace = "special:magic",
}))

-- MAIN APPS

hl.bind(
    mainMod .. " + T",
    hl.dsp.exec_cmd(terminal .. " --title kitty_default")
)

hl.bind(
    mainMod .. " + SHIFT + T",
    hl.dsp.exec_cmd(
        terminal .. " --title kitty_mini --config ~/.config/kitty/kitty_mini.conf"
    )
)

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(lock_command))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))

-- ACTIONS

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exit())
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd("wlogout"))

hl.bind(
    mainMod .. " + K",
    hl.dsp.exec_cmd("~/bin/scripts/workflow.sh")
)

hl.bind(
    mainMod .. " + V",
    hl.dsp.exec_cmd(
        "cliphist list | wofi --dmenu -c ~/.config/hypr/themes/main/clipboard.conf -s ~/.config/hypr/themes/main/clipboard.css --prompt 'История буфера' | cliphist decode | wl-copy"
    )
)

hl.bind(
    "PRINT",
    hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy')
)

hl.bind(
    mainMod .. " + PRINT",
    hl.dsp.exec_cmd(
        'file="$HOME/images/screenshots/screenshot_$(date +%Y%m%d%H%M%S).png"; grim -g "$(slurp -d)" "$file" && wl-copy < "$file"'
    )
)

-- APPS

hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("firefox"))
-- Add private or work-specific application bindings in a local-only file.
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("yandex-music"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("zen-browser"))

-- AUDIO

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "pactl set-sink-volume @DEFAULT_SINK@ +5% && VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//') && echo \"$VOLUME volume\" > $XDG_RUNTIME_DIR/hypr-wob.fifo"
    )
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "pactl set-sink-volume @DEFAULT_SINK@ -5% && VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//') && echo \"$VOLUME volume\" > $XDG_RUNTIME_DIR/hypr-wob.fifo"
    )
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle && if pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes; then echo \"0 muted\"; else VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//'); echo \"$VOLUME volume\"; fi > $XDG_RUNTIME_DIR/hypr-wob.fifo"
    )
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))

-- BRIGHTNESS

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd(
        "brightnessctl set 10%+ && echo \"$(( $(brightnessctl get) * 100 / $(brightnessctl max) )) brightness\" > $XDG_RUNTIME_DIR/hypr-wob.fifo"
    )
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd(
        "brightnessctl set 10%- && echo \"$(( $(brightnessctl get) * 100 / $(brightnessctl max) )) brightness\" > $XDG_RUNTIME_DIR/hypr-wob.fifo"
    )
)

-- BUFFER 1

hl.bind(
    "XF86Tools",
    hl.dsp.exec_cmd("~/bin/scripts/buffer1_copy.sh")
)

hl.bind(
    "XF86Launch5",
    hl.dsp.exec_cmd("~/bin/scripts/buffer1_paste.sh")
)

hl.bind(
    "SHIFT + XF86Tools",
    hl.dsp.exec_cmd("~/bin/scripts/buffer1_pick.sh")
)

hl.bind(
    "SHIFT + XF86Launch5",
    hl.dsp.exec_cmd("~/bin/scripts/buffer1_pick.sh")
)


hl.bind(
    "SUPER + F12",
    hl.dsp.window.fullscreen_state({
        internal = 0,
        client = 0,
        action = "set",
    })
)
