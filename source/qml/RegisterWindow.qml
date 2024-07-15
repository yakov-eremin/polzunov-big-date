import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import AuthModule 1.0

import Qt5Compat.GraphicalEffects

import "qrc:/myFiles/source/qml/elemetControls"

ApplicationWindow {
    id: registerWindow
    width: 462
    height: 780
    visible: true
    title: qsTr("Знакомства")

    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    Rectangle {
        id: registerForm
        width: parent.width
        height: parent.height
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
            text: "Создайте новый аккаунт"
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
            text: "Присоединяйся к сообществу из 5 тыс. человек!"
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

                rows: 7
                columns: 2
                rowSpacing: 20
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
                    text: "* Имя:"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    color: "#616161"
                }

                Text {

                    id: switchLabel

                    Layout.row: 1
                    Layout.column: 0
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Пол:"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    color: "#616161"
                }

                Text {

                    id: dateLabel

                    Layout.row: 2
                    Layout.column: 0
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "* Дата рождения:"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    color: "#616161"
                }

                Text {

                    id: cityLabel

                    Layout.row: 3
                    Layout.column: 0
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "Город:"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    color: "#616161"
                }

                Text {

                    id: emailLabel

                    Layout.row: 4
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
                    Layout.row: 5
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

                Text {
                    id: menGenderLabel
                    Layout.row: 1
                    Layout.column: 1
                    text: "Мужчина"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    color: "#212121"
                }

                Switch {
                    id: genderSwitch
                    Layout.row: 1
                    Layout.column: 1
                    Layout.alignment: Qt.AlignCenter
                    Layout.rightMargin: 20
                    anchors.left: menGenderLabel.right
                    anchors.leftMargin: 20
                    checked: true

                    indicator: Rectangle {
                        implicitWidth: 34
                        implicitHeight: 14
                        //x: genderSwitch.width - width - genderSwitch.rightPadding
                        y: parent.height / 2 - height / 2
                        radius: 13
                        color: genderSwitch.checked ? "#2C98F0" : "#BDBDBD"
                        border.color: "#BDBDBD"

                        Rectangle {
                            x: genderSwitch.checked ? parent.width - width : 0
                            y: parent.height / 2 - height / 2
                            width: 20
                            height: 20
                            radius: 13
                            border.color: "#2C98F0"
                        }
                    }
                }

                Text {
                    id: womanGenderLabel
                    Layout.row: 1
                    Layout.column: 1
                    anchors.left: genderSwitch.right
                    //anchors.leftMargin: 10
                    text: "Женщина"
                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    color: "#212121"
                }

                DatePicker {
                    placeholderText: "00.00.0000"
                    Layout.row: 2
                    Layout.column: 1
                    id: datepic
                    width: 95
                    height: 36
                    mainWindow: registerWindow
                    maxDate: new Date()
                    locale: "ru_RU"
                    calendar: "Gregorian"
                }

                ComboBox {
                    id: cityCB
                    Layout.minimumWidth: 242
                    Layout.minimumHeight: 36
                    Layout.row: 3
                    Layout.column: 1
                    Layout.alignment: Qt.AlignCenter
                    Layout.rightMargin: 20

                    font.family: "Roboto"
                    font.weight: Font.Normal
                    font.pixelSize: 14
                    background: Rectangle {
                        color: "#FAFAFA"
                        border.color: "#BDBDBD"
                        border.width: 0.5
                        radius: 4
                    }
                    model: ["C++", "Java", "JavaScript"]

                    Image {
                        id: comboBoxArrowIcon
                        source: "qrc:/source/img/source/img/comboBoxArrowIcon.png"
                        width: 24
                        height: 24
                        horizontalAlignment: Image.AlignRight
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter

                        fillMode: Image.PreserveAspectFit
                        MouseArea {
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            onClicked: {
                                cityCB.popup.visible = true
                            }
                        }
                    }
                }

                TextField {
                    id: emailField
                    Layout.minimumWidth: 242
                    Layout.minimumHeight: 36
                    Layout.row: 4
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
                    Layout.row: 5
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
                    id: passText
                    Layout.row: 6
                    Layout.column: 1
                    Layout.topMargin: 5
                    anchors.top: passwordField.bottom
                    anchors.topMargin: 10
                    text: "Надежный пароль"
                    width: 124
                    height: 36

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
            height: 178
            anchors.bottom: parent.bottom
            color: "#FFFFFF"
            border.color: "#E0E0E0"
            border.width: 0.5
        }

        RowLayout {
            id: rowLayoutRegist
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: rowLayoutPolicyLabel.top
            anchors.left: parent.left
            anchors.bottomMargin: 32

            Text {
                id: labelText
                text: "У вас уже есть аккаунт? "
                anchors.left: parent.left
                anchors.leftMargin: 130
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                color: "#616161"
            }

            Text {
                id: registText
                anchors.left: labelText.right
                text: "Войти"
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
                        console.log("Войти")
                    }
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
        AuthClass {
            // Определяем объект Custom
            id: authClassObj // назначаем его идентификатор
        }

        Button {
            id: signUpButton
            width: 182
            height: 36
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: rowLayoutRegist.top
            anchors.bottomMargin: 20
            hoverEnabled: true
            Text {
                text: "Зарегистрироваться"
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


                /*if (authClassObj.checkUser(usernameField.text,
                                           passwordField.text)) {
                    var component = Qt.createComponent(
                                "qrc:/myFiles/source/qml/MainWindowApps.qml")
                    console.log("Component Status:", component.status,
                                component.errorString())
                    var window = component.createObject()
                    window.show()
                }*/
            }
        }

        RowLayout {
            id: rowLayoutPolicy
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: rowLayoutPolicyLabel.top
            anchors.left: parent.left
            anchors.bottomMargin: 5

            Text {
                id: aboutText
                anchors.left: parent.left
                anchors.leftMargin: 90
                text: "Регистрируясь, вы соглашаетесь с нашими  "
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                color: "#616161"
            }
        }
        RowLayout {
            id: rowLayoutPolicyLabel
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: frame495.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 32

            Text {
                id: rulesText
                text: "Условиями использования "
                font.family: "Roboto"
                anchors.right: iText.left
                font.weight: Font.Normal
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                textFormat: Text.RichText
                color: "#2C98F0"
                Layout.rightMargin: 1

                MouseArea {
                    id: mouseAreaRulesText
                    anchors.fill: parent
                    onClicked: {
                        console.log("Войти")
                    }
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Text {
                id: iText
                text: "и "
                anchors.left: parent.left
                anchors.leftMargin: 200
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                color: "#616161"
            }

            Text {
                id: policyText
                anchors.left: iText.right
                text: "Политикой конфиденциальности"
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                textFormat: Text.RichText
                color: "#2C98F0"
                Layout.rightMargin: 1

                MouseArea {
                    id: mouseAreaPolicyText
                    anchors.fill: parent
                    onClicked: {
                        console.log("Войти")
                    }
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }

        Image {
            id: signUpIcon
            source: "path/to/your/signUpIcon.png"
            width: 24
            height: 24
            anchors.right: signUpButton.right
            anchors.rightMargin: 10
            anchors.verticalCenter: signUpButton.verticalCenter
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    // Handle sign up logic here
                }
            }
        }

        Image {
            id: errorIcon
            source: "path/to/your/errorIcon.png"
            width: 24
            height: 24
            anchors.left: errorText.right
            anchors.leftMargin: 10
            anchors.verticalCenter: errorText.verticalCenter
            fillMode: Image.PreserveAspectFit
            visible: errorText.visible
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    // Handle error logic here
                }
            }
        }

        Image {
            id: warningIcon
            source: "path/to/your/warningIcon.png"
            width: 24
            height: 24
            anchors.left: warningText.right
            anchors.leftMargin: 10
            anchors.verticalCenter: warningText.verticalCenter
            fillMode: Image.PreserveAspectFit
            visible: warningText.visible
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    // Handle warning logic here
                }
            }
        }
    }
}
