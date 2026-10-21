import Quickshell
import Quickshell.Hyprland
import QtQuick

PopupWindow {
    id: root

    property var anchorWindow
    property var targetItem
    property bool open: false

    signal dismissed()

    // children declared in ClockPopup end up inside the sliding container
    default property alias content: slider.data

    color: "transparent"

    // stay mapped while open OR while the close animation is still running
    visible: open || slideAnim.running

    anchor {
        window: anchorWindow
        rect.y: (targetItem.y + targetItem.height + 10)
    }

    HyprlandFocusGrab {
        windows: [root, root.anchorWindow]
        active: root.open
        onCleared: root.dismissed()
    }

    Item {
        anchors.fill: parent
        clip: true

        Item {
            id: slider
            width: parent.width
            height: parent.height

            y: root.open ? 0 : -height

            Behavior on y {
                NumberAnimation {
                    id: slideAnim
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            Rectangle {
                anchors.fill: parent
                radius: 25
                color: "#9a000000"
            }
        }
    }
}