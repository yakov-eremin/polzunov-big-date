module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();

    // создание таблицы chats
    const ensureChatExists = async (user1_id, user2_id) => {
        await pool.query(`CREATE TABLE IF NOT EXISTS chats (
            id SERIAL PRIMARY KEY,
            user1_id INTEGER NOT NULL,
            user2_id INTEGER NOT NULL
        )`);

        // это для того, чтобы не создавалась ненужная таблица
        const chatExists = await pool.query(
            `SELECT * FROM chats WHERE (user1_id = $1 AND user2_id = $2) OR (user1_id = $2 AND user2_id = $1)`,
            [user1_id, user2_id]
        );

        if (chatExists.rows.length === 0) {
            await pool.query(`INSERT INTO chats (user1_id, user2_id) VALUES ($1, $2)`, [user1_id, user2_id]);
        }
    };

    // получение имени таблицы сообщений с инверсией имен
    const getMessageTableName = (username1, username2) => {
        if (username1 < username2) {
            return `messages_${username1}_${username2}`;
        } else {
            return `messages_${username2}_${username1}`;
        }
    };

    // отправка сообщения
    router.post('/send', async (req, res) => {
        const { sender_id, receiver_id, content } = req.body;

        try {
            const { rows: senderRows } = await pool.query('SELECT username FROM users WHERE id=$1', [sender_id]);
            const { rows: receiverRows } = await pool.query('SELECT username FROM users WHERE id=$1', [receiver_id]);

            if (senderRows.length == 0 || receiverRows.length == 0) {
                return res.status(404).json({ tag: 'messages', error: "Один из пользователей не найден" });
            }

            const senderUsername = senderRows[0].username;
            const receiverUsername = receiverRows[0].username;

            await ensureChatExists(sender_id, receiver_id);

            const messagesTableName = getMessageTableName(senderUsername, receiverUsername);

            await pool.query(`
                CREATE TABLE IF NOT EXISTS ${messagesTableName} (
                    id SERIAL PRIMARY KEY,
                    sender_id INTEGER NOT NULL,
                    receiver_id INTEGER NOT NULL,
                    content TEXT NOT NULL,
                    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )`
            );

            const result = await pool.query(
                `INSERT INTO ${messagesTableName} (sender_id, receiver_id, content)
                VALUES ($1, $2, $3)
                RETURNING *`, [sender_id, receiver_id, content]
            );

            res.status(201).json({ tag: 'messages', ...result.rows[0] });

        } catch (error) {
            console.error('Ошибка отправки сообщения:', error);
            res.status(500).json({ tag: 'messages', error: 'Ошибка отправки сообщения' });
        }
    });

    // получение всех сообщений двух пользователей
    router.get('/conversation/:user1_id/:user2_id', async (req, res) => {
        const user1_id = parseInt(req.params.user1_id);
        const user2_id = parseInt(req.params.user2_id);

        try {
            const { rows: user1Rows } = await pool.query('SELECT username FROM users WHERE id=$1', [user1_id]);
            const { rows: user2Rows } = await pool.query('SELECT username FROM users WHERE id=$1', [user2_id]);

            if (user1Rows.length == 0 || user2Rows.length == 0) {
                return res.status(404).json({ tag: 'messages', error: "Один из пользователей не найден" });
            }

            const user1Username = user1Rows[0].username;
            const user2Username = user2Rows[0].username;

            const messagesTableName = getMessageTableName(user1Username, user2Username);
            const result = await pool.query(`SELECT * FROM ${messagesTableName}`);

            res.status(200).json({ tag: 'messages', messages: result.rows });
        } catch (error) {
            console.error('Ошибка получения сообщений:', error);
            res.status(500).json({ tag: 'messages', error: 'Ошибка получения сообщений' });
        }
    });

    // получение последних сообщений для одного пользователя
    router.get('/last-message/:user_id', async (req, res) => {
        const user_id = parseInt(req.params.user_id);

        try {
            const { rows: userRows } = await pool.query('SELECT username FROM users WHERE id = $1', [user_id]);

            if (userRows.length === 0) {
                return res.status(404).json({ tag: 'messages', error: "Пользователь не найден" });
            }

            const username = userRows[0].username;

            const query = 'SELECT tablename FROM pg_tables WHERE tablename LIKE $1 OR tablename LIKE $2';
            const tables = await pool.query(query, [`messages_${username}_%`, `messages_%_${username}`]);

            if (tables.rows.length === 0) {
                return res.status(404).json({ tag: 'messages', error: "Сообщения не найдены" });
            }

            let lastMessages = [];
            for (let table of tables.rows) {
                const tableName = table.tablename;
                const result = await pool.query(`SELECT * FROM ${tableName} ORDER BY sent_at DESC LIMIT 1`);

                if (result.rows.length > 0) {
                    const message = result.rows[0];
                    const { rows: otherUserRows } = await pool.query(
                        'SELECT id, username FROM users WHERE id = $1 OR id = $2',
                        [message.sender_id, message.receiver_id]
                    );

                    if (otherUserRows.length === 2) {
                        const userMap = otherUserRows.reduce((acc, user) => {
                            acc[user.id] = user.username;
                            return acc;
                        }, {});

                        let lastMessage = {
                            user1_id: message.sender_id,
                            user1_name: userMap[message.sender_id],
                            user2_id: message.receiver_id,
                            user2_name: userMap[message.receiver_id],
                            message: message.content,
                            sent_at: message.sent_at
                        };

                        lastMessages.push(lastMessage);
                    }
                }
            }

            if (lastMessages.length === 0) {
                return res.status(404).json({ tag: 'messages', error: "Сообщения не найдены" });
            }

            res.status(200).json({ tag: 'messages', messages: lastMessages });
        } catch (error) {
            console.error('Ошибка получения последнего сообщения:', error);
            res.status(500).json({ tag: 'messages', error: 'Ошибка получения последнего сообщения' });
        }
    });

    return router;
};