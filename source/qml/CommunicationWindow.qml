import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

import "qrc:/myFiles/source/qml/elemetControls"

Item {
    required width
    required height

    Rectangle {
        id: messageBar
        width: parent.width * 0.4
        height: parent.height
        Flickable {
            anchors.fill: parent
            clip: true
            contentHeight: column.height
            Column {

                id: column
                width: parent.width
                spacing: 1
                Repeater {
                    model: 10
                    delegate: MessageBar {
                        width: parent.width
                        height: 60
                    }
                }
            }
        }
    }
    Rectangle {
        id: messageShowLayout
        width: parent.width * 0.6
        height: parent.height
        anchors.left: messageBar.right

        MessageShowLayout {
            width: parent.width
            height: parent.height
        }
    }
}
