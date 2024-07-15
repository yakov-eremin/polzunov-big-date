import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Item {
    required width
    required height

    Rectangle {
        id: sendMessageArea
        anchors.bottom: parent.bottom
        width: parent.width
        height: 80
        color: "Blue"
    }
    Rectangle {
        anchors.bottom: sendMessageArea.top
        width: parent.width
        height: parent.height - sendMessageArea.height
        color: "Red"
        ListView {
            anchors.fill: parent
            clip: true
            model: 10
            delegate: Message {
                width: parent.width * 0.9
                anchors.right: parent.right
                anchors.margins: 5
            }

            // Логика для динамической загрузки элементов
            onContentYChanged: {
                if (contentY + height > contentHeight - 200) {

                    // Здесь можно добавлять дополнительные элементы к модели
                }
            }
            highlightRangeMode: ListView.StrictlyEnforceRange
        }
    }
}
