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
  const user_id = req.body.user_id;
  const cards = req.body.cards;
  const isAdd = req.body.isAdd;
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