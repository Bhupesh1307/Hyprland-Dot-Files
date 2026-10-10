import Quickshell.Services.UPower
import QtQuick

Row {
    id: batteryStatus

    spacing: 5

    property var battery: UPower.displayDevice
    
    Text {
        id: batteryIcon

        text: {
            if (battery.state === UPowerDeviceState.Charging)
                return "battery_android_frame_bolt"

            if (battery.percentage >= 0.9)
                return "battery_android_full"

            if (battery.percentage >= 0.8)
                return "battery_android_6"
            
            if (battery.percentage >= 0.6)
                return "battery_android_5"

            if (battery.percentage >= 0.5)
                return "battery_android_4"
            
            if (battery.percentage >= 0.3) 
                return "battery_android_3"

            if (battery.percentage >= 0.15)
                return "battery_android_2"

            return "battery_android_1"
        }

        color: {
            if (battery.state === UPowerDeviceState.Charging)
                return "#75FB4C"

            if (battery.percentage < 0.15)
                return "#EA3323"

            return "#FFFFFF"
        }

        font {
            family: "Material Symbols Rounded"
            pixelSize: 26
        }
    }

    Text {
        id: batteryPercentage

        anchors.verticalCenter: parent.verticalCenter

        text: Math.round(battery.percentage * 100) + "%"

        color: "#FFFFFF"

        font {
            family: "Poppins"
            pixelSize: 16
            weight: 500
        }
    }
}