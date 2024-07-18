#ifndef DBCLASS_H
#define DBCLASS_H

#include <QObject>
#include <QFile>
#include <QDate>
#include <QDebug>

#include <QByteArray>
#include <QString>
#include <QScrollArea>
#include <QStringList>
#include <QNetworkAccessManager>
#include <QNetworkProxy>
#include <QNetworkReply>
#include <QJsonValueRef>
#include <QJsonArray>
#include <QTimer>
#include <QMap>
#include <QJsonObject>
#include <QJsonDocument>
#include <networkmanager.h>
#include <QMultiMap>
#include <QListWidget>
#include <qqml.h>

#define DATABASE_HOSTNAME               "localhost"         //Название БД
#define DATABASE_NAME                   "Test"      //Называние БД
#define DATABASE_USERNAME               "postgres"       //Имя пользователя
#define DATABASE_PASSWORD               "123"           //Пароль от БД
#define DATABASE_PORT                   5433            //Порт подключения

#define TABLE                           "tests"         //Название таблицы БД
#define TABLE_NAME                      "user_id"          //Колонка с id пользователя
#define TABLE_FIRST_SCORE               "firstresult"       //Колонка с результатами по Эксраверсии – Интроверсии
#define TABLE_SECOND_SCORE              "secondresult"      //Колонка с результатами по Привязанности – Обособленности
#define TABLE_THIRD_SCORE               "thirdresult"       //Колонка с результатами по Самоконтролю – Импульсивности
#define TABLE_FOURTH_SCORE              "fourthresult"      //Колонка с результатами по Эмоциональной устойчивости – эмоциональной неустойчивости
#define TABLE_FIFTH_SCORE               "fifthresult"       //Колонка с результатами по Экспрессивности – Практичности

class DBclass : public QObject
{
    Q_OBJECT
public:
    explicit DBclass(QObject *parent = nullptr);
private slots:
    void on_newDataReceived(const QJsonArray &jsonArray);
    void onHttpFinished(QNetworkReply *reply);
public slots:
    void insertIntoTable(const QVariantList &data, const int id);                                                                             //Вставить значения тестов в БД
    void insertIntoTable(const QString &FirstResult, const QString &SecondResult, const QString &ThirdResult,                   //Подготовить массив данных для вставки в БД
                         const QString &FourthResult, const QString &FifthResult, const int id);
    void updateTable(const QVariantList &data, const int id);                                                                  //Изменить значения тестов в БД
    void updateTable(const QString &FirstResult, const QString &SecondResult, const QString &ThirdResult,                     //Подготовить массив данных, которые будут использоваться в БД
                     const QString &FourthResult, const QString &FifthResult, int id);
    bool checkID();                                                                                                    //Проверить, что существует запись с ID пользователя
    void get_results(int id);
    int get_results1();                                                                                                //Получить результат первого фактора теста
    int get_results2();                                                                                                //Получить результат второго фактора теста
    int get_results3();                                                                                                //Получить результат третьего фактора теста
    int get_results4();                                                                                                //Получить результат четвёртого фактора теста
    int get_results5();                                                                                                //Получить результат пятого фактора теста
signals:

private:
    NetworkManager *networkManager;
    int tempScore[5];
    int flagUserID=0;
};

#endif // DBCLASS_H
