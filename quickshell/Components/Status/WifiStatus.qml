import Quickshell.Networking
import QtQuick

Item {
    id: wifiStatus

    readonly property var wifiDevice: {
        for (const device of Networking.devices.values) {
            if (device.type === DeviceType.Wifi) {
                return device
            }
        }
        return null
    }
    property var connectedNetwork: {
        if (!wifiDevice) {
            return null
        }
        for (const network of wifiDevice.networks.values) {
            if (network.connected) {
                return network
            }
        }
        return null
    }

    function wifiIconName() {
        if (!wifiDevice || !wifiDevice.connected) {
            return "android_wifi_3_bar_off"
        }
        
        if (!connectedNetwork) {
            return "android_wifi_3_bar_off"
        }

        if (connectedNetwork.signalStrength >= 0.75) {
            return "android_wifi_4_bar"
        } else if (connectedNetwork.signalStrength >= 0.50) {
            return "android_wifi_3_bar"
        } else if (connectedNetwork.signalStrength >= 0.25) {
                return "wifi_2_bar"
        } else {
            return "android_wifi_3_bar_question"
        }
    }

    width: wifiIcon.implicitWidth
    height: wifiIcon.implicitHeight

    Text {
        id: wifiIcon

        text: wifiIconName()

        color: {
            if (!wifiStatus.connectedNetwork) {
                return "#777777"
            } else {
                return "#ffffff"
            }
        }

        font {
            family: "Material Symbols Rounded"
            pixelSize: 22
            weight: 500
        }
    }
}
