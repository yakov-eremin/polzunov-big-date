#ifndef DBCLASS_H
#define DBCLASS_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#define DATABASE_HOSTNAME               "127.0.0.1"         //Название БД
#define DATABASE_NAME                   "NameTable"      //Называние БД
#define DATABASE_USERNAME               "postgres"       //Имя пользователя
#define DATABASE_PASSWORD               "123"           //Пароль от БД
#define DATABASE_PORT                   5432            //Порт подключения

#define TABLE                           "NameTable"         //Название таблицы БД
#define TABLE_NAME                       "UserName"          //Колонка с именем пользователя
#define TABLE_FIRST_SCORE               "FirstResult"       //Колонка с результатами по Эксраверсии – Интроверсии
#define TABLE_SECOND_SCORE              "SecondResult"      //Колонка с результатами по Привязанности – Обособленности
#define TABLE_THIRD_SCORE               "ThirdResult"       //Колонка с результатами по Самоконтролю – Импульсивности
#define TABLE_FOURTH_SCORE              "FourthResult"      //Колонка с результатами по Эмоциональной устойчивости – эмоциональной неустойчивости
#define TABLE_FIFTH_SCORE               "FifthResult"       //Колонка с результатами по Экспрессивности – Практичности

class DBclass : public QObject
{
    Q_OBJECT
public:
    explicit DBclass(QObject *parent = nullptr);
    void connectToDatabase();
private:
    bool openDataBase();        //Открытие БД
    void closeDataBase();       //Закрытие БД
public slots:
    bool insertIntoTable(const QVariantList &data);                                                                             //Вставить значения тестов в БД
    bool insertIntoTable(const QString &FirstResult, const QString &SecondResult, const QString &ThirdResult,                   //Подготовить массив данных для вставки в БД
                         const QString &FourthResult, const QString &FifthResult);
    bool updateTable(const QVariantList &data, const int id);                                                                  //Изменить значения тестов в БД
    bool updateTable(const QString &FirstResult, const QString &SecondResult, const QString &ThirdResult,                     //Подготовить массив данных, которые будут использоваться в БД
                     const QString &FourthResult, const QString &FifthResult, int id);
    bool checkID(int id);                                                                                                    //Проверить, что существует запись с ID пользователя
    int get_results1(int id);                                                                                                //Получить результат первого фактора теста
    int get_results2(int id);                                                                                                //Получить результат второго фактора теста
    int get_results3(int id);                                                                                                //Получить результат третьего фактора теста
    int get_results4(int id);                                                                                                //Получить результат четвёртого фактора теста
    int get_results5(int id);                                                                                                //Получить результат пятого фактора теста
signals:

private:
    QSqlDatabase db;
};

#endif // DBCLASS_H
