import Quickshell
import QtQuick

Rectangle {
    property bool active: false
    property string icon
    property string label

    signal clicked()
    
    radius: 25

    color: "#ffffff"
}