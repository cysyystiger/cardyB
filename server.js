const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());

const Pool = require('pg').Pool
const pool = new Pool({
  user: 'me',
  host: 'localhost',
  database: 'prototype',
  password: 'password',
  port: 5432,
})

app.post('/updateCard', (req, res) => {
  const { user_id, cards, isAdd } = req.body;
  if (user_id !== parseInt(user_id)) {
    res.status(400).send('user_id is not integer');
    return;
  }
  if (typeof cards !== "object") {
    res.status(400).send('cards is not a list');
    return;
  }
  cards.forEach(c => {
    if (c !== parseInt(c)) {
      res.status(400).send('card_id is not integer');
    }
    return;
  });
  if (typeof isAdd !== "boolean") {
    res.status(400).send('isAdd is not boolean');
    return;
  }
  let data;
  if (isAdd) {
    pool.query('UPDATE users SET cards = ARRAY_CAT(cards, $1) WHERE id = $2 RETURNING cards', [cards, user_id], (error, results) => {
      if (error) {
        res.status(400).send(`Error: ${error}`);
        return;
      }
      console.log(`User with ID ${user_id} has been updated`);
      data = {
        cards: results.rows[0].cards
      };
    });
  } else {
    pool.query(
      `
      UPDATE users AS t
      SET cards = (
          SELECT array_agg(e)
          FROM unnest(t.cards) AS e
          WHERE e != ALL($1)
      )
      WHERE id = $2
      RETURNING cards;
      `,
      [cards, user_id],
      (error, results) => {
        if (error) {
          res.status(400).send(`Error: ${error}`);
          return;
        } else {
          console.log(`User with ID ${user_id} has been updated`);
          data = {
            cards: results.rows[0].cards
          };
        }
      }
    );  
  }
  res.json(data);
});

app.post('/fetchAmount', (req, res) => {
  const user_id = 3837;
  const category_id = 12;
  const amount = 3.0;
  const data = {
    card_id: 12,
    amount: 2.0
  };
  res.json(data);
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});