const express = require('express');
const os = require('os');

// пока что работает без подсчета клиентов
module.exports = (server, app, pool, /*clientCounter,*/ requestCounters) => {
    const router = express.Router();

    class ServerMonitor {
        // вообще это нужно для работы с кол-во клиентов но это пока что не работает
        /*constructor() {
            this.clients = [];
        }
        
        addClient(ws) {
            this.clients.push(ws);
            ws.on('close', () => this.removeClient(ws));
        }
        
        removeClient(ws) {
            this.clients = this.clients.filter(client => client !== ws);
        }
        
        broadcast(data) {
            this.clients.forEach(client => {
                client.send(JSON.stringify(data));
            });
        }
        */
       // проверка на загруженность сервера
        getServerLoad() {
            const load = os.loadavg()[0];
            if (load < 150) return 'Малая';
            if (load >= 150 && load < 300) return 'Средняя';
            return 'Высокая';
        }
        
        // проверка статуса системы
        async getStatus() {
            const { rows } = await pool.query('SELECT COUNT(*) FROM users');
            return {
                serverLoad: this.getServerLoad(),
                dbStatus: await this.testDatabaseConnection(),
                /*clientConnected: clientCounter.connected,*/
                /*clientDisconnected: clientCounter.disconnected,*/
                /*requestCount: requestCounters*/
            };
        }

        async testDatabaseConnection() {
            try {
                await pool.query('SELECT NOW()');
                return 'Подключена';
            } catch (err) {
                return 'Ошибка подключения';
            }
        }
    }

    const monitor = new ServerMonitor();

    //  маршрут admin
    router.get('/', async (req, res) => {
        const status = await monitor.getStatus();
        res.json(status);
    });

    server.on('upgrade', (request, socket, head) => {
        const url = request.url;
        if (url === '/admin') {
            wss.handleUpgrade(request, socket, head, (ws) => {
                monitor.addClient(ws);
                ws.on('message', async () => {
                    const status = await monitor.getStatus();
                    ws.send(JSON.stringify(status));
                });
            });
        } else {
            socket.destroy();
        }
    });

    return router;
};