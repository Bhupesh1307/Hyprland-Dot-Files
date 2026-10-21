import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property date today: new Date()
    property date displayedMonth: new Date(
        today.getFullYear(),
        today.getMonth(),
        1
    )
    property date selectedDate: today

    color: "#0f0f0f"
    border.width: 1
    border.color: "#2d2d2d"
                
    radius: 25

    readonly property int firstDay:
        new Date(
            displayedMonth.getFullYear(),
            displayedMonth.getMonth(),
            1
        ).getDay()

    readonly property int daysInMonth:
        new Date(
            displayedMonth.getFullYear(),
            displayedMonth.getMonth() + 1,
            0
        ).getDate()

    function changeMonth(amount) {
        displayedMonth = new Date(
            displayedMonth.getFullYear(),
            displayedMonth.getMonth() + amount,
            1
        )
    }

    function sameDay(a, b) {
        return a.getFullYear() === b.getFullYear()
            && a.getMonth() === b.getMonth()
            && a.getDate() === b.getDate()
    }

    Column {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 14

        // Month navigation
        RowLayout {
            width: parent.width
            height: 32
            spacing: 8

            Text {
                text: "‹"
                color: "#a1a1aa"
                font.pixelSize: 26
                width: 28
                horizontalAlignment: Text.AlignHCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.changeMonth(-1)
                }
            }

            Text {
                anchors.centerIn: parent
                text: Qt.formatDate(root.displayedMonth, "MMMM yyyy")
                color: "#fafafa"

                font {
                    pixelSize: 17
                    weight: DemiBold
                }

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                width: parent.width - 104
            }

            Text {
                text: "›"
                color: "#a1a1aa"
                font.pixelSize: 26
                width: 28
                horizontalAlignment: Text.AlignHCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.changeMonth(1)
                }
            }
        }

        Item {
            width: parent.width
            height: 25

            Text {
                text: "Today"
                color: "#3a6aed"
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 15

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.today = new Date()
                        root.displayedMonth = new Date(
                            root.today.getFullYear(),
                            root.today.getMonth(),
                            1
                        )
                        root.selectedDate = root.today
                    }
                }
            }
        }

        // Weekday headings
        Row {
            width: parent.width
            height: 10

            Repeater {
                model: ["S", "M", "T", "W", "T", "F", "S"]

                Text {
                    required property string modelData
                    width: parent.width / 7
                    text: modelData
                    color: "#71717a"
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        // Six weeks, including adjacent-month dates
        Grid {
            id: dateGrid
            width: parent.width
            columns: 7
            rowSpacing: 5
            columnSpacing: 0

            Repeater {
                model: 42

                Rectangle {
                    required property int index

                    readonly property date cellDate: new Date(
                        root.displayedMonth.getFullYear(),
                        root.displayedMonth.getMonth(),
                        index - root.firstDay + 1
                    )

                    width: dateGrid.width / 7
                    height: 29
                    radius: 9

                    color: {
                        if (root.sameDay(cellDate, root.selectedDate))
                            return '#3a6aed'
                        if (root.sameDay(cellDate, root.today))
                            return "#3f3f46"
                        return "transparent"
                    }

                    Text {
                        anchors.centerIn: parent
                        text: parent.cellDate.getDate()
                        font.pixelSize: 12

                        color: {
                            if (root.sameDay(parent.cellDate, root.selectedDate))
                                return "#ffffff"
                            if (parent.cellDate.getMonth()
                                !== root.displayedMonth.getMonth())
                                return "#52525b"
                            if (root.sameDay(parent.cellDate, root.today))
                                return "#c4b5fd"
                            return "#d4d4d8"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.selectedDate = parent.cellDate
                            root.displayedMonth = new Date(
                                parent.cellDate.getFullYear(),
                                parent.cellDate.getMonth(),
                                1
                            )
                        }
                    }
                }
            }
        }

        Text {
            text: Qt.formatDate(root.selectedDate, "dddd, d MMMM yyyy")
            color: "#a1a1aa"
            font.pixelSize: 12
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
