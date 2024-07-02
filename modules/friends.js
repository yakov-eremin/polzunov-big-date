module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();

    // добавление друга
    router.post('/add', (req, res) => {
        const { user_id, friend_id } = req.body;
        pool.query(
            'INSERT INTO friends (user_id, friend_id) VALUES ($1, $2) RETURNING *',
            [user_id, friend_id],
            (error, results) => {
                if (error) {
                    throw error;
                }
                res.status(201).json(results.rows[0]);
            }
        );
    });

    // удаление друга
    router.delete('/delete/:user_id/:friend_id', (req, res) => {
        const user_id = parseInt(req.params.user_id);
        const friend_id = parseInt(req.params.friend_id);
        pool.query(
            'DELETE FROM friends WHERE user_id = $1 AND friend_id = $2',
            [user_id, friend_id],
            (error) => {
                if (error) {
                    throw error;
                }
                res.status(200).send(`Друг с ID ${friend_id} удалён у пользователя с ID ${user_id}`);
            }
        );
    });

    // получение всех друзей пользователя
    router.get('/user/:id', (req, res) => {
        const user_id = parseInt(req.params.id);
        pool.query(
            'SELECT * FROM friends WHERE user_id = $1',
            [user_id],
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