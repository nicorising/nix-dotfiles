hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_ENABLE_HIGHDPI_SCALING", "1")
hl.env("XCURSOR_SIZE", "36")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprlock") -- Lock on start.
    hl.exec_cmd("hyprctl setcursor 'Capitaine Cursors (Gruvbox)' 24")
    hl.exec_cmd("hyprland-wallpapers")
    hl.exec_cmd("waybar")
end)

hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("ranger"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("librewolf"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("signal-desktop"))
hl.bind("SUPER + space", hl.dsp.exec_cmd("fuzzel"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.float())
hl.bind("SUPER + O", hl.dsp.window.pseudo())

-- The Framework display key (F9) sends SUPER + P.
hl.bind("SUPER + P", hl.dsp.exec_cmd("toggle-monitor-mirror"))

-- The Framework logo key (F12).
hl.bind("XF86AudioMedia", hl.dsp.exec_cmd("loginctl lock-session"))

hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region -o ~/pictures/screenshots"))

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))

hl.bind("SUPER + ALT + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + ALT + J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
hl.bind("SUPER + ALT + K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
hl.bind("SUPER + ALT + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })

for workspace = 1, 10 do
    local key = workspace % 10 -- Workspace 10 sits on the 0 key.

    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace, follow = false }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
