
module.exports = (pool) => {
    const express = require('express');
    const router = express.Router();
  
    // добавление нового пользователя
    router.post('/add', (req, res) => {
      const { username, email, password } = req.body;
      pool.query(
        'INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING *',
        [username, email, password],
        (error, results) => {
          if (error) {
            throw error;
          }
          res.status(201).json(results.rows[0]);
        }
      );
    });
  
    // удаление пользователя
    router.delete('/delete/:id', (req, res) => {
      const id = parseInt(req.params.id);
      pool.query(
        'DELETE FROM users WHERE id = $1',
        [id],
        (error) => {
          if (error) {
            throw error;
          }
          res.status(200).send('Пользователь с ID ${id} удалён');
        }
      );
    });
  
    // получение данных пользователя по ID
    router.get('/:id', (req, res) => {
      const id = parseInt(req.params.id);
      pool.query(
        'SELECT * FROM users WHERE id = $1', 
        [id], 
        (error, results) => {
            if (error) {
              res.status(500).json({ error: error.message });
            } else if (results.rows.length === 0) {
              res.status(404).json({ error: 'Пользователь не найден' });
            } else {
              res.status(200).json(results.rows[0]);
            }
        });
      });

    // обновление данных пользователя
    router.put('/update/:id', (req, res) => {
      const id = parseInt(req.params.id);
      const { username, email, password } = req.body;
      pool.query(
        'UPDATE users SET username = $1, email = $2, password = $3 WHERE id = $4 RETURNING *',
        [username, email, password, id],
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