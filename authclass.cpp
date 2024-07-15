#include "authclass.h"

AuthClass::AuthClass()
{}

void AuthClass::doSomething() {
    m_message = "Hello from C++!";
    somethingHappened(m_message);
}

bool AuthClass::checkUser(const QString login, const QString password){
    if(login == "kostya" && password == "12345")
    {
        return true;
    }
    else{
        return false;
    }
}

void AuthClass::somethingHappened(const QString &message){
    qDebug() << message;
    QQmlEngine engine;
    QQmlComponent component(&engine);

    component.loadUrl(QUrl(QStringLiteral("qrc:/MainWindowApps.qml")));

    if ( component.isReady() )
        component.create();
    else
        qWarning() << component.errorString();
}


