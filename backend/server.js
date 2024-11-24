const express = require("express");
const sql = require("mssql");
const cors = require("cors");
const app = express();
app.use(cors());

const port = 3000;

// MS SQL Server configuration
const config = {
  user: '.........', // SQL Server username
  password: '{PASSWORD}', // SQL Server password
  server: 'quizmasterweb.database.windows.net', // Your server name
  database: 'SampleDB', // Your database name
  options: {
    encrypt: true, // Encrypt the connection (important for Azure SQL)
    trustServerCertificate: false, // Don't trust self-signed certificates
    connectionTimeout: 30000, // Timeout in milliseconds (30 seconds)
    enableArithAbort: true, // Automatically abort on arithmetic errors
  },
};

// Connect to MS SQL Server
sql.connect(config, (err) => {
  if (err) {
    console.error("Database connection failed:", err);
  } else {
    console.log("Connected to the database");
  }
});

app.get('/COURSE', async (req, res) => {
  try {
    const pool = await sql.connect(config);
    const result = await pool.request().query('SELECT * FROM SalesLT.Address');
    res.json(result.recordset); // Ensure this returns an array
  } catch (err) {
    console.error('SQL error', err);
    res.status(500).send('SQL error');
  }
});

app.listen(port, () => {
  console.log(`Backend server is running on http://localhost:${port}`);
});
