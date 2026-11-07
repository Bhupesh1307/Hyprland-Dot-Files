import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    property bool active: false
    property string icon
    property string label

    signal clicked()
    
    radius: 25
    clip: true

    color: {
        if (active) {
            color: "#ffffff"
        } else {
            color: "#ff0000"
        }
    }

    RowLayout {
        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                text: label
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    active = !active
                }
            }
        }

        Item {
            Layout.preferredWidth: 45
            Layout.fillHeight: true

            Text {
                text: ">"
            }
        }
    }
}