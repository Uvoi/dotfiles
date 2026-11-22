-- General

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 5,
        border_size = 2,

        -- В старом конфиге эта настройка была указана дважды.
        -- Вторая строка фактически перезаписывала градиент.
        col = {
            active_border = {
                colors = { "rgba(9ddbd0ee)", "rgba(b8a6e8ee)" },
                angle = 45,
            },
            inactive_border = "rgb(52616b)",
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 12,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },

    debug = {
        -- Avoid continuous libinput/DRM debug writes to the runtime log.
        disable_logs = true,
    },
})

-- Animations

hl.curve("myBezier", {
    type = "bezier",
    points = {
        { 0.05, 0.9 },
        { 0.1, 1.05 },
    },
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 7,
    bezier = "myBezier",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "default",
    style = "popin 80%",
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "default",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 7,
    bezier = "default",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "default",
})
