import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick

// Main Container
Rectangle {
    id: media

    // Current Media Player Variable
    property var player: null

    // Variable to update media progressbar and current position in real time
    property real progress: 0
    property real currentPosition: 0

    // Function to format media time durations
    function formatTime(seconds) {
        const mins = Math.floor(seconds / 60)
        const secs = Math.floor(seconds % 60)

        return mins + ":" + (secs < 10 ? "0" + secs : secs)
    }

    // Media Progress Animation
    FrameAnimation {
        running: media.player?.isPlaying ?? false

        onTriggered: {
            if (media.player && media.player.length > 0) {
                media.currentPosition = media.player.position
                media.progress = media.player.position / media.player.length
            }
        }
    }

    color: '#252527'
    border.width: 1
    border.color: "#3A3A3C"
    
    radius: 25

    // Checks if there is a media is already being played
    Component.onCompleted: {
        for (const p of Mpris.players.values) {
            if (p.isPlaying) {
                player = p
                break
            }
        }
    }

    // Gets the most recent used media player
    Instantiator {
        model: Mpris.players.values

        Connections {
            target: modelData

            function onIsPlayingChanged() {
                if (modelData.isPlaying) {
                    media.player = modelData
                }
            }
        }
    }

    Column {
        anchors.centerIn: parent

        spacing: 20

        // Used ClippingRectangle to actually fit the fetched song artwork inside the rounded corner rectangle
        ClippingRectangle {
            anchors.horizontalCenter: parent.horizontalCenter

            width: 200
            height: 200
            radius: 15
            color: "#333333"

            Image {
                id: trackArtwork

                anchors.fill: parent

                source: media.player 
                    ? media.player.trackArtUrl
                    : ""

                fillMode: Image.PreserveAspectCrop
                sourceSize.width: 200
                sourceSize.height: 200
            }

            Text {
                id: defaultTrackArt

                anchors.centerIn: parent

                text: "music_note"

                color: "#ffffff"

                font {
                    family: "Material Symbols Rounded"
                    pixelSize: 100
                }

                visible: !media.player || media.player.trackArtUrl === ""
            }
        }

        Column {
            id: musicDetails

            spacing: 5

            anchors.horizontalCenter: parent.horizontalCenter

            // Media Title
            Text {
                id: trackTitle

                anchors.horizontalCenter: parent.horizontalCenter

                width: 300

                text: media.player
                    ? media.player.trackTitle || "Unknown Title"
                    : "Nothing Playing"

                color: "#ffffff"

                horizontalAlignment: Text.AlignHCenter

                font {
                    family: "Poppins"
                    pixelSize: 20
                    weight: 600
                }

                elide: Text.ElideRight
            }

            // Media Author or Artist Name
            Text {
                id: trackArtist

                anchors.horizontalCenter: parent.horizontalCenter

                width: 300

                text: media.player
                    ? media.player.trackArtist || "Unknown Artist"
                    : ""

                color: "#bbbbbb"

                horizontalAlignment: Text.AlignHCenter

                font {
                    family: "Poppins"
                    pixelSize: 18
                    weight: 500
                }

                elide: Text.ElideRight
            }

            // Media Source
            Text {
                id: mediaPlayerName
                
                width: 300

                anchors.horizontalCenter: parent.horizontalCenter

                text: media.player
                    ? media.player.identity
                    : ""

                color: "#888888"

                horizontalAlignment: Text.AlignHCenter

                font {
                    family: "Poppins"
                    pixelSize: 18
                    weight: 400
                }

                elide: Text.ElideRight
            }
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            // Media Control Buttons
            Row {
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: 20

                Text {
                    id: previous

                    text: "skip_previous"
                    font {
                        family: "Material Symbols Rounded"
                        pixelSize: 50
                    }
                    color: {
                        media.player
                        ? "#ffffff"
                        : "#757575"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            if (media.player?.canGoPrevious) {
                                media.player.previous()
                            }
                        }
                    }
                }

                Text {
                    id: play

                    text: media.player?.isPlaying ? "pause" : "play_arrow"
                    font {
                        family: "Material Symbols Rounded"
                        pixelSize: 50
                    }
                    color: "#ffffff"

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            if (media.player?.canTogglePlaying) {
                                media.player.togglePlaying()
                            }
                        }
                    }
                }

                Text {
                    id: next

                    text: "skip_next"
                    font {
                        family: "Material Symbols Rounded"
                        pixelSize: 50
                    }
                    color: {
                        media.player
                        ? "#ffffff"
                        : "#757575"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            if (media.player?.canGoNext) {
                                media.player.next()
                            }
                        }
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: 20

                // Media current time
                Text {
                    id: currentTime

                    anchors.verticalCenter: parent.verticalCenter

                    text: media.player ? formatTime(media.currentPosition) : ""

                    color: "#ffffff"

                    font {
                        family: "Poppins"
                        pixelSize: 16
                    }
                }

                // Media ProgressBar
                Rectangle {
                    id: progressBar

                    anchors.verticalCenter: parent.verticalCenter

                    width: 250
                    height: 5
                    radius: height / 2

                    color: "#3A3A3C"

                    Rectangle {
                        id: progress

                        width: {
                            media.player ? progressBar.width * media.progress : 0
                        }

                        height: parent.height
                        radius: height / 2

                        color: "#ffffff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: function(mouse) {
                            if (
                                !media.player ||
                                !media.player.canSeek ||
                                !media.player.positionSupported ||
                                media.player.length <= 0
                            ) {
                                return 
                            }

                            const ratio = mouse.x / width
                            const newPosition = ratio * media.player.length

                            media.player.position = newPosition
                            media.progress = ratio
                        }
                    }
                }

                // Media Duration
                Text {
                    id: duration

                    anchors.verticalCenter: parent.verticalCenter

                    text: media.player ? formatTime(media.player.length) : ""

                    color: "#ffffff"

                    font {
                        family: "Poppins"
                        pixelSize: 16
                    }
                }
            }
        }
    }
}