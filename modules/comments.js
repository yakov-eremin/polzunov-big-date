module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();

    // добавление нового комментария к посту
    router.post('/add', (req, res) => {
        const { post_id, user_id, content } = req.body;
        pool.query(
            'INSERT INTO comments (post_id, user_id, content) VALUES ($1, $2, $3) RETURNING *',
            [post_id, user_id, content],
            (error, results) => {
                if (error) {
                    throw error;
                }
                res.status(201).json(results.rows[0]);
            }
        );
    });

    // удаление комментария
    router.delete('/delete/:id', (req, res) => {
        const id = parseInt(req.params.id);
        pool.query(
            'DELETE FROM comments WHERE id = $1',
            [id],
            (error) => {
                if (error) {
                    throw error;
                }
                res.status(200).send(`Комментарий с ID ${id} удалён`);
            }
        );
    });
    // обновление комментария
    router.put('/update/:id', (req, res) => {
        const id = parseInt(req.params.id);
        const { content } = req.body;
        pool.query(
            'UPDATE comments SET content = $1 WHERE id = $2 RETURNING *',
            [content, id],
            (error, results) => {
                if (error) {
                    throw error;
                }           
                res.status(200).json(results.rows[0]);
            }
        );
    });
  
    // получение всех комментариев к посту
    router.get('/post/:id', (req, res) => {
        const post_id = parseInt(req.params.id);
        pool.query(
            'SELECT * FROM comments WHERE post_id = $1',
            [post_id],
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