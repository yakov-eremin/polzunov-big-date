#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <authclass.h>
#include <qdatepicker.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<AuthClass>("AuthModule", 1, 0, "AuthClass");

    qmlRegisterType<QDatePicker>("QDatePicker",1,0,"QDatePicker");

    const QUrl url(u"qrc:/NewLents/main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
