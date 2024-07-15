#ifndef AUTHCLASS_H
#define AUTHCLASS_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QString>
#include <QObject>
#include <QDebug>
#include <QQmlComponent>

class AuthClass: public QObject
{
    Q_OBJECT

public:
    explicit AuthClass();
    Q_INVOKABLE void doSomething();
    Q_INVOKABLE bool checkUser(const QString login, const QString password);
    void somethingHappened(const QString &message);

private:
    QString m_message;
};

#endif // AUTHCLASS_H
