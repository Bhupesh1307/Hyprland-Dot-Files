pragma Singleton

import Quickshell

// Keeps track of which picker is open, so only one can be open at a time.
// active is "" (none), "wallpaper" or "theme".
Singleton {
    property string active: ""

    function toggle(name): void {
        active = (active === name) ? "" : name
    }

    function close(): void {
        active = ""
    }
}
