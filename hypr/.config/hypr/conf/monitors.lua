-- Monitors

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

-- Ноут снизу, монитор сверху
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x1080", scale = 1.2 })
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Ноут слева, монитор справа
-- hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1.2 })
--hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@144", position = "1600x0", scale = 1 })

hl.config({
    debug = {
        vfr = true,
    },
})

-- Workspaces

hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "6", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })
