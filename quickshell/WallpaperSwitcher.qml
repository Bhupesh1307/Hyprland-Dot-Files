pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import Qt.labs.folderlistmodel

Scope {
    id: root

    property string wallDir: Quickshell.env("HOME") + "/Pictures/Wallpapers"
    property bool useMatugen: false
    property string transition: "grow"
    readonly property bool open: Pickers.active === "wallpaper"

    IpcHandler {
        target: "wallpaper"
        function toggle(): void { Pickers.toggle("wallpaper") }
    }

    Process {
        id: awwwProcess
    }

    Process {
        id: saver
    }

    function apply(path): void {
            awwwProcess.command = ["awww", "img", path, "--transition-type", root.transition]
            awwwProcess.running = true
            Pickers.toggle("wallpaper")
        }
    
    function save(path): void {
        saver.command = ["sh", "-c", 'echo "$1" > ~/.cache/wallpaper', "sh", path]
        saver.running = true
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
            color: '#5e000000'

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (imgContainer.PathView.isCurrentItem)
                        root.apply(imgContainer.filePath)
                    else
                        imgContainer.PathView.view.currentIndex = imgContainer.index
                }
            }

            FolderListModel {
                id: walls
                folder: "file://" + root.wallDir
                nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp", "*.gif"]
                showDirs: false
            }

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

                MouseArea {
                    anchors.fill: parent
                    onClicked: {}
                }

                PathView {
                    id: list
                    focus: true
                    anchors.fill: parent
                    anchors.margins: 16
                    clip: true
                    model: walls

                    readonly property int itemW: 240
                    readonly property int step: itemW + 12            
                    pathItemCount: 5                                  
                    readonly property real pathLen: step * pathItemCount

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
                    Keys.onEscapePressed: Pickers.toggle("wallpaper")
                    Keys.onReturnPressed: {
                        if (currentItem) {
                            root.apply(currentItem.filePath)
                            root.save(currentItem.filePath)
                        }
                    }

                    delegate: Item {
                        id: imgContainer
                        required property string filePath
                        required property int index

                        width: list.itemW
                        height: list.height
                        
                        ClippingRectangle {
                            anchors.fill: parent
                            radius: 20
                            color: "transparent"

                            Image {
                                anchors.fill: parent
                                source: "file://" + imgContainer.filePath
                                fillMode: Image.PreserveAspectCrop
                                sourceSize.width: 440
                                asynchronous: true
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onEntered: imgContainer.PathView.view.currentIndex = imgContainer.index
                            onClicked: {
                                root.apply(imgContainer.filePath)
                                root.save(imgContainer.filePath)
                            }

                        }
                    }
                }
                Rectangle {
                    anchors.centerIn: list
                    color: "transparent"
                    width: list.itemW
                    height: list.height
                    radius: 20
                    border.width: 3
                    border.color: Theme.primary
                }
            }
        }
    }
}