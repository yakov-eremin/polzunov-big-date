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

        ListView {
            anchors.fill: parent
            clip: true
            highlightRangeMode: ListView.StrictlyEnforceRange

            model: ListModel {
                ListElement {

                    nameUserElem: "Константин Воробьев"
                    timeTextElem: "00:03"
                    lastMessageElem: "Отлично"
                }
            }
            delegate: MessageBar {
                nameUser: nameUserElem
                timeMessage: timeTextElem
                lastMessage: lastMessageElem
            }

            // Логика для динамической загрузки элементов
            onContentYChanged: {
                if (contentY + height > contentHeight - 200) {

                    // Здесь можно добавлять дополнительные элементы к модели
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
