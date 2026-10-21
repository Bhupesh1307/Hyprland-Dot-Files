import Quickshell
import QtQuick

Rectangle {
    color: "#0f0f0f"
    border.width: 1
    border.color: "#2d2d2d"
                
    radius: 25

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        id: clockText

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 15

        text: Qt.formatTime(clock.date, "hh:mm:ss A")

        color: "#ffffff"
        font {
            family: "Poppins"
            pixelSize: 45
            weight: 500
        }
    }
}