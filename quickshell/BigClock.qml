import Quickshell
import QtQuick

Rectangle {
    color: "#252527"
    border.width: 1
    border.color: "#3A3A3C"
                
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