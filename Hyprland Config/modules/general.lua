hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,

        border_size = 2,

	col = {
	    active_border = {
		colors = {
		    "rgba(33ccffee)",
		    "rgba(00ff99ee)"
		},
		angle = 45
	    },

	    inactive_border = "rgba(595959aa)",
	},

        resize_on_border = true,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 12,
        rounding_power = 2,

        active_opacity = 0.75,
        inactive_opacity = 0.75,

        shadow = {
            enabled = true,
            range = 16,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            vibrancy = 0.1696,
        },
    },

    layerrule = {
	"blur, waybar",
	"blurpopups, waybar",
	"ignorealpha 0.2, waybar",
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
})
