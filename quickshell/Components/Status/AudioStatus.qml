import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Item {
    id: audioStatus

    property var sink: Pipewire.defaultAudioSink

    width: volumeIcon.implicitWidth
    height: volumeIcon.implicitHeight

    function getVolumeIcon() {
        if (!audioStatus.sink || !audioStatus.sink.audio)
            return "volume_off"

        if (audioStatus.sink.audio.muted)
            return "no_sound"

        if (audioStatus.sink.audio.volume === 0)
            return "no_sound"

        if (audioStatus.sink.audio.volume < 0.33)
            return "volume_mute"

        if (audioStatus.sink.audio.volume < 0.67)
            return "volume_down"

        return "volume_up"
    }

    PwObjectTracker {
        objects: [audioStatus.sink]
    }

    Text {
        id: volumeIcon

        text: audioStatus.getVolumeIcon()

        color: "#ffffff"

        font {
            family: "Material Symbols Rounded"
            pixelSize: 26
            weight: 500
        }
    }
}