import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    property string messageText: "This text is very long and should be two linesффффффффффффффффффффффффффффффффффффффффф ффффффффффффффффффффффффффффффф" // Текст сообщения
    property string timeText: "00:00"
    property int maxWidth

    width: maxWidth
    height: column.height

    Column {
        id: column
        width: root.maxWidth
        Rectangle {
            id: sendMessageArea
            width: root.maxWidth
            height: messageTextItem.height + timeTextItem.height

            color: "#FFFFFF"
            border.color: "#000000"
            border.width: 0.5
            opacity: 0.9
            radius: 5

            Label {
                id: messageTextItem
                width: root.maxWidth
                wrapMode: Text.WrapAnywhere
                text: root.messageText
                font.pixelSize: 14
                color: "#000000"
            }
            Text {
                id: timeTextItem
                anchors.top: messageTextItem.bottom
                anchors.right: parent.right
                wrapMode: Text.NoWrap
                text: root.timeText
                font.pixelSize: 14
                color: "#000000"
            }
        }
    }
}
