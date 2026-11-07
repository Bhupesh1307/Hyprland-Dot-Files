pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// Global color palette. Use it anywhere:  color: Theme.primary
// Switching theme = Theme.load("/path/to/theme.json"), every binding updates live.
Singleton {
    id: theme

    // defaults (Catppuccin Mocha) so the UI looks right before anything loads
    property string name: "Catppuccin Mocha"
    property color bg: "#1e1e2e"
    property color surface: "#313244"
    property color border: "#45475a"
    property color text: "#cdd6f4"
    property color subtext: "#a6adc8"
    property color primary: "#cba6f7"
    property color secondary: "#b4befe"
    property color red: "#f38ba8"
    property color green: "#a6e3a1"
    property color yellow: "#f9e2af"
    property color blue: "#89b4fa"

    // the picker saves the chosen theme's path here, we restore it at startup
    readonly property string statePath: Quickshell.env("HOME") + "/.cache/quickshell-theme"

    function load(path): void {
        if (themeFile.path === path)
            themeFile.reload()
        else
            themeFile.path = path
    }

    function parse(txt): void {
        let t
        try {
            t = JSON.parse(txt)
        } catch (e) {
            console.warn("Theme: invalid JSON:", e)
            return
        }
        theme.name = t.name || theme.name
        theme.bg = t.bg || theme.bg
        theme.surface = t.surface || theme.surface
        theme.border = t.border || theme.border
        theme.text = t.text || theme.text
        theme.subtext = t.subtext || theme.subtext
        theme.primary = t.primary || theme.primary
        theme.secondary = t.secondary || theme.secondary
        theme.red = t.red || theme.red
        theme.green = t.green || theme.green
        theme.yellow = t.yellow || theme.yellow
        theme.blue = t.blue || theme.blue
    }

    // reads the currently selected theme file
    FileView {
        id: themeFile
        watchChanges: true
        onFileChanged: reload()
        onLoaded: theme.parse(text())
    }

    // restores the last chosen theme at startup
    FileView {
        id: stateFile
        path: theme.statePath
        printErrors: false
        onLoaded: {
            const p = text().trim()
            if (p) theme.load(p)
        }
    }
}
