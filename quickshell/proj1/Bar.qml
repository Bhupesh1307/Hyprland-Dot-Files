import Quickshell
import Quickshell.Hyprland
import QtQuick

PanelWindow {
    id: bar

    anchors {
	top: true
	left: true
	right: true
    }

    implicitHeight: 20

    color: "transparent"

    Rectangle {
	anchors.fill: parent
	color: "#eeeeee"

	Text {
	    id: applicationsText

	    anchors.left: parent.left
	    anchors.leftMargin: 8
	    anchors.verticalCenter: parent.verticalCenter

	    text: "Applications"
	    color: "#333333"
	    font.pixelSize: 13
	}

	MouseArea {
	    anchors.fill: applicationsText

	    hoverEnabled: true

	    onClicked: {
		applicationsMenu.visible = !applicationsMenu.visible
	    }

	    onEntered: {
		applicationsText.color = "#000000"
	    }

	    onExited: {
		applicationsText.color = "#333333"
	    }
	}

	Text {
	    id: placesText

	    anchors.left: applicationsText.right
	    anchors.leftMargin: 15
	    anchors.verticalCenter: parent.verticalCenter

	    text: "Places"
	    color: "#333333"
	    font.pixelSize: 13

	    MouseArea {
		anchors.fill: parent

		hoverEnabled: true

		onEntered: {
		    placesText.color = "#000000"
		}

		onExited: {
		    placesText.color = "#333333"
		}

		onClicked: {
		    placesMenu.visible = !placesMenu.visible
		}
	    }
	}

	Text {
	    anchors.centerIn: parent

	    text: Hyprland.activeToplevel
		? Hyprland.activeToplevel.title
		: ""

	    color: "#333333"
	    font.pixelSize: 13
	}

	SystemClock {
	    id: clock
	    precision: SystemClock.Minutes
	}
	
	Text {
	    id: clockText

	    anchors.right: parent.right
	    anchors.rightMargin: 10
	    anchors.verticalCenter: parent.verticalCenter

	    text: Qt.formatDateTime(clock.date, "hh:mm AP")

	    color: "#333333"
	    font.pixelSize: 13
	}

	Row {
	    id: workspaceRow

	    anchors.right: clockText.left
	    anchors.rightMargin: 15
	    anchors.verticalCenter: parent.verticalCenter

	    spacing: 6

	    Repeater {
		model: Hyprland.workspaces

		Text {
		    text: modelData.id

		    color: modelData === Hyprland.focusedWorkspace || workspaceMouseArea.containsMouse
		    ? "#000000"
		    : "#777777"

		    font.pixelSize: 13

		    MouseArea {
			id: workspaceMouseArea

			anchors.fill: parent

			hoverEnabled: true

			onClicked: {
			    modelData.activate()
			}
		    }
		}
	    }
	}
    }

    ApplicationsMenu {
	id: applicationsMenu

	anchor.window: bar
	anchor.rect.x: 0
	anchor.rect.y: bar.height
    }

    PlacesMenu {
	id: placesMenu

	anchor.window: bar
	anchor.rect.x: applicationsMenu.width + 15
	anchor.rect.y: bar.height
    }
}
