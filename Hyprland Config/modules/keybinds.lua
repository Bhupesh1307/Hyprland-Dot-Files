hl.bind(mainMod .. " + Q",
    hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + E",
    hl.dsp.exec_cmd(fileManager))

hl.bind(mainMod .. " + V",
    hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + L",
    hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + M",
    hl.dsp.exec_cmd("pkill -x wlogout || wlogout"))

hl.bind(mainMod .. " + N",
    hl.dsp.exec_cmd("swaync-client -t"))

hl.bind(mainMod .. " + SPACE",
    hl.dsp.exec_cmd("pkill -x rofi || rofi -show drun"))

hl.bind(mainMod .. " + W",
    hl.dsp.window.close())

for i = 1, 10 do
    local key = i % 10

    hl.bind(mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i }))

    hl.bind(mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i }))
end

hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd(
        "swayosd-client --output-volume mute-toggle"
    ),
    { locked = true })

hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "swayosd-client --output-volume -2"
    ),
    { locked = true })

hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "swayosd-client --output-volume +2"
    ),
    { locked = true })

hl.bind("XF86AudioMicMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ),
    { locked = true })

hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd(
        "swayosd-client --brightness -2"
    ),
    { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd(
        "swayosd-client --brightness +2"
    ),
    { locked = true, repeating = true })

-- Move tiled windows around

hl.bind(mainMod .. " + left",
    hl.dsp.window.move({ direction = "left" }))

hl.bind(mainMod .. " + right",
    hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + up",
    hl.dsp.window.move({ direction = "up" }))

hl.bind(mainMod .. " + down",
    hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + right",
    hl.dsp.window.move({ workspace = "e+1" }))

hl.bind(mainMod .. " + SHIFT + left",
    hl.dsp.window.move({ workspace = "e-1" }))

hl.bind(mainMod .. " + Tab",
    hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + SHIFT + Tab",
    hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true })

hl.bind(mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true })

