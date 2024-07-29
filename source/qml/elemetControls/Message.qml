import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    property string messageText: "This text is very long and should be two linesффффффффффффффффффффффффффффффффффффффффф ффффффффффффффффффффффффффффффф" // Текст сообщения
    property string timeText: "00:00"
    property int maxWidth: 100
    property string sender: "0"

    // Установите максимальную ширину
    width: parent.width
    height: sendMessageArea.height + 10

    Rectangle {
        id: sendMessageArea
        width: root.width * 0.9
        height: messageTextItem.height + timeTextItem.height

        anchors.left: sender === "0" ? undefined : root.left
        anchors.right: sender === "1" ? undefined : root.right
        anchors.margins: 5
        color: "#FFFFFF"
        border.color: "#000000"
        border.width: 0.5
        opacity: 0.9
        radius: 5

        Text {
            id: messageTextItem
            width: sendMessageArea.width // Установите ширину равной максимальной ширине
            wrapMode: Text.WrapAnywhere // Используйте WordWrap для переноса по словам
            text: root.messageText
            font.pixelSize: 14
            color: "#000000"
            anchors.left: parent.left
            anchors.leftMargin: 5
        }
        Text {
            id: timeTextItem
            anchors.top: messageTextItem.bottom
            anchors.right: parent.right
            anchors.rightMargin: 5
            wrapMode: Text.NoWrap
            text: root.timeText
            font.pixelSize: 14
            color: "#000000"
        }
    }
}
