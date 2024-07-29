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
        color: "#FFFFFF"

        Button {
            id: sendMessageB
            width: 60
            height: parent.height - 10
            hoverEnabled: true
            anchors.top: sendMessageArea.top
            anchors.right: sendMessageArea.right
            anchors.margins: 5

            Image {
                id: mainMenuIcon
                source: "qrc:/source/img/source/img/sendMessageIcon.svg"
                sourceSize: Qt.size(40, 40)
                width: sourceSize.width
                height: sourceSize.height
                anchors.centerIn: parent

                property bool rounded: false
                property bool adapt: false

                layer.enabled: rounded
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: img.width
                        height: img.height
                        Rectangle {
                            anchors.centerIn: parent
                            width: mainMenuIcon.adapt ? mainMenuIcon.width : Math.min(
                                                            mainMenuIcon.width,
                                                            mainMenuIcon.height)
                            height: mainMenuIcon.adapt ? mainMenuIcon.height : width
                            radius: Math.min(width, height)
                        }
                    }
                }
                //visible: false
            }
            background: Rectangle {
                color: "#FFFFFF"
                border.width: 0
                radius: 5
            }

            onClicked: {
                messageField.clear()
            }
        }

        TextField {
            id: messageField
            anchors.right: sendMessageB.left
            width: parent.width - sendMessageB.width - 15
            height: parent.height - 10
            anchors.top: parent.top
            anchors.margins: 5
            placeholderText: "Сообщение..."
            font.family: "Roboto"
            font.weight: Font.Normal
            font.pixelSize: 14

            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "#212121"
            background: Rectangle {
                color: "#FAFAFA"
                border.color: "#BDBDBD"
                border.width: 0.5
                radius: 4
            }
            inputMethodHints: Qt.ImhNoAutoUppercase
        }
    }
    Rectangle {
        id: messageArea
        anchors.bottom: sendMessageArea.top
        width: parent.width
        height: parent.height - sendMessageArea.height
        color: "#FFFFFF"
        border.color: "#E0E0E0"
        border.width: 0
        opacity: 0.9

        ListView {
            anchors.fill: messageArea
            clip: true

            model: ListModel {
                ListElement {

                    messageTextElem: "Привет"
                    timeTextElem: "00:01"
                    senderElem: "1"
                }
                ListElement {
                    messageTextElem: "Привет"
                    timeTextElem: "00:02"
                    senderElem: "0"
                }
                ListElement {
                    messageTextElem: "Как дела?"
                    timeTextElem: "00:02"
                    senderElem: "1"
                }
                ListElement {
                    messageTextElem: "Отлично"
                    timeTextElem: "00:03"
                    senderElem: "0"
                }
            }
            delegate: Message {

                //maxWidth: parent.width * 0.9
                sender: senderElem
                timeText: timeTextElem

                messageText: messageTextElem
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
