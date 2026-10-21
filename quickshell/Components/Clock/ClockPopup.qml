import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import ".."

Popup {
    id: clockPopup

    implicitWidth: 800
    implicitHeight: 500

    anchor.rect.x: (anchorWindow.width - clockPopup.width) / 2

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5

        spacing: 8

        MediaPlayer {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            BigClock {
                Layout.fillWidth: true
                height: 120
            }

            Calendar {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}