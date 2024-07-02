module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();

    // отправка нового сообщения
    router.post('/send', (req, res) => {
        const { sender_id, receiver_id, content } = req.body;
        pool.query(
            'INSERT INTO messages (sender_id, receiver_id, content) VALUES ($1, $2, $3) RETURNING ',
            [sender_id, receiver_id, content],
            (error, results) => {
                if (error) {
                    throw error;
                }
                res.status(201).json(results.rows[0]);
            }
        );
    });

    // удаление сообщения
    // не уверен насколько это нам щас нужно, но пусть будет
    router.delete('/delete/:id', (req, res) => {
        const id = parseInt(req.params.id);
        pool.query(
            'DELETE FROM messages WHERE id = $1',
            [id],
            (error) => {
                if (error) {
                    throw error;
                }
                res.status(200).send('Сообщение с ID ${id} удалено');
            }
        );
    });

    // получение всех сообщений между двумя пользователями
    router.get('/conversation/:user1_id/:user2_id', (req, res) => {
        const user1_id = parseInt(req.params.user1_id);
        const user2_id = parseInt(req.params.user2_id);
        pool.query(
            'SELECT * FROM messages WHERE (sender_id = $1 AND receiver_id = $2) OR (sender_id = $2 AND receiver_id = $1)',
            [user1_id, user2_id],
            (error, results) => {
                if (error) {
                    throw error;
                }
                res.status(200).json(results.rows);
            }
        );
    });

    return router;
};