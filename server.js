const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// إعداد CORS
app.use(cors());
app.use(bodyParser.json());

// إعداد اتصال MySQL
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'terhalkum', // اسم قاعدة البيانات
});

db.connect((err) => {
  if (err) {
    console.log('Database connection error: ', err);
    return;
  }
  console.log('Connected to MySQL Database');
});

// API لجلب قائمة الجولات
app.get('/api/tours', (req, res) => {
  const query = 'SELECT * FROM tours';
  db.query(query, (err, results) => {
    if (err) {
      res.status(500).send('Error fetching tours');
    } else {
      res.json(results);
    }
  });
});


// Define a simple API route to get travel packages
app.get('/packages', (req, res) => {
    const query = 'SELECT * FROM packages';
    db.query(query, (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).json({ error: 'Database query error' });
        } else {
            res.status(200).json(results);
        }
    });
});

// Define a POST route to add new packages
app.post('/packages', (req, res) => {
    const { name, price, imageUrl } = req.body;
    const query = 'INSERT INTO packages (name, price, imageUrl) VALUES (?, ?, ?)';
    db.query(query, [name, price, imageUrl], (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).json({ error: 'Database insertion error' });
        } else {
            res.status(201).json({ message: 'Package added successfully', id: result.insertId });
        }
    });
});

// تشغيل الخادم
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});




