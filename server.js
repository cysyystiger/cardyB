const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());

// Hello bernie
app.get('/api/data', (req, res) => {
  // Replace this with your data or database query
  const data = {
    message: "Hello Node.js!",
  };
  res.json(data);
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});