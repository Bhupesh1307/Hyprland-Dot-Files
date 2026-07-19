hl.on("hyprland.start", function()

    hl.exec_cmd("waybar")

    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")

    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("swaync")

    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("awww img ~/.config/hypr/wallpapers/wallpaper.png")
    hl.exec_cmd("matugen image ~/.config/hypr/wallpapers/wallpaper.png")

    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

end)
