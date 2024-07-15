import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import AuthModule 1.0
import Qt5Compat.GraphicalEffects

Window {
    width: 462
    height: 537
    visible: true
    title: qsTr("Знакомства")

    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    Rectangle {
        id: loginForm
        width: 462
        height: 537
        anchors.centerIn: parent
        color: "#FFFFFF"
        border.color: "#E0E0E0"
        border.width: 0.5
        radius: 4
        opacity: 0.9

        Rectangle {
            id: frame494
            width: 462
            height: 219
            color: "#FFFFFF"
            border.color: "#E0E0E0"
            border.width: 0.5
        }

        Rectangle {
            id: photo
            width: 78
            height: 78
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 32
            color: "#E0F1FF"
            radius: 39

            Image {
                id: profileImage
                source: "qrc:/source/img/source/img/logo.jpg"
                width: 78
                height: 78
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
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
        }

        Text {
            id: titleText
            text: "Вход на платформу"
            width: 224
            height: 29
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: photo.bottom
            anchors.topMargin: 20
            font.family: "Roboto"
            font.weight: Font.Medium
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            color: "#212121"
        }

        Text {
            id: subtitleText
            text: "Мы рады видеть вас снова"
            width: 180
            height: 17
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: titleText.bottom
            anchors.topMargin: 10
            font.family: "Roboto"
            font.weight: Font.Normal
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            color: "#616161"
        }

        Text {
            id: errorText
            text: "Error message"
            width: 141
            height: 17
            anchors.left: parent.left
            anchors.leftMargin: 32
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Roboto"
            font.weight: Font.Normal
            font.pixelSize: 14
            horizontalAlignment: Text.AlignRight
            color: "#F2453D"
            visible: false
        }

        Text {
            id: warningText
            text: "Warning message"
            width: 62
            height: 17
            anchors.left: parent.left
            anchors.leftMargin: 111
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 61
            font.family: "Roboto"
            font.weight: Font.Normal
            font.pixelSize: 14
            horizontalAlignment: Text.AlignRight
            color: "#F2453D"
            visible: false
        }
        Rectangle {
            id: frame493
            width: 462
            height: 185
            color: "#FFFFFF"
            anchors.top: frame494.bottom

            GridLayout {
                id: grid

                rows: 3
                columns: 2

                width: 462
                height: 150
                //anchors.top: parent.top
                anchors.centerIn: parent

                Text {

                    id: usernameLabel

                    Layout.row: 0
                    Layout.column: 0
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "* Электронная почта:"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    color: "#616161"
                }

                Text {
                    id: passLabel
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.row: 1
                    Layout.column: 0
                    //anchors.top: usernameLabel.bottom
                    text: "* Пароль:"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    color: "#616161"
                }

                TextField {
                    id: usernameField
                    Layout.minimumWidth: 242
                    Layout.minimumHeight: 36
                    Layout.row: 0
                    Layout.column: 1
                    Layout.alignment: Qt.AlignCenter
                    Layout.rightMargin: 20
                    text: "kostya"
                    width: 242
                    height: 36
                    placeholderText: "Username or email address"
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
                    validator: RegularExpressionValidator {
                        regularExpression: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
                    }
                }

                TextField {
                    id: passwordField
                    Layout.minimumWidth: 242
                    Layout.minimumHeight: 36
                    Layout.row: 1
                    Layout.column: 1
                    Layout.alignment: Qt.AlignCenter
                    Layout.rightMargin: 20
                    text: "12345"
                    //Layout.rightMargin: 10
                    width: 242
                    height: 36
                    placeholderText: "Password"
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
                    echoMode: TextField.Password

                    Image {
                        id: visibilityIcon
                        source: "qrc:/source/img/source/img/visibilityIcon.png"
                        width: 20
                        height: 20
                        horizontalAlignment: Image.AlignRight
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter

                        fillMode: Image.PreserveAspectFit
                        MouseArea {
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            onClicked: {
                                passwordField.echoMode = passwordField.echoMode
                                        === TextField.Password ? TextField.Normal : TextField.Password
                            }
                        }
                    }
                }

                Text {
                    id: loginText
                    Layout.row: 2
                    Layout.column: 1
                    Layout.topMargin: 5
                    text: "Я не помню пароль"
                    width: 124
                    height: 36
                    anchors.top: passwordField.bottom
                    font.family: "Roboto"
                    font.weight: Font.Medium

                    font.pixelSize: 14
                    color: "#3B87F9"

                    MouseArea {
                        id: loginTextMouseArea
                        anchors.fill: parent
                        onClicked: {
                            console.log("Я не помню пароль")
                        }
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }

        Rectangle {
            id: frame495
            width: 462
            height: 133
            anchors.bottom: parent.bottom
            color: "#FFFFFF"
            border.color: "#E0E0E0"
            border.width: 0.5
        }

        RowLayout {
            id: rowLayoutRegist
            width: 300
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: frame495.bottom
            anchors.bottomMargin: 32

            Text {
                id: labelText
                text: "У вас ещё нет аккаунта?"
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                color: "#616161"
            }

            Text {
                id: registText
                text: "Зарегистрироваться"
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                textFormat: Text.RichText
                color: "#2C98F0"
                Layout.rightMargin: 1

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        var component = Qt.createComponent(
                                    "qrc:/myFiles/source/qml/RegisterWindow.qml")
                        console.log("Component Status:", component.status,
                                    component.errorString())
                        var window = component.createObject()
                        window.show()
                    }
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
        AuthClass {

            id: authClassObj
        }

        Button {
            id: signUpButton
            width: 124
            height: 36
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: rowLayoutRegist.top
            anchors.bottomMargin: 20
            hoverEnabled: true
            Text {
                text: "Войти"
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 14
                anchors.centerIn: parent
                color: signUpButton.down ? "#000000" : (signUpButton.hovered ? "#000000" : "#FFFFFF")
            }

            background: Rectangle {
                color: signUpButton.down ? "#FFFFFF" : (signUpButton.hovered ? "#00FFFF" : "#3B87F9")
                radius: 4
            }

            onClicked: {
                if (authClassObj.checkUser(usernameField.text,
                                           passwordField.text)) {
                    var component = Qt.createComponent(
                                "qrc:/myFiles/source/qml/MainWindowApps.qml")
                    console.log("Component Status:", component.status,
                                component.errorString())
                    var window = component.createObject()
                    window.show()
                }
            }
        }
    }
}
