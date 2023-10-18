const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());

app.post('/api/data', (req, res) => {
  console.log(req.body);
  // Replace this with your data or database query
  const data = {
    message: "Hello Node.js!",
  };
  res.json(data);
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});