import Quickshell
import Quickshell.Widgets
import QtQuick

PopupWindow {
    id: popupWindowz

    property var anchorWindow
    property var targetItem

    color: "transparent"

    anchor {
        window: anchorWindow
        rect.y: (targetItem.y + targetItem.height + 10)
    }

    Rectangle {
        anchors.fill: parent

        radius: 25
        color: "#1C1C1E"
    }
}