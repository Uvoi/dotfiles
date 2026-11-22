hl.layer_rule({
    name = "wofi-glass",
    match = {
        namespace = "^wofi$",
    },
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.12,
})

hl.layer_rule({
    name = "wob-glass",
    match = {
        namespace = "^wob$",
    },
    blur = true,
    ignore_alpha = 0.10,
})

hl.window_rule({
    name = "picture-in-picture",
    match = {
        title = "Картинка в картинке",
    },
    float = true,
    pin = true,
    size = { "450", "300" },
    move = { "1140", "10" },
})

hl.window_rule({
    name = "mission-center",
    match = {
        title = "Mission Center",
    },
    float = true,
    pin = true,
    size = { "600", "370" },
    center = true,
})

hl.window_rule({
    name = "kitty-mini",
    match = {
        title = "kitty_mini",
    },
    float = true,
    size = { "500", "200" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "nmtui",
    match = {
        title = "nmtui",
    },
    float = true,
    pin = true,
    size = { "700", "350" },
    center = true,
})

hl.window_rule({
    name = "kitty-default",
    match = {
        title = "kitty_default",
    },
    float = true,
    center = true,
    size = { "1000", "600" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "thunar",
    match = {
        class = "thunar",
    },
    float = true,
    center = true,
    size = { "900", "600" },
})

hl.window_rule({
    name = "ayugram",
    match = {
        class = "com.ayugram.desktop",
    },
    float = true,
    center = true,
    size = { "900", "600" },
})

hl.window_rule({
    name = "yandex-music",
    match = {
        class = "YandexMusic",
    },
    float = true,
    center = true,
    size = { "900", "600" },
    workspace = "10",
})

hl.window_rule({
    name = "blueman-manager",
    match = {
        class = "blueman-manager",
    },
    float = true,
    size = { "550", "300" },
    center = true,
})

hl.window_rule({
    name = "volume",
    match = {
        title = "Громкость",
    },
    float = true,
    size = { "700", "300" },
    center = true,
})

hl.window_rule({
    name = "feh",
    match = {
        class = "feh",
    },
    float = true,
    center = true,
    size = { "800", "600" },
})
