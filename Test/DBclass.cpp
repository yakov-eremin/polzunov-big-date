#include "DBclass.h"

DBclass::DBclass(QObject *parent): QObject{parent}
{

}
//
void DBclass::connectToDatabase()
{
    db=QSqlDatabase::addDatabase("QPSQL");           //тип базы данных
    db.setHostName(DATABASE_HOSTNAME);               //адрес сервера
    db.setDatabaseName(DATABASE_NAME);               //название таблицы
    db.setUserName(DATABASE_USERNAME);               //имя пользователя
    db.setPassword(DATABASE_PASSWORD);               //пароль пользователя
    db.setPort(DATABASE_PORT);
    this->openDataBase();
}
//Открытие БД
bool DBclass::openDataBase()
{
    if(db.open())
    {
        qDebug() << "Есть подключение";
        return true;
    }
    else
    {
         qDebug() << "Нет подключения";
        return false;
    }
}
//Закрытие БД
void DBclass::closeDataBase()
{
    db.close();
}
//Вставление данных в БД
bool DBclass::insertIntoTable(const QVariantList &data)
{
    QSqlQuery query;

    //Формируем вставку в таблицу
    query.prepare("INSERT INTO \"UserName\" (\"FirstResult\", \"SecondResult\", \"ThirdResult\", \"FourthResult\", \"FifthResult\")"
                   "VALUES (:FirstScore, :SecondScore, :ThirdScore, :FourthScore, :FifthScore);");
    query.bindValue(":FirstScore", data[0]);
    query.bindValue(":SecondScore", data[1]);
    query.bindValue(":ThirdScore", data[2]);
    query.bindValue(":FourthScore", data[3]);
    query.bindValue(":FifthScore", data[4]);
    //Выполняется вставка методом exec()
    if(!query.exec())
    {
        qDebug() << "Не удалось произвести запрос добавления";
        qDebug() << query.lastError().text();
        return false;
    }
    else
    {
        qDebug() <<"Успешно добавлена новая запись";
        return true;
    }
}
//Подготовка данных для вставки в БД
bool DBclass::insertIntoTable(const QString &FirstResult, const QString &SecondResult, const QString &ThirdResult,
                              const QString &FourthResult, const QString &FifthResult)
{
    QVariantList data;
    data.append(FirstResult);
    data.append(SecondResult);
    data.append(ThirdResult);
    data.append(FourthResult);
    data.append(FifthResult);
    if(insertIntoTable(data))
    {
        return true;
    }
    else
    {
        return false;
    }
}
//Обновление данных в БД
bool DBclass::updateTable(const QVariantList &data, const int id)
{
    QSqlQuery query;

    //Формируем вставку в таблицу
    query.prepare( "Update \"UserName\" SET \"FirstResult\"=:FIRST_SCORE, \"SecondResult\"=:SECOND_SCORE,"
                  " \"ThirdResult\"=:THIRD_SCORE, \"FourthResult\"=:FOURTH_SCORE, \"FifthResult\"=:FIFTH_SCORE WHERE \"User_id\"=:ID;");
    //Привязываем значения, которые мы пытаемся вставить
    query.bindValue(":FIRST_SCORE", data[0]);
    query.bindValue(":SECOND_SCORE", data[1]);
    query.bindValue(":THIRD_SCORE", data[2]);
    query.bindValue(":FOURTH_SCORE", data[3]);
    query.bindValue(":FIFTH_SCORE", data[4]);
    query.bindValue(":ID", id);
    query.bindValue(":id", id);
    //Выполняется вставка методом exec()
    if(!query.exec())
    {
        qDebug() << "Не удалось произвести запрос изменения";
        qDebug() << query.lastError().text();
        return false;
    }
    else
    {
        qDebug() <<"Успешно изменена запись";
        return true;
    }
}
//Подготовка данных для обновления БД
bool DBclass::updateTable(const QString &FirstResult, const QString &SecondResult, const QString &ThirdResult,
                          const QString &FourthResult, const QString &FifthResult, int id)
{
    QVariantList data;
    data.append(FirstResult);
    data.append(SecondResult);
    data.append(ThirdResult);
    data.append(FourthResult);
    data.append(FifthResult);
    if(updateTable(data,id))
        return true;
    else
        return false;
}
//Проверить, есть ли ID в базе данных
bool DBclass::checkID(int id)
{
    QSqlQuery query;
    query.prepare("Select count(\"User_id\") from \"UserName\" where \"User_id\"=:id");
    query.bindValue(":id",id);
    query.exec();
    query.first();
    int check=query.value(0).toInt();
    if(check > 0)
    {
        qDebug() << "Существует ID";
        qDebug() << check;

        return true;
    }
    else
    {
        qDebug() << "Не существует ID";
        qDebug() << check;
        return false;
    }
}
//Извлечь первый результат из БД
int DBclass::get_results1(int id)
{
    QSqlQuery query;
    query.prepare("Select \"FirstResult\" from \"UserName\" where \"User_id\"=:id");
    query.bindValue(":id",id);
    query.exec();
    query.first();
    int score1=query.value(0).toInt();
    return score1;
}
//Извлечь второй результат из БД
int DBclass::get_results2(int id)
{
    QSqlQuery query;
    query.prepare("Select \"SecondResult\" from \"UserName\" where \"User_id\"=:id");
    query.bindValue(":id",id);
    query.exec();
    query.first();
    int score2=query.value(0).toInt();
    return score2;
}
//Извлечь третий результат из БД
int DBclass::get_results3(int id)
{
    QSqlQuery query;
    query.prepare("Select \"ThirdResult\" from \"UserName\" where \"User_id\"=:id");
    query.bindValue(":id",id);
    query.exec();
    query.first();
    int score3=query.value(0).toInt();
    return score3;
}
//Извлечь четвёртый результат из БД
int DBclass::get_results4(int id)
{
    QSqlQuery query;
    query.prepare("Select \"FourthResult\" from \"UserName\" where \"User_id\"=:id");
    query.bindValue(":id",id);
    query.exec();
    query.first();
    int score4=query.value(0).toInt();
    return score4;
}
//Извлечь пятый результат из БД
int DBclass::get_results5(int id)
{
    QSqlQuery query;
    query.prepare("Select \"FifthResult\" from \"UserName\" where \"User_id\"=:id");
    query.bindValue(":id",id);
    query.exec();
    query.first();
    int score5=query.value(0).toInt();
    return score5;
}
