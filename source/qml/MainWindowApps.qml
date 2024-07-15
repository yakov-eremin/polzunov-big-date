import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Window {
    id: mainWindowApp
    width: 1080
    height: 800
    title: qsTr("Знакомства")

    minimumHeight: 800
    minimumWidth: 1080

    Rectangle {
        anchors.fill: parent

        Rectangle {
            id: menuSpan
            color: "#FFFFFF"
            border.color: "#E0E0E0"
            border.width: 0
            opacity: 0.9
            width: 250
            height: parent.height
            Text {
                id: titleL
                text: "Категории"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 20
                anchors.topMargin: 20
                anchors.bottomMargin: 20
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 16
            }

            Button {
                id: mainMenuB
                width: menuSpan.width
                height: 50
                hoverEnabled: true
                anchors.top: titleL.bottom
                anchors.topMargin: 10
                Image {
                    id: mainMenuIcon
                    source: "qrc:/source/img/source/img/mainMenuIcon.png"
                    width: 20
                    height: 20
                    horizontalAlignment: Image.AlignRight
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    visible: false
                }

                ColorOverlay {
                    anchors.fill: mainMenuIcon
                    source: mainMenuIcon
                    color: mainMenuB.down ? "#2C98F0" : (mainMenuB.hovered ? "#000000" : "#757575")
                }

                Text {
                    text: "Главная"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    anchors.left: mainMenuIcon.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    color: mainMenuB.down ? "#2C98F0" : (mainMenuB.hovered ? "#000000" : "#757575")
                }

                background: Rectangle {
                    color: mainMenuB.down ? "#BDBDBD" : (mainMenuB.hovered ? "#00FFFF" : "#FFFFFF")
                    border.width: 0
                }
                onClicked: {
                    windowLoader.source = "qrc:/myFiles/MainMenuWindow.qml"
                }
            }

            Button {
                id: miniAppsB
                width: menuSpan.width
                height: 50
                hoverEnabled: true
                anchors.top: mainMenuB.bottom
                Image {
                    id: miniAppsIcon
                    source: "qrc:/source/img/source/img/miniAppsIcon.png"
                    width: 20
                    height: 20
                    horizontalAlignment: Image.AlignRight
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    visible: false
                }

                ColorOverlay {
                    anchors.fill: miniAppsIcon
                    source: miniAppsIcon
                    color: miniAppsB.down ? "#2C98F0" : (miniAppsB.hovered ? "#000000" : "#757575")
                }

                Text {
                    text: "Мини-приложения"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    anchors.left: miniAppsIcon.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    color: miniAppsB.down ? "#2C98F0" : (miniAppsB.hovered ? "#000000" : "#757575")
                }

                background: Rectangle {
                    color: miniAppsB.down ? "#BDBDBD" : (miniAppsB.hovered ? "#00FFFF" : "#FFFFFF")
                    border.width: 0
                }

                onClicked: {
                    windowLoader.source = "qrc:/myFiles/source/qml/MiniAppsWindow.qml"
                }
            }

            Button {
                id: popularB
                width: menuSpan.width
                height: 50
                hoverEnabled: true
                anchors.top: miniAppsB.bottom
                Image {
                    id: popularIcon
                    source: "qrc:/source/img/source/img/popularIcon.png"
                    width: 20
                    height: 20
                    horizontalAlignment: Image.AlignRight
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    visible: false
                }

                ColorOverlay {
                    anchors.fill: popularIcon
                    source: popularIcon
                    color: popularB.down ? "#2C98F0" : (popularB.hovered ? "#000000" : "#757575")
                }

                Text {
                    text: "Популярное"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    anchors.left: popularIcon.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    color: popularB.down ? "#2C98F0" : (popularB.hovered ? "#000000" : "#757575")
                }

                background: Rectangle {
                    color: popularB.down ? "#BDBDBD" : (popularB.hovered ? "#00FFFF" : "#FFFFFF")
                    border.width: 0
                }

                onClicked: {
                    windowLoader.source = "qrc:/myFiles/source/qml/PopularWindow.qml"
                }
            }
            Button {
                id: top10B
                width: menuSpan.width
                height: 50
                hoverEnabled: true
                anchors.top: popularB.bottom
                Image {
                    id: top10Icon
                    source: "qrc:/source/img/source/img/top10Icon.png"
                    width: 20
                    height: 20
                    horizontalAlignment: Image.AlignRight
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    visible: false
                }

                ColorOverlay {
                    anchors.fill: top10Icon
                    source: top10Icon
                    color: top10B.down ? "#2C98F0" : (top10B.hovered ? "#000000" : "#757575")
                }

                Text {
                    text: "Топ 10"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    anchors.left: top10Icon.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    color: top10B.down ? "#2C98F0" : (top10B.hovered ? "#000000" : "#757575")
                }

                background: Rectangle {
                    color: top10B.down ? "#BDBDBD" : (top10B.hovered ? "#00FFFF" : "#FFFFFF")
                    border.width: 0
                }

                onClicked: {
                    windowLoader.source = "qrc:/myFiles/source/qml/Top10Window.qml"
                }
            }
            Button {
                id: newB
                width: menuSpan.width
                height: 50
                hoverEnabled: true
                anchors.top: top10B.bottom
                Image {
                    id: newIcon
                    source: "qrc:/source/img/source/img/newIcon.png"
                    width: 20
                    height: 20
                    horizontalAlignment: Image.AlignRight
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    visible: false
                }

                ColorOverlay {
                    anchors.fill: newIcon
                    source: newIcon
                    color: newB.down ? "#2C98F0" : (newB.hovered ? "#000000" : "#757575")
                }

                Text {
                    text: "Новые"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    anchors.left: newIcon.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    color: newB.down ? "#2C98F0" : (newB.hovered ? "#000000" : "#757575")
                }

                background: Rectangle {
                    color: newB.down ? "#BDBDBD" : (newB.hovered ? "#00FFFF" : "#FFFFFF")
                    border.width: 0
                }

                onClicked: {
                    windowLoader.source = "qrc:/myFiles/source/qml/NewWindow.qml"
                }
            }

            Button {
                id: сommunicationB
                width: menuSpan.width
                height: 50
                hoverEnabled: true
                anchors.top: newB.bottom
                Image {
                    id: communicationIcon
                    source: "qrc:/source/img/source/img/communicationIcon.png"
                    width: 20
                    height: 20
                    horizontalAlignment: Image.AlignRight
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    visible: false
                }

                ColorOverlay {
                    anchors.fill: communicationIcon
                    source: communicationIcon
                    color: сommunicationB.down ? "#2C98F0" : (сommunicationB.hovered ? "#000000" : "#757575")
                }

                Text {
                    text: "Общение"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    anchors.left: communicationIcon.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    color: сommunicationB.down ? "#2C98F0" : (сommunicationB.hovered ? "#000000" : "#757575")
                }

                background: Rectangle {
                    color: сommunicationB.down ? "#BDBDBD" : (сommunicationB.hovered ? "#00FFFF" : "#FFFFFF")
                    border.width: 0
                }

                onClicked: {
                    windowLoader.setSource(
                                "qrc:/myFiles/source/qml/CommunicationWindow.qml",
                                {
                                    "width": moduleLoader.width,
                                    "height": moduleLoader.height
                                })
                }
            }

            Button {
                id: questionnairesB
                width: menuSpan.width
                height: 50
                hoverEnabled: true
                anchors.top: сommunicationB.bottom
                Image {
                    id: questionnairesIcon
                    source: "qrc:/source/img/source/img/questionnairesIcon.png"
                    width: 20
                    height: 20
                    horizontalAlignment: Image.AlignRight
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    visible: false
                }

                ColorOverlay {
                    anchors.fill: questionnairesIcon
                    source: questionnairesIcon
                    color: questionnairesB.down ? "#2C98F0" : (questionnairesB.hovered ? "#000000" : "#757575")
                }

                Text {
                    text: "Анкеты"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    anchors.left: questionnairesIcon.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    color: questionnairesB.down ? "#2C98F0" : (questionnairesB.hovered ? "#000000" : "#757575")
                }

                background: Rectangle {
                    color: questionnairesB.down ? "#BDBDBD" : (questionnairesB.hovered ? "#00FFFF" : "#FFFFFF")
                    border.width: 0
                }

                onClicked: {
                    windowLoader.source = "qrc:/myFiles/source/qml/QuestionnairesWindow.qml"
                }
            }

            Button {
                id: aboutB
                width: menuSpan.width
                height: 45
                hoverEnabled: true
                anchors.bottom: policyB.top

                Text {
                    text: "Подробнее о приложении"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    color: aboutB.down ? "#2C98F0" : (aboutB.hovered ? "#000000" : "#757575")
                }

                background: Rectangle {
                    color: aboutB.down ? "#BDBDBD" : (aboutB.hovered ? "#00FFFF" : "#FFFFFF")
                    border.width: 0
                }

                onClicked: {
                    windowLoader.source = "qrc:/myFiles/source/qml/AboutWindow.qml"
                }
            }

            Button {
                id: policyB
                width: menuSpan.width
                height: 45
                hoverEnabled: true
                anchors.bottom: userView.top

                Text {
                    text: "Политика конфиденциальности"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    color: policyB.down ? "#2C98F0" : (policyB.hovered ? "#000000" : "#757575")
                }

                background: Rectangle {
                    color: policyB.down ? "#BDBDBD" : (policyB.hovered ? "#00FFFF" : "#FFFFFF")
                    border.width: 0
                }

                onClicked: {
                    windowLoader.source = "qrc:/myFiles/source/qml/PolicyWindow.qml"
                }
            }

            Rectangle {
                id: userView
                color: "#FFFFFF"
                border.color: "#E0E0E0"
                border.width: 0.5
                opacity: 0.9
                width: parent.width
                height: 80
                anchors.left: parent.left
                anchors.bottom: parent.bottom

                Image {
                    id: profileImage
                    source: "qrc:/source/img/source/img/logo.jpg"
                    width: 48
                    height: 48
                    anchors.left: parent.left

                    anchors.leftMargin: 15
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
                    color: "#FFFFFF"
                    width: parent.width
                    height: 20
                    anchors.left: profileImage.right
                    anchors.leftMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 20
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
                }

                Rectangle {
                    color: "#FFFFFF"
                    width: parent.width
                    height: 20
                    anchors.left: profileImage.right
                    anchors.leftMargin: 20
                    anchors.top: userDataView.bottom
                    anchors.topMargin: 2
                    Text {
                        id: editProfileL
                        text: "Редактировать профиль"
                        font.family: "Roboto"
                        font.weight: Font.Normal
                        font.pixelSize: 12
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#616161"

                        MouseArea {
                            id: loginTextMouseArea
                            anchors.fill: parent
                            onClicked: {
                                windowLoader.source
                                        = "qrc:/myFiles/source/qml/EditProfileWindow.qml"
                            }

                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }
        }

        Rectangle {
            id: moduleLoader

            width: parent.width - menuSpan.width
            height: parent.height
            color: "#BDBDBD"
            border.width: 0
            opacity: 0.9
            anchors.left: menuSpan.right

            Loader {
                id: windowLoader
                anchors.fill: parent
                source: "MainMenuWindow.qml"
            }
        }
    }
}
