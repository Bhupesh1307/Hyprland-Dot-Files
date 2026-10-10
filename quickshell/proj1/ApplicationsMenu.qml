import Quickshell
import QtQuick

PopupWindow {
    id: menu

    property string searchText: ""

    visible: false
    grabFocus: true
    
    implicitWidth: 300
    implicitHeight: 400

    Rectangle {
	anchors.fill: parent
	color: "#eeeeee"
	
	Column {
	    anchors.fill: parent
	    anchors.margins: 12
	    spacing: 10

	    Rectangle {
		width: parent.width
		height: 35

		color: "#ffffff"
		border.width: 1
		border.color: "#cccccc"

		TextInput {
		    id: searchInput

		    anchors.fill: parent
		    anchors.margins: 8

		    font.pixelSize: 14
		    color: "#333333"

		    clip: true

		    focus: true

		    onTextChanged: {
			menu.searchText = text
		    }

		    Text {
			anchors.fill: parent

			text: "Search..."
			color: "#999999"

			visible: !searchInput.text
		    }
		}
	    }
	    
	    Repeater {
		model: [
		    {
			name: "Brave",
			icon: "🦊",
			command: "brave"
		    },
		    {
			name: "Kitty",
			icon: "💻",
			command: "kitty"
		    },
		    {
			name: "Files",
			icon: "📁",
			command: "nautilus"
		    }
		].filter(function(app) {
		    return app.name.toLowerCase().includes(menu.searchText.toLowerCase())
		})

		Rectangle {
		    width: parent.width
		    height: 30

		    color: "#eeeeee"

		    Text {
			anchors.left: parent.left
			anchors.leftMargin: 8
			anchors.verticalCenter: parent.verticalCenter

			text: modelData.icon
			font.pixelSize: 16
		    }

		    Text {
			anchors.left: parent.left
			anchors.leftMargin: 35
			anchors.verticalCenter: parent.verticalCenter

			text: modelData.name
			color: "#333333"
			font.pixelSize: 14
		    }

		    MouseArea {
			anchors.fill: parent

			onClicked: {
			    Quickshell.execDetached(modelData.command)
			    menu.visible = false
			}
		    }
		}
	    }
	}
    }
}
