import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: bar

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 50

    color: "transparent"

    Workspaces {
        id: workspaces

        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    WindowTitle {
        id: windowTitle

        anchors.left: workspaces.right
        anchors.leftMargin: 10
    }

    Clock {
        id: clock

        anchors.horizontalCenter: parent.horizontalCenter
    }

    ClockPopup {
        id: clockPopup

        visible: clock.popupOpen

        onDismissed: {
            clock.popupOpen = false
        }

        anchorWindow: bar
        targetItem: clock
    }

    Status {
        id: status
        
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
}
