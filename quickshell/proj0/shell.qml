import Quickshell
import Quickshell.Wayland // import for panel window
import Quickshell.Hyprland // Hyprland IPC Acceess
import QtQuick
import QtQuick.Layouts // For RowLayout

// Floating Window Doesn't Dock or reserve space
/* FloatingWindow {
    visible: true
    width: 200
    height: 100

    // anchors.centerIn centers within parent
    Text {
	anchors.centerIn: parent
	text: "Hello Quickshell"
	color: "#000"
	font.pixelSize: 18
    }
}
*/

// Panel Window
PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: "#1a1b26"

    RowLayout {
	anchors.fill: parent
	anchors.margins: 8

	Repeater {
	    model: 9

	    Text {
		property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
		property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
		text: index + 1
		color: isActive ? "#0db9d7" : (ws ? "#7aa2f7" : "#444b6a")
		font { pixelSize: 14; bold: true }

		MouseArea {
		    anchors.fill: parent
		    onClicked: Hyprland.dispatch("workspace " + (index + 1))
		}
	    }
	}
	Item { Layout.fillWidth: true }
    }
}
