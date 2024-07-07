// подключение модулей
const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const http = require('http');
const nodemon = require('nodemon');
const WebSocket = require('ws');
const os = require('os');

// настройка подключения к БД
const pool = new Pool({
  user: 'postgres', 
  host: 'localhost',
  database: 'Server_DB',
  password: '2628', 
  port: 5432,
});

const app = express();

// создание и запуск сервера
const server = http.createServer(app);
const wss = new WebSocket.Server({ noServer: true });

const port = 3000;

// это для разных типов запросов
const requestCounters = {
  GET: 0,
  POST: 0,
  PUT: 0,
  DELETE: 0
};

// подсчет этих запросов
app.use((req, res, next) => {
  requestCounters[req.method]++;
  next();
});


// это нужно для обработки запросов с телом в формате JSON
app.use(bodyParser.json());

// подключение маршрутов и передача пула соединений с БД
const users = require('./modules/users')(pool);
const posts = require('./modules/posts')(pool);
const comments = require('./modules/comments')(pool);
const friends = require('./modules/friends')(pool);
const likes = require('./modules/likes')(pool);
const messages = require('./modules/messages')(pool);
const tests = require('./modules/tests')(pool);

// использование маршрутов
app.use('/users', users);
app.use('/posts', posts);
app.use('/comments', comments);
app.use('/friends', friends);
app.use('/likes', likes);
app.use('/messages', messages);
app.use('/tests', tests);


// админ панель
const admin = require('./modules/admin')(server, app, pool,/*clientCounter, */requestCounters);
app.use('/admin', admin);

// должно было быть подсчётом подключённых и отключённых клиентов но пока что не работает
/*wss.on('connection', (ws) => {
  clientCounter.connected++;
  ws.on('close', () => clientCounter.disconnected++);
});*/


// запуск сервера
server.listen(port, () => {
  console.log('Сервер запущен на порту ' + port);
});

// // это временная штука, нужная для теста подключения к БД
// const testDatabaseConnection = async () => {
//     try {
//       const res = await pool.query('SELECT NOW()');
//       console.log('Подключено к БД:', res.rows[0].now);
//     } catch (err) {
//       console.error('Ошибка подключения к БД:', err.stack);
//     }
//   };
  
//   testDatabaseConnection();
  



//server.listen(port, () => {
  //console.log('Сервер запущен ');
//});

