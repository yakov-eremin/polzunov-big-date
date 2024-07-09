module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();

    // добавление нового теста
    router.post('/add', (req, res) => {
        const { user_id, firstresult, secondresult, thirdresult, fourthresult, fifthresult } = req.body;
        pool.query(
            'INSERT INTO tests (user_id, firstresult, secondresult, thirdresult, fourthresult, fifthresult) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
            [user_id, firstresult, secondresult, thirdresult, fourthresult, fifthresult],
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
        const { user_id, firstresult, secondresult, thirdresult, fourthresult, fifthresult } = req.body;
        pool.query(
            'UPDATE tests SET user_id = $1, firstresult = $2, secondresult = $3, thirdresult = $4, fourthresult = $5, fifthresult = $6 WHERE id = $7 RETURNING *',
            [user_id, firstresult, secondresult, thirdresult, fourthresult, fifthresult, id],
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