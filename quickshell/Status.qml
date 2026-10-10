import Quickshell
import QtQuick

Pill {
    id: status

    anchors.verticalCenter: parent.verticalCenter

    width: 170

    Row {
        id: statusRow 

        anchors.centerIn: parent
        x: (parent.width - width) / 2
        spacing: 12

        WifiStatus {
            id: wifiStatus

            anchors.verticalCenter: parent.verticalCenter
        }

        AudioStatus {
            id: audioStatus

            anchors.verticalCenter: parent.verticalCenter
        }

        BatteryStatus {
            id: batteryStatus

            anchors.verticalCenter: parent.verticalCenter
        }
    }
}