import Quickshell
import Quickshell.Hyprland
import QtQuick

Pill {
    id: windowTitlePill

    anchors.verticalCenter: parent.verticalCenter

    visible: Hyprland.activeToplevel?.workspace === Hyprland.focusedWorkspace

    width: Math.min(windowTitle.implicitWidth + 20, 280)

    Text {
        id: windowTitle

        width: parent.width - 20

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        text: Hyprland.activeToplevel?.workspace === Hyprland.focusedWorkspace ? Hyprland.activeToplevel?.title : ""
        
        color: "#ffffff"

        font {
            family: "Poppins"
            pixelSize: 18
            weight: 500
        }

        elide: Text.ElideRight
    }
}