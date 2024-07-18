#include "DBclass.h"

DBclass::DBclass(QObject *parent): QObject{parent}
    , networkManager(new NetworkManager(this))
{
    connect(networkManager, &QNetworkAccessManager::finished, this, &DBclass::onHttpFinished); //ВАЖНО!
}

//Вставление данных в БД
void DBclass::insertIntoTable(const QVariantList &data, int id)
{
    QUrl url("http://localhost:3000/tests/add");
    QNetworkRequest request(url);

    // Устанавливаем заголовок Content-Type
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    // Создаем JSON объект с командой и именем пользователя
    QJsonObject json;
    json["user_id"] = id;
    json["firstresult"] = data[0].toInt();
    json["secondresult"] = data[1].toInt();
    json["thirdresult"] = data[2].toInt();
    json["fourthresult"] = data[3].toInt();
    json["fifthresult"] = data[4].toInt();

    // Отправляем POST запрос
    NetworkManager *networkManager = new NetworkManager(this);
    networkManager->post(request, QJsonDocument(json).toJson());
    qDebug()<<json;
    qDebug()<<url;
    flagUserID=1;
}
//Подготовка данных для вставки в БД
void DBclass::insertIntoTable(const QString &FirstResult, const QString &SecondResult, const QString &ThirdResult,
                              const QString &FourthResult, const QString &FifthResult, int id)
{
    QVariantList data;
    data.append(FirstResult);
    data.append(SecondResult);
    data.append(ThirdResult);
    data.append(FourthResult);
    data.append(FifthResult);
    insertIntoTable(data,id);
}
//Обновление данных в БД
void DBclass::updateTable(const QVariantList &data, const int id)
{
    QString urlStr = "http://localhost:3000/tests/update/"+QString::number(id);
    QUrl url(urlStr);
    QNetworkRequest request(url);

    // Устанавливаем заголовок Content-Type
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    // Создаем JSON объект с командой и данными теста
    QJsonObject json;
    json["user_id"] = id;
    json["firstresult"] = data[0].toInt();
    json["secondresult"] = data[1].toInt();
    json["thirdresult"] = data[2].toInt();
    json["fourthresult"] = data[3].toInt();
    json["fifthresult"] = data[4].toInt();

    // Отправляем PUT запрос
    NetworkManager *networkManager = new NetworkManager(this);
    networkManager->put(request, QJsonDocument(json).toJson());

    qDebug()<<json;
    qDebug()<<url;
}
//Подготовка данных для обновления БД
void DBclass::updateTable(const QString &FirstResult, const QString &SecondResult, const QString &ThirdResult,
                          const QString &FourthResult, const QString &FifthResult, int id)
{
    QVariantList data;
    data.append(FirstResult);
    data.append(SecondResult);
    data.append(ThirdResult);
    data.append(FourthResult);
    data.append(FifthResult);
    updateTable(data,id);
}
//Проверить, есть ли ID в базе данных
bool DBclass::checkID()
{

    if(flagUserID)
    {
        qDebug() << "Существует ID";
        qDebug() << flagUserID;

        return true;
    }
    else
    {
        qDebug() << "Не существует ID";
        qDebug() << flagUserID;
        return false;
    }
}

void DBclass::get_results(int id)
{
    QString userID = QString::number(id);
    QString urlStr = "http://localhost:3000/tests/user/" + userID;

    if(tempScore[0]>0)
    {
        flagUserID=1;
    }

    qDebug() << urlStr;
    QUrl url(urlStr); // Укажите правильный URL вашего сервера
    QNetworkRequest request(url);

    // Устанавливаем заголовок Content-Type
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    // Создаем JSON объект с командой и именем пользователя
    QJsonObject json;

    // Отправляем GET запрос
    networkManager->get(request, QJsonDocument(json).toJson());
}

void DBclass::onHttpFinished(QNetworkReply *reply)
{
    if (reply->error()) {
        qDebug() << "Error:" << reply->errorString();
        return;
    }

    QJsonDocument jsonDoc = QJsonDocument::fromJson(reply->readAll());

    qDebug() << "Received JSON:" << jsonDoc.toJson(QJsonDocument::Indented);

    QJsonObject jsonObj;
    if (jsonDoc.isObject())
    {
        jsonObj = jsonDoc.object();
    }


    if(jsonObj["tag"] == "tests")
    {
        QJsonArray jsonArray = jsonObj["data"].toArray();
        if (jsonArray.size() > 0){
            on_newDataReceived(jsonArray);
        }
    }
}
void DBclass::on_newDataReceived(const QJsonArray &jsonArray)
{
    qDebug() <<"Получены новые данные";
    if (jsonArray.isEmpty()){
        qDebug() << "No data available for reading!";
        return;
    }
    for (int j = 0 ; j< jsonArray.size(); j++)
    {
        QJsonObject test = jsonArray.at(j).toObject();
        tempScore[0] = test["firstresult"].toInt();
        tempScore[1] = test["secondresult"].toInt();
        tempScore[2] = test["thirdresult"].toInt();
        tempScore[3] = test["fourthresult"].toInt();
        tempScore[4] = test["fifthresult"].toInt();
    }
}

//Извлечь первый результат из БД
int DBclass::get_results1()
{
    return tempScore[0];
}
//Извлечь второй результат из БД
int DBclass::get_results2()
{
    return tempScore[1];
}
//Извлечь третий результат из БД
int DBclass::get_results3()
{

    return tempScore[2];
}
//Извлечь четвёртый результат из БД
int DBclass::get_results4()
{

    return tempScore[3];
}
//Извлечь пятый результат из БД
int DBclass::get_results5()
{
    return tempScore[4];
}
