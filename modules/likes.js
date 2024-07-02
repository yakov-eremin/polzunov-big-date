module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();

    // добавление лайка к посту
    router.post('/add', (req, res) => {
        const { post_id, user_id } = req.body;
        pool.query(
            'INSERT INTO likes (post_id, user_id) VALUES ($1, $2) RETURNING *',
            [post_id, user_id],
            (error, results) => {
                if (error) {
                    throw error;
                }
                res.status(201).json(results.rows[0]);
            }
        );
    });

    // удаление лайка
    router.delete('/delete/:id', (req, res) => {
        const id = parseInt(req.params.id);
        pool.query(
            'DELETE FROM likes WHERE id = $1',
            [id],
            (error) => {
                if (error) {
                    throw error;
                }
                res.status(200).send('Лайк с ID ${id} удалён');
            }
        );
    });

    // получение всех лайков пользователя
    router.get('/user/:id', (req, res) => {
        const user_id = parseInt(req.params.id);
        pool.query(
            'SELECT  FROM likes WHERE user_id = $1',
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