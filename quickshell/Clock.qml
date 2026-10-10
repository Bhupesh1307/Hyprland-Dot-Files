import Quickshell
import QtQuick

Pill {
    id: clockPill

    property var popupOpen: false

    anchors.verticalCenter: parent.verticalCenter

    width: 130

    SystemClock {
        id: systemClock
        precision: SystemClock.Minutes
    }

    Text {
        id: clockText

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        text: Qt.formatTime(systemClock.date, "hh:mm A")

        color: "#ffffff"
        font {
            family: "Poppins"
            pixelSize: 20
            weight: 500
        }
    }

    MouseArea {
        anchors.fill: parent
        
        onClicked: {
            popupOpen = !popupOpen
        }
    }
}