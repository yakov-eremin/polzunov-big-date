module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();

    // отправка нового сообщения
    router.post('/send', async (req, res) => {
        const { sender_id, receiver_id, content } = req.body;
        
        try {
            // получение имен пользователей, для создания таблиц
            const { rows: senderRows } = await pool.query('SELECT username FROM users WHERE id=$1', [sender_id]);
            const { rows: receiverRows } = await pool.query('SELECT username FROM users WHERE id=$1', [receiver_id]);

            if (senderRows.length == 0 || receiverRows.length == 0) {
                return res.status(404).send("Один из пользователей не найден");
                
            }
            
            const senderUsername = senderRows[0].username;
            const receiverUsername = receiverRows[0].username;

            // создание имени для таблиц чатов и сообщений
            const chatTableName = `chats_${senderUsername}_${receiverUsername}`;
            const messagesTableName = `messages_${senderUsername}_${receiverUsername}`;

            // cоздание таблицы для чата, если ее не существует
            await pool.query(`CREATE TABLE IF NOT EXISTS ${chatTableName} (
                    id SERIAL PRIMARY KEY,
                    user1_id INTEGER NOT NULL,
                    user2_id INTEGER NOT NULL)`
                );

            // вставка записи о чате
            await pool.query(`INSERT INTO ${chatTableName} (user1_id, user2_id) 
                VALUES ($1, $2) 
                ON CONFLICT DO NOTHING`, [sender_id, receiver_id]
            );

            // создание таблицы для сообщений, если не существует
            await pool.query(`
                CREATE TABLE IF NOT EXISTS ${messagesTableName} (id SERIAL PRIMARY KEY,
                    sender_id INTEGER NOT NULL,
                    receiver_id INTEGER NOT NULL,
                    content TEXT NOT NULL,
                    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)`
                );

            // добавление сообщения в таблицу
            const result = await pool.query(
                `INSERT INTO ${messagesTableName} (sender_id, receiver_id, content)
                VALUES ($1, $2, $3)
                RETURNING *`, [sender_id, receiver_id, content]
            );

            res.status(201).json(result.rows[0]);

        } catch (error) {
            console.error('Ошибка отправки сообщения:', error);
            res.status(500).send('Ошибка отправки сообщения');
        }
    });

    // получение всех сообщений между двумя пользователями
    router.get('/conversation/:user1_id/:user2_id', async (req, res) => {
        const user1_id = parseInt(req.params.user1_id);
        const user2_id = parseInt(req.params.user2_id);

        try {
            // Получить имена пользователей
            const { rows: user1Rows } = await pool.query('SELECT username FROM users WHERE id=$1', [user1_id]);
            const { rows: user2Rows } = await pool.query('SELECT username FROM users WHERE id=$1', [user2_id]);

            if (user1Rows.length == 0 || user2Rows.length == 0) {
                return res.status(404).send("Один из пользователей не найден");
            }
            const user1Username = user1Rows[0].username;
            const user2Username = user2Rows[0].username;

            // имя таблицы для сообщений
            const messagesTableName = 'messages_'+user1Username+'_'+user2Username;
            const result = await pool.query('SELECT * FROM '+'messages_'+user1Username+'_'+user2Username);
            res.status(200).json(result.rows);
        } catch (error) {
            console.error('Ошибка получения сообщений:', error);
            res.status(500).send('Ошибка получения сообщений');
        }
    });

// // удаление сообщения
// // не уверен насколько это нам щас нужно, но пусть будет
// router.delete('/delete/:id', (req, res) => {
// const id = parseInt(req.params.id);
// pool.query(
// 'DELETE FROM messages WHERE id = $1',
// [id],
// (error) => {
// if (error) {
// throw error;
// }
// res.status(200).send('Сообщение с ID ${id} удалено');
// }
// );
// });

router.get('/last-message/:user_id', async (req, res) => {
    const user_id = parseInt(req.params.user_id);

    try {
        const { rows: userRows } = await pool.query('SELECT username FROM users WHERE id = $1', [user_id]);

        if (userRows.length === 0) {
            return res.status(404).send("Пользователь не найден");
        }

        const username = userRows[0].username;

        // Получаем все возможные контакты пользователя
        const query = 'SELECT tablename FROM pg_tables WHERE tablename LIKE $1 OR tablename LIKE $2';
        const tables = await pool.query(query, ['messages_${username}_%`, `messages_%_${username}']);

        if (tables.rows.length === 0) {
            return res.status(404).send("Сообщения не найдены");
        }

        let lastMessage = null;
        for (let table of tables.rows) {
            const tableName = table.tablename;

            const result = await pool.query(`SELECT * FROM ${tableName} ORDER BY sent_at DESC LIMIT 1`);

            if (result.rows.length > 0) {
                const message = result.rows[0];

                if (!lastMessage || new Date(message.sent_at) > new Date(lastMessage.sent_at)) {
                    const { rows: otherUserRows } = await pool.query(
                        'SELECT id, username FROM users WHERE id = $1 OR id = $2',
                        [message.sender_id, message.receiver_id]
                    );

                    if (otherUserRows.length === 2)
                        {
                            const userMap = otherUserRows.reduce((acc, user) => {
                                acc[user.id] = user.username;
                                return acc;
                            }, {});

                            lastMessage = {
                                user1_id: message.sender_id,
                                user1_name: userMap[message.sender_id],
                                user2_id: message.receiver_id,
                                user2_name: userMap[message.receiver_id],
                                message: message.content,
                                sent_at: message.sent_at
                            };
                        }
                    }
                }
            }

            if (!lastMessage) {
                return res.status(404).send("Сообщения не найдены");
            }

            res.status(200).json(lastMessage);
        } catch (error) {
            console.error('Ошибка получения последнего сообщения:', error);
            res.status(500).send('Ошибка получения последнего сообщения');
        }
    });

    return router;
};