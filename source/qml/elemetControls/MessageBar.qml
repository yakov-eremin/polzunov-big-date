import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Item {
    id: root
    required width
    required height
    Rectangle {
        id: messageBlock
        width: parent.width
        height: parent.height
        color: "#FFFFFF"
        border.color: "#E0E0E0"
        border.width: 0.5
        opacity: 0.9
        anchors.left: parent.left

        MouseArea {
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: {


            }
            hoverEnabled: true
            onEntered: {
                messageBlock.color = "#F0F0F0"
            }
            onExited: {
                messageBlock.color = "#FFFFFF"
            }
        }

        Image {
            id: profileImage
            source: "qrc:/source/img/source/img/logo.jpg"
            width: 50
            height: 50
            anchors.left: parent.left

            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter

            fillMode: Image.PreserveAspectCrop

            property bool rounded: true
            property bool adapt: true

            layer.enabled: rounded
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: profileImage.width
                    height: profileImage.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: profileImage.adapt ? profileImage.width : Math.min(
                                                        profileImage.width,
                                                        profileImage.height)
                        height: profileImage.adapt ? profileImage.height : width
                        radius: Math.min(width, height)
                    }
                }
            }
        }
        Rectangle {
            id: userDataView
            color: "transparent"
            width: parent.width - profileImage.width - 10
            height: parent.height * 0.4
            anchors.left: profileImage.right
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
            Text {
                id: usernameL
                text: "Денис Будников"
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 14
                //anchors.leftMargin:
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: "#212121"
            }
            Text {
                id: timeL
                text: "00:00"
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 10
                //anchors.leftMargin:
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                color: "#212121"
            }
        }

        Rectangle {

            color: "transparent"
            width: parent.width - profileImage.width - 10
            height: parent.height * 0.4
            anchors.left: profileImage.right
            anchors.leftMargin: 5
            anchors.top: userDataView.bottom
            anchors.topMargin: 2
            Text {
                id: editProfileL
                text: "Последнее сообщение"
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 12
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: "#616161"
            }
        }
    }
}
