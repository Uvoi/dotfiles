-- Input

hl.config({
    input = {
        kb_layout = "us,ru",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:ctrl_space_toggle",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = -0.15,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.2,
        },

        repeat_delay = 300,
        repeat_rate = 50,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- Devices

hl.device({
    name = "sinowealth-2.4g-wireless-receiver",
    sensitivity = -0.6,
})

hl.device({
    name = "elan0511:01-04f3:303f-touchpad",
    sensitivity = -0.1,
    accel_profile = "custom",
    natural_scroll = true,
    scroll_points = 1.0,
})
