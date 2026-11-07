pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel

// Theme picker: same layout as the wallpaper picker, but every card shows a palette.
// Toggle with:  qs ipc call theme toggle
Scope {
    id: root

    property string themeDir: Quickshell.env("HOME") + "/.config/quickshell/themes"
    property string applyScript: Quickshell.env("HOME") + "/.config/quickshell/scripts/apply-theme.sh"
    readonly property bool open: Pickers.active === "theme"

    IpcHandler {
        target: "theme"
        function toggle(): void { Pickers.toggle("theme") }
    }

    Process { id: themeProcess }   // runs apply-theme.sh (kitty, GTK, Hyprland)
    Process { id: saver }          // remembers the choice across restarts

    function apply(path): void {
        Theme.load(path)           // recolors Quickshell instantly

        saver.command = ["sh", "-c", 'echo "$1" > ~/.cache/quickshell-theme', "sh", path]
        saver.running = true

        themeProcess.command = ["bash", root.applyScript, path]
        themeProcess.running = true

        Pickers.close()
    }

    function applyItem(item): void {
        if (item) root.apply(item.filePath)
    }

    PanelWindow {
        visible: root.open
        onVisibleChanged: panel.shown = visible
        anchors { top: true; bottom: true; left: true; right: true }
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            color: "#5e000000"

            // click on the dim area closes the picker (declared first = underneath)
            MouseArea {
                anchors.fill: parent
                onClicked: Pickers.close()
            }

            FolderListModel {
                id: themes
                folder: "file://" + root.themeDir
                nameFilters: ["*.json"]
                showDirs: false
                sortField: FolderListModel.Name
            }

            // floating panel that slides up from the bottom
            Rectangle {
                id: panel
                property bool shown: false
                width: 860
                height: 200
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: shown ? 40 : -height
                Behavior on anchors.bottomMargin {
                    NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                }
                radius: 20
                color: Theme.bg
                border.width: 1
                border.color: Theme.border

                // swallow clicks inside the panel so they don't reach the dim area
                MouseArea { anchors.fill: parent }

                PathView {
                    id: list
                    anchors.fill: parent
                    anchors.margins: 16
                    focus: true
                    clip: true
                    model: themes

                    readonly property int itemW: 240
                    readonly property int step: itemW + 12        // card width + gap
                    pathItemCount: 5
                    readonly property real pathLen: step * pathItemCount

                    // current card is always locked to the middle, list wraps forever
                    highlightRangeMode: PathView.StrictlyEnforceRange
                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5
                    highlightMoveDuration: 250

                    path: Path {
                        startX: list.width / 2 - list.pathLen / 2
                        startY: list.height / 2
                        PathLine {
                            x: list.width / 2 + list.pathLen / 2
                            y: list.height / 2
                        }
                    }

                    Keys.onLeftPressed: decrementCurrentIndex()
                    Keys.onRightPressed: incrementCurrentIndex()
                    Keys.onEscapePressed: Pickers.close()
                    Keys.onReturnPressed: root.applyItem(currentItem)
                    Keys.onEnterPressed: root.applyItem(currentItem)

                    delegate: Item {
                        id: card
                        required property string filePath
                        required property int index

                        width: list.itemW
                        height: list.height

                        function parse(txt) {
                            try { return JSON.parse(txt) } catch (e) { return ({}) }
                        }

                        // each card reads its own theme file to show its colors
                        FileView {
                            id: view
                            path: card.filePath
                            blockLoading: true
                        }
                        readonly property var pal: parse(view.text())

                        ClippingRectangle {
                            anchors.fill: parent
                            radius: 16
                            color: card.pal.bg || "#222222"
                            border.width: 1
                            border.color: card.pal.border || "#444444"

                            ColumnLayout {
                                anchors.centerIn: parent
                                spacing: 14

                                // pill holding the palette circles
                                Rectangle {
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.preferredWidth: swatches.implicitWidth + 24
                                    Layout.preferredHeight: 38
                                    radius: 19
                                    color: card.pal.surface || "#333333"

                                    Row {
                                        id: swatches
                                        anchors.centerIn: parent
                                        spacing: 9

                                        Repeater {
                                            model: ["primary", "secondary", "red", "green", "yellow", "blue"]

                                            Rectangle {
                                                required property string modelData
                                                width: 22
                                                height: 22
                                                radius: 11
                                                color: card.pal[modelData] || "#666666"
                                            }
                                        }
                                    }
                                }

                                Text {
                                    Layout.alignment: Qt.AlignHCenter
                                    text: card.pal.name || ""
                                    color: card.pal.text || "white"
                                    font.pixelSize: 14
                                    font.bold: true
                                }
                            }
                        }

                        // click a side card to select it, click the centered one to apply
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (card.PathView.isCurrentItem)
                                    root.apply(card.filePath)
                                else
                                    card.PathView.view.currentIndex = card.index
                            }
                        }
                    }
                }

                // fixed selection frame: never moves, the cards slide through it
                Rectangle {
                    anchors.centerIn: list
                    width: list.itemW
                    height: list.height
                    radius: 16
                    color: "transparent"
                    border.width: 3
                    border.color: Theme.primary
                    Behavior on border.color { ColorAnimation { duration: 200 } }
                }
            }
        }
    }
}
