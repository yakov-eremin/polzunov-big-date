module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();
  
    // добавление нового поста
    router.post('/add', (req, res) => {
      const { user_id, content } = req.body;
      pool.query(
        'INSERT INTO posts (user_id, content) VALUES ($1, $2) RETURNING *',
        [user_id, content],
        (error, results) => {
          if (error) {
            throw error;
          }
          res.status(201).json(results.rows[0]);
        }
      );
    });
  
    // удаление поста
    router.delete('/delete/:id', (req, res) => {
      const id = parseInt(req.params.id);
      pool.query(
        'DELETE FROM posts WHERE id = $1',
        [id],
        (error) => {
          if (error) {
            throw error;
          }
          res.status(200).send(`Пост с ID ${id} удалён`);
        }
      );
    });
  
    // получение всех постов пользователя
    router.get('/user/:id', (req, res) => {
      const user_id = parseInt(req.params.id);
      pool.query(
        'SELECT * FROM posts WHERE user_id = $1',
        [user_id],
        (error, results) => {
          if (error) {
            throw error;
          }
          res.status(200).json(results.rows);
        }
      );
    });

    // обновление поста
    router.put('/update/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const { content } = req.body;
    pool.query(
      'UPDATE posts SET content = $1 WHERE id = $2 RETURNING *',
      [content, id],
      (error, results) => {
        if (error) {
          throw error;
        }
        res.status(200).json(results.rows[0]);
      }
    );
  });

    return router;
  };