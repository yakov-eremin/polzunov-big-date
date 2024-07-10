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
  

  // получение всех постов, от пользоваетля, а так же их лайки и дизлайки
  router.get('/user/:id', async (req, res) => {
    const user_id = parseInt(req.params.id);
    try {
      const postsResult = await pool.query('SELECT * FROM posts WHERE user_id = $1', [user_id]);
      const posts = postsResult.rows;

      for (const post of posts) {
        const userResult = await pool.query('SELECT username FROM users WHERE id = $1', [post.user_id]);
        post.username = userResult.rows[0].username;

        const likesResult = await pool.query(
          'SELECT COUNT(*) AS like_count FROM likes WHERE post_id = $1',
          [post.id]
        );
        post.like_count = parseInt(likesResult.rows[0].like_count) || 0;
        post.dislike_count = 0; // временная мера - всегда 0 (пока что нет их))
      }

      res.status(200).json({ tag: 'posts', data: posts });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

  // изменение поста
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