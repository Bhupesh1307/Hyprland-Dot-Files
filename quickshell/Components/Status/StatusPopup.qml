import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import ".."

Popup {
    id: statusPopup

    implicitWidth: 450
    implicitHeight: 400

    anchor.rect.x: (anchorWindow.width - statusPopup.width - 10)

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 8

        RowLayout {
            ColumnLayout {
                ToggleTile {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 95
                }

                ToggleTile {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 95
                }
            }

            GridLayout{
                // Circles go here
            }
        }
        RowLayout {
            // Another Row for sliders and more options
        }
    }
}