import Quickshell
import Quickshell.Hyprland
import QtQuick

Pill {
    id: workspacesPill

    property int visibleCount: 5

    anchors.verticalCenter: parent.verticalCenter

    width: workspaceRow.implicitWidth + 15

    Row {
        id: workspaceRow

        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8
        height: parent.height

        Repeater {
            model: ScriptModel {
                values: {
                    let active = Hyprland.focusedWorkspace?.id ?? 1

                    let end = Math.max(active, 3)

                    let start = Math.max(
                        1,
                        end - workspacesPill.visibleCount + 1
                    )

                    return Hyprland.workspaces.values.filter(
                        ws => ws.id >= start && ws.id <= end
                    )
                }
            }

            Rectangle {
                anchors {
                    verticalCenter: parent.verticalCenter
                }

                width: modelData === Hyprland.focusedWorkspace ? 60 : 12
                height: modelData === Hyprland.focusedWorkspace ? 8 : 12
                radius: height / 2

                color: modelData === Hyprland.focusedWorkspace
                    ? "#ffffff"
                    : "#444444"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        modelData.activate()
                    }
                }

                Behavior on width {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 250
                    }
                }
            }
        }
    }
}