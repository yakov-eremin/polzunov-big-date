module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();

    // добавление нового теста
    router.post('/add', (req, res) => {
        const { test_number, user_id, answers, results } = req.body;
        pool.query(
            'INSERT INTO tests (test_number, user_id, answers, results) VALUES ($1, $2, $3, $4) RETURNING *',
            [test_number, user_id, answers, results],
            (error, results) => {
                if (error) {
                    throw error;
                }
                res.status(201).json(results.rows[0]);
            }
        );
    });

    // удаление теста
    router.delete('/delete/:id', (req, res) => {
        const id = parseInt(req.params.id);
        pool.query(
            'DELETE FROM tests WHERE id = $1',
            [id],
            (error) => {
                if (error) {
                    throw error;
                }
                res.status(200).send(`Тест с ID ${id} удалён`);
            }
        );
    });

    // обновление теста
    router.put('/update/:id', (req, res) => {
        const id = parseInt(req.params.id);
        const { test_number, user_id, answers, results } = req.body;
        pool.query(
            'UPDATE tests SET test_number = $1, user_id = $2, answers = $3, results = $4 WHERE id = $5 RETURNING *',
            [test_number, user_id, answers, results, id],
            (error, results) => {
                if (error) {
                    throw error;
                }
                res.status(200).json(results.rows[0]);
            }
        );
    });

    // получение всех тестов пользователя
    router.get('/user/:id', (req, res) => {
        const user_id = parseInt(req.params.id);
        pool.query(
            'SELECT * FROM tests WHERE user_id = $1',
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