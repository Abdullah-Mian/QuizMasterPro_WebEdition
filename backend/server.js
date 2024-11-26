// server.js
const express = require("express");
const sql = require("mssql");
const cors = require("cors");
const app = express();

// Add logging middleware
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
});

app.use(cors());
app.use(express.json());

const port = 3000;

let username ;
let password ;
// User login endpoint
app.post('/login', async (req, res) => {
  console.log('Login attempt:', req.body);
  const { username, password } = req.body;
  username = username;
  password = password;
  const config = {
    user: username,
    password: password,
    server: 'quizmasterweb.database.windows.net',
    database: 'SampleDB',
    options: {
      encrypt: true,
      trustServerCertificate: false,
      connectionTimeout: 30000,
      enableArithAbort: true,
    },
  };
  
  try {
    console.log('Attempting database connection...');
    await sql.connect(config);
    console.log('Database connection successful');
    res.json({ message: 'Connected to the database' });
  } catch (err) {
    console.error('SQL error:', err);
    res.status(401).json({ error: 'Invalid credentials' });
  }
});

// Modified authenticate middleware to use headers
const authenticate = (req, res, next) => {
  console.log('Authenticate middleware - Headers:', req.headers);
  
  if (!username || !password) {
    console.log('Missing credentials');
    return res.status(401).json({ error: 'Credentials required' });
  }

  const config = {
    user: username,
    password: password,
    server: 'quizmasterweb.database.windows.net',
    database: 'SampleDB',
    options: {
      encrypt: true,
      trustServerCertificate: false,
      connectionTimeout: 30000,
      enableArithAbort: true,
    },
  };

  console.log('Attempting authentication...');
  sql.connect(config, (err) => {
    if (err) {
      console.error("Database connection failed:", err);
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    console.log("Connected to the database");
    next();
  });
};

app.get('/data', authenticate, async (req, res) => {
  console.log('Data endpoint reached');
  try {
    const pool = await sql.connect(config);
    const result = await pool.request().query('SELECT * FROM SalesLT.Address');
    console.log('Query executed successfully');
    res.json(result.recordset);
  } catch (err) {
    console.error('SQL error:', err);
    res.status(500).json({ error: 'SQL error' });
  }
});

app.listen(port, () => {
  console.log(`Backend server is running on http://localhost:${port}`);
});