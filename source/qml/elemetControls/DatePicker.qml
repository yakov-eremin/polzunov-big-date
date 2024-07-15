import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import QDatePicker

Item {
    id: root
    required width
    required height

    required property string locale
    required property string calendar

    required property ApplicationWindow mainWindow

    property string placeholderText: ""
    property string selectedDateText: ""

    property date selectedDate
    property date minDate
    property date maxDate

    function reset() {
        root.selectedDate = new Date("Invalid Date")
        root.selectedDateText = ''
    }

    QDatePicker {
        id: qDatePicker

        locale: root.locale
        calendar: root.calendar
    }

    Rectangle {
        color: "#FAFAFA"
        anchors.fill: parent
        radius: 10
        border {
            width: 1
            color: "#BDBDBD"
        }
    }

    Label {
        text: root.selectedDateText !== "" ? root.selectedDateText : root.placeholderText
        width: parent.width
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Qt.ElideRight
        font.family: "Roboto"
        font.weight: Font.Normal
        font.pixelSize: 12
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            dateTimeDialog.open()
        }
    }

    Dialog {
        id: dateTimeDialog

        modal: true
        width: 350
        height: 400
        bottomPadding: 0
        topPadding: 0

        background: Rectangle {
            color: "#FFFFFF"
            border.color: "#E0E0E0"
            border.width: 0.5
            radius: 5
        }

        parent: mainWindow.contentItem
        anchors {
            centerIn: parent
        }

        property bool isTimeSelection: false
        property bool isMinuteSelction: false

        property date tempSelectedDate: root.selectedDate.toString(
                                            ) !== "Invalid Date" ? new Date(root.selectedDate) : new Date()

        onTempSelectedDateChanged: {
            if (minDate.toString() !== "Invalid Date"
                    && minDate > tempSelectedDate)
                tempSelectedDate = minDate
            else if (maxDate.toString() !== "Invalid Date"
                     && maxDate < tempSelectedDate)
                tempSelectedDate = maxDate
        }

        function setLocaleDate(localeYear, localeMonth, localeDay) {
            var GregorianDate = qDatePicker.localeToGregorianDate(localeYear,
                                                                  localeMonth,
                                                                  localeDay)
            dateTimeDialog.tempSelectedDate = new Date(GregorianDate)
        }

        function isDateInRange(gregorianDate) {
            var minDate = root.minDate
            var maxDate = root.maxDate

            if (dateTimeDialog.isTimeSelection === false) {
                minDate = new Date(minDate.setHours(0, 0, 0, 0))
                maxDate = new Date(maxDate.setHours(23, 59, 59, 0))
            }

            if (minDate.toString() !== "Invalid Date" && maxDate.toString(
                        ) !== "Invalid Date")
                return minDate <= gregorianDate && gregorianDate <= maxDate
            if (minDate.toString() !== "Invalid Date")
                return minDate <= gregorianDate
            else if (maxDate.toString() !== "Invalid Date")
                return gregorianDate <= maxDate

            return true
        }

        header: Pane {
            id: headerRect

            property var selectedDateString: qDatePicker.calendar
                                             !== "" ? qDatePicker.dateToLocalDateString(
                                                          dateTimeDialog.tempSelectedDate.getFullYear(
                                                              ),
                                                          dateTimeDialog.tempSelectedDate.getMonth(
                                                              ) + 1,
                                                          // because getMonth() is in 0 to 11
                                                          dateTimeDialog.tempSelectedDate.getDate(
                                                              )) : []

            property int selectedYear: Number(selectedDateString[0]) ?? 0
            property int selectedMonth: Number(selectedDateString[1]) ?? 0
            property int selectedDay: Number(selectedDateString[2]) ?? 0

            property string selectedDayWeekName: selectedDateString[3] ?? ""
            property string selectedMonthName: selectedDateString[4] ?? ""

            height: 40
            padding: 0
            background: Rectangle {
                color: "#FFFFFF"
            }

            ColumnLayout {

                // This Header will show when user choosing date
                visible: enabled
                enabled: !dateTimeDialog.isTimeSelection
                layoutDirection: Qt.locale(qDatePicker.locale).textDirection

                anchors {
                    fill: parent
                    margins: 10
                }

                Label {
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 16
                    text: "Выберите дату"
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Popup {
            id: monthSelectorPopup

            x: (monthTxt.width - width) / 2
            y: monthTxt.height
            parent: monthTxt
            width: 100
            height: 300
            enabled: !dateTimeDialog.isTimeSelection
            background: Rectangle {
                color: "#FFFFFF"
                border.color: "#E0E0E0"
                border.width: 0.5
                radius: 2
            }

            Flickable {

                anchors.fill: parent
                clip: true
                contentHeight: column.height

                Column {

                    id: column
                    width: parent.width
                    Repeater {
                        model: qDatePicker.calendar !== "" ? qDatePicker.getShortMonthsName(
                                                                 ) : []
                        delegate: Button {
                            text: modelData
                            enabled: dateTimeDialog.isDateInRange(
                                         qDatePicker.localeToGregorianDate(
                                             headerRect.selectedYear,
                                             index + 1, headerRect.selectedDay))
                            height: 25
                            width: 85
                            flat: !highlighted
                            highlighted: text === headerRect.selectedMonthName
                            onClicked: {
                                dateTimeDialog.setLocaleDate(
                                            headerRect.selectedYear, index + 1,
                                            headerRect.selectedDay)
                                monthSelectorPopup.close()
                            }
                        }
                    }
                }
            }
        }

        Popup {
            id: yearSelectorPopup

            x: (yearTxt.width - width) / 2
            y: yearTxt.height
            parent: yearTxt
            width: 100
            height: 300
            enabled: !dateTimeDialog.isTimeSelection

            background: Rectangle {
                color: "#FFFFFF"
                border.color: "#E0E0E0"
                border.width: 0.5
                radius: 2
            }

            Flickable {
                anchors.fill: parent
                clip: true
                contentHeight: yearColumn.height

                Column {
                    id: yearColumn
                    width: parent.width
                    Repeater {
                        model: yearModel
                        delegate: Button {
                            property int year: modelData
                            text: new Date().getFullYear() + year
                            enabled: dateTimeDialog.isDateInRange(
                                         qDatePicker.localeToGregorianDate(
                                             Number(text),
                                             headerRect.selectedMonth,
                                             headerRect.selectedDay))
                            height: 25
                            width: 85

                            flat: !highlighted
                            highlighted: Number(
                                             text) === headerRect.selectedYear
                            onClicked: {
                                dateTimeDialog.setLocaleDate(
                                            Number(text),
                                            headerRect.selectedMonth,
                                            headerRect.selectedDay)
                                yearSelectorPopup.close()
                            }
                        }
                    }
                }
            }
        }

        ListModel {
            id: yearModel
        }

        // Заполнение модели годами от 1900 до текущего года
        Component.onCompleted: {
            let currentYear = new Date().getFullYear()
            for (var year = currentYear; year >= 1900; year--) {
                yearModel.append({
                                     "year": year - currentYear
                                 })
            }
        }

        Flow {
            anchors.fill: parent

            Flow {
                id: dateSelectionItem

                width: parent.width
                height: 100
                enabled: !dateTimeDialog.isTimeSelection
                visible: enabled
                spacing: 5

                RowLayout {
                    id: dateRow
                    width: parent.width
                    height: 30
                    layoutDirection: Qt.locale(qDatePicker.locale).textDirection

                    Button {
                        text: dateRow.layoutDirection === Qt.RightToLeft ? ">" : "<"
                        flat: true
                        highlighted: true

                        font {
                            bold: true
                        }
                        enabled: dateTimeDialog.isDateInRange(
                                     qDatePicker.localeToGregorianDate(
                                         headerRect.selectedYear,
                                         headerRect.selectedMonth - 1,
                                         headerRect.selectedDay))
                        onClicked: {
                            dateTimeDialog.setLocaleDate(
                                        headerRect.selectedYear,
                                        headerRect.selectedMonth - 1,
                                        headerRect.selectedDay)
                        }

                        background: Rectangle {
                            color: "#FFFFFF"
                            border.color: "#E0E0E0"
                            border.width: 0.5
                            radius: 5
                        }
                    }

                    Button {
                        id: monthTxt
                        text: headerRect.selectedMonthName
                        Layout.fillWidth: true
                        flat: true
                        onClicked: {
                            monthSelectorPopup.open()
                        }

                        background: Rectangle {
                            color: "#FFFFFF"
                            //border.color: "#E0E0E0"
                            //border.width: 0.5
                            radius: 5
                        }
                    }

                    Button {
                        id: yearTxt
                        text: headerRect.selectedYear
                        flat: true
                        Layout.fillWidth: true
                        onClicked: {
                            yearSelectorPopup.open()
                        }
                        background: Rectangle {
                            color: "#FFFFFF"
                            //border.color: "#E0E0E0"
                            //border.width: 0.5
                            radius: 5
                        }
                    }

                    Button {
                        text: dateRow.layoutDirection === Qt.RightToLeft ? "<" : ">"
                        flat: true
                        highlighted: true
                        LayoutMirroring.enabled: true
                        enabled: dateTimeDialog.isDateInRange(
                                     qDatePicker.localeToGregorianDate(
                                         headerRect.selectedYear,
                                         headerRect.selectedMonth + 1,
                                         headerRect.selectedDay))
                        font {
                            bold: true
                        }
                        onClicked: {
                            dateTimeDialog.setLocaleDate(
                                        headerRect.selectedYear,
                                        headerRect.selectedMonth + 1,
                                        headerRect.selectedDay)
                        }
                        background: Rectangle {
                            color: "#FFFFFF"
                            border.color: "#E0E0E0"
                            border.width: 0.5
                            radius: 5
                        }
                    }
                }

                RowLayout {
                    width: parent.width
                    height: 50
                    layoutDirection: Qt.locale(qDatePicker.locale).textDirection
                    Repeater {
                        model: qDatePicker.calendar !== "" ? qDatePicker.getNarrowWeekDaysName(
                                                                 ) : []
                        delegate: Text {
                            text: modelData
                            color: "#000000"
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font {
                                pixelSize: 13
                                bold: true
                            }
                        }
                    }
                }

                GridLayout {
                    width: parent.width
                    columns: 7
                    height: 175
                    layoutDirection: Qt.locale(qDatePicker.locale).textDirection

                    Repeater {
                        model: qDatePicker.getGridDaysOfMonth(
                                   headerRect.selectedYear,
                                   headerRect.selectedMonth)
                        delegate: RoundButton {
                            property date gregorianDate: qDatePicker.localeToGregorianDate(
                                                             headerRect.selectedYear,
                                                             headerRect.selectedMonth,
                                                             Number(modelData))
                            text: modelData === "0" ? "" : modelData
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            flat: !highlighted
                            highlighted: Number(
                                             modelData) === headerRect.selectedDay

                            font {
                                pixelSize: 12
                            }

                            enabled: {
                                if (modelData !== "0") {
                                    return dateTimeDialog.isDateInRange(
                                                gregorianDate)
                                } else
                                    return false
                            }

                            onClicked: {
                                dateTimeDialog.tempSelectedDate = new Date(gregorianDate)
                            }
                        }
                    }
                }
            }

            RowLayout {
                id: btnsLayout
                width: parent.width
                height: 50
                anchors.bottom: parent.bottom
                layoutDirection: Qt.locale(qDatePicker.locale).textDirection

                RoundButton {
                    text: qsTr("Cancel")
                    flat: true
                    Layout.fillWidth: true
                    onClicked: {
                        dateTimeDialog.close()
                    }
                    background: Rectangle {
                        color: "#FFFFFF"
                        border.color: "#BDBDBD"
                        border.width: 0.5
                        radius: 5
                    }
                }

                RoundButton {
                    text: qsTr("Ok")
                    flat: true
                    Layout.fillWidth: true
                    onClicked: {

                        root.selectedDate = dateTimeDialog.tempSelectedDate
                        root.selectedDateText = ("%1.%2.%3").arg(
                                    headerRect.selectedDay.toString().padStart(
                                        2, '0')).arg(
                                    (headerRect.selectedMonth.toString(
                                         ).padStart(2, '0'))).arg(
                                    headerRect.selectedYear)

                        dateTimeDialog.close()
                    }
                    background: Rectangle {
                        color: "#FFFFFF"
                        border.color: "#BDBDBD"
                        border.width: 0.5
                        radius: 5
                    }
                }
            }
        }
    }
}
