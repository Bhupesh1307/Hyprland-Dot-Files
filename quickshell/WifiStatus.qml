import Quickshell.Networking
import QtQuick

Item {
    id: wifiStatus

    property var wifiDevice: null
    property var connectedNetwork: null

    width: wifiIcon.implicitWidth
    height: wifiIcon.implicitHeight

    function findWifiDevice() {
        for (const device of Networking.devices.values) {
            if (device.type === DeviceType.Wifi) {
                return device
            }
        }

        return null
    }

    function updateWifi() {
        wifiDevice = findWifiDevice()

        if (!wifiDevice) {
            connectedNetwork = null
            return
        }

        wifiDevice.scannerEnabled = true
        connectedNetwork = null

        for (const network of wifiDevice.networks.values) {
            if (network.connected) {
                connectedNetwork = network
                break
            }
        }
    }

    function wifiIconName() {
        if (!wifiDevice || !wifiDevice.connected) {
            return "android_wifi_3_bar_off"
        }
        
        if (!connectedNetwork) {
            return "android_wifi_3_bar_off"
        }

        if (connectedNetwork.signalStrength >= 3.75) {
            return "android_wifi_4_bar"
        } else if (connectedNetwork.signalStrength >= 0.50) {
            return "android_wifi_3_bar"
        } else if (connectedNetwork.signalStrength >= 0.25) {
                return "android_wifi_3_bar_alert"
        } else {
            return "android_wifi_3_bar_question"
        }
    }

    Connections {
        target: Networking.devices

        function onValuesChanged() {
            updateWifi()
        }
    }

    Connections {
        target: wifiDevice

        function onConnectedChanged() {
            updateWifi()
        }
    }

    Connections {
        target: wifiDevice ? wifiDevice.networks : null

        function onValuesChanged() {
            updateWifi()
        }
    }

    Text {
        id: wifiIcon

        text: wifiIconName()

        color: {
            if (!connectedNetwork) {
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