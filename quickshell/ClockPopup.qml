import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Popup {
    id: clockPopup

    signal dismissed()

    implicitWidth: 800
    implicitHeight: 500

    anchor.rect.x: (anchorWindow.width - clockPopup.width) / 2

    grabFocus: true

    onVisibleChanged: {
        if (!visible) {
            dismissed()
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5

        spacing: 8

        MediaPlayer {
            Layout.fillWidth: true
            height: parent.height
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