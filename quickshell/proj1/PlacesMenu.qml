import Quickshell
import QtQuick

PopupWindow {
    id: menu

    implicitWidth: 400
    implicitHeight: 300

    visible: false
    grabFocus: true

    Rectangle {
	anchors.fill: parent
	color: "#eeeeee"

	Column {
	    anchors.fill: parent
	    anchors.margins: 12
	    spacing: 8

	    Repeater {
		model: [
		    {
			name: "Home",
			path: Quickshell.env("HOME")
		    },
		    {
			name: "Documents",
			path: Quickshell.env("HOME") + "/Documents"
		    },
		    {
			name: "Downloads",
			path: Quickshell.env("HOME") + "/Downloads"
		    },
		    {
			name: "Pictures",
			path: Quickshell.env("HOME") + "/Pictures"
		    }
		]

		Rectangle {
		    width: parent.width
		    height: 30

		    Text {
			anchors.verticalCenter: parent.verticalCenter
			text: modelData.name
			color: "#333333"
			font.pixelSize: 14

			MouseArea {
			    anchors.fill: parent
			    onClicked: {
				Quickshell.execDetached(["xdg-open", modelData.path])
				menu.visible = false
			    }
			}
		    }
		}
	    }
	}
    }
}
