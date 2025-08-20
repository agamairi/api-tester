// server/test_server.js
// Simple test server using Node.js and Express


const express = require('express');
const app = express();
const port = 3000;


app.use(express.json());


app.get('/hello', (req, res) => {
    res.send({ message: 'Hello from test server!' });
});


app.post('/echo', (req, res) => {
    res.send({ received: req.body });
});


app.put('/update', (req, res) => {
    res.send({ updated: true, body: req.body });
});


app.delete('/delete', (req, res) => {
    res.status(204).send();
});


app.listen(port, () => {
    console.log(`Test server running on http://localhost:${port}`);
});