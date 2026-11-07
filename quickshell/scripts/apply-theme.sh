#!/usr/bin/env bash
# Usage: apply-theme.sh ~/.config/quickshell/themes/nord.json
# Generates kitty, GTK3/GTK4 (Nautilus) and Hyprland color files from one theme JSON,
# then reloads whatever can be reloaded live.
set -eu

theme="${1:?usage: apply-theme.sh <theme.json>}"
command -v jq >/dev/null || { echo "jq is required: sudo pacman -S jq"; exit 1; }

c() { jq -r --arg k "$1" '.[$k]' "$theme"; }
bg=$(c bg); surface=$(c surface); border=$(c border)
text=$(c text); subtext=$(c subtext)
primary=$(c primary); secondary=$(c secondary)
red=$(c red); green=$(c green); yellow=$(c yellow); blue=$(c blue)
hex() { echo "${1#\#}"; }   # "#cba6f7" -> "cba6f7"

CFG="${XDG_CONFIG_HOME:-$HOME/.config}"

# ---------------------------------------------------------------- kitty
# One-time: add this line to ~/.config/kitty/kitty.conf
#   include current-theme.conf
# The ANSI colors below are an approximation built from the 12 palette keys.
mkdir -p "$CFG/kitty"
cat > "$CFG/kitty/current-theme.conf" <<EOF
foreground              $text
background              $bg
selection_foreground    $bg
selection_background    $primary
cursor                  $primary
cursor_text_color       $bg
url_color               $blue
active_border_color     $primary
inactive_border_color   $border
active_tab_foreground   $bg
active_tab_background   $primary
inactive_tab_foreground $text
inactive_tab_background $surface

color0  $surface
color8  $border
color1  $red
color9  $red
color2  $green
color10 $green
color3  $yellow
color11 $yellow
color4  $blue
color12 $blue
color5  $secondary
color13 $secondary
color6  $primary
color14 $primary
color7  $subtext
color15 $text
EOF
pkill -USR1 -x kitty || true   # SIGUSR1 makes running kitty windows reload their config

# ------------------------------------------------------- GTK3 + GTK4
# GTK4 / libadwaita apps (Nautilus) read these named colors from gtk-4.0/gtk.css.
# GTK3 apps read gtk-3.0/gtk.css; with the adw-gtk3 theme they understand the same names.
mkdir -p "$CFG/gtk-3.0" "$CFG/gtk-4.0"
for f in "$CFG/gtk-3.0/gtk.css" "$CFG/gtk-4.0/gtk.css"; do
    # keep a one-time backup of whatever was there before
    [ -f "$f" ] && [ ! -f "$f.bak" ] && cp "$f" "$f.bak"
done

cat > "$CFG/gtk-4.0/gtk.css" <<EOF
@define-color accent_color $primary;
@define-color accent_bg_color $primary;
@define-color accent_fg_color $bg;

@define-color window_bg_color $bg;
@define-color window_fg_color $text;
@define-color view_bg_color $bg;
@define-color view_fg_color $text;

@define-color headerbar_bg_color $surface;
@define-color headerbar_fg_color $text;
@define-color headerbar_border_color $border;
@define-color headerbar_backdrop_color $bg;

@define-color sidebar_bg_color $surface;
@define-color sidebar_fg_color $text;
@define-color sidebar_backdrop_color $surface;
@define-color secondary_sidebar_bg_color $surface;
@define-color secondary_sidebar_fg_color $text;

@define-color card_bg_color $surface;
@define-color card_fg_color $text;
@define-color dialog_bg_color $surface;
@define-color dialog_fg_color $text;
@define-color popover_bg_color $surface;
@define-color popover_fg_color $text;

@define-color destructive_bg_color $red;
@define-color destructive_color $red;
@define-color error_bg_color $red;
@define-color error_color $red;
@define-color success_bg_color $green;
@define-color success_color $green;
@define-color warning_bg_color $yellow;
@define-color warning_color $yellow;
EOF
cp "$CFG/gtk-4.0/gtk.css" "$CFG/gtk-3.0/gtk.css"

# Tell apps whether the theme is dark. All six bundled themes are dark.
# (Add a light theme later? compute this from the luminance of $bg instead.)
if command -v gsettings >/dev/null; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'  || true
fi

# ------------------------------------------------------------ Hyprland
# Hyprland >= 0.55 uses a Lua config. This writes ~/.config/hypr/colors.lua.
# One-time: load it from hyprland.lua with   local colors = require("colors")
# and use the values, e.g.  colors.primary, colors.border  (see the notes I sent).
mkdir -p "$CFG/hypr"
cat > "$CFG/hypr/colors.lua" <<EOF
return {
  bg        = "rgb($(hex "$bg"))",
  surface   = "rgb($(hex "$surface"))",
  border    = "rgb($(hex "$border"))",
  text      = "rgb($(hex "$text"))",
  subtext   = "rgb($(hex "$subtext"))",
  primary   = "rgb($(hex "$primary"))",
  secondary = "rgb($(hex "$secondary"))",
  red       = "rgb($(hex "$red"))",
  green     = "rgb($(hex "$green"))",
  yellow    = "rgb($(hex "$yellow"))",
  blue      = "rgb($(hex "$blue"))",
}
EOF
command -v hyprctl >/dev/null && hyprctl reload >/dev/null || true

echo "Applied $(jq -r .name "$theme")."
echo "kitty and Hyprland update live. Restart GTK apps to see the change (Nautilus: nautilus -q)."
