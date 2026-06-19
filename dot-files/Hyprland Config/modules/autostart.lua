hl.on("hyprland.start", function()

    hl.exec_cmd("waybar")

    hl.exec_cmd("kdeconnectd")

    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")

    hl.exec_cmd("swayosd-server")

    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("awww img ~/Pictures/wallpapers/wallpaper.jpg")

    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

end)
