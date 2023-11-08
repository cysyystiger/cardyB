const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());

app.post('/updateCard', (req, res) => {
  //mock data
  // const user_id = 3837;
  // const cards = ["amex", "visa"];
  // const isAdd = true;
  console.log(req.body);
  const user_id = req.body.user_id;
  const cards = req.body.cards;
  const isAdd = req.body.isAdd;
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
    //TODO: connect with database
    data = {
      cards: [12, 23, 34]
    };
  } else {
    data = {
      cards: [13, 35, 57]
    };    
  }
  res.json(data);
});

app.get('/fetchAmount', (req, res) => {
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