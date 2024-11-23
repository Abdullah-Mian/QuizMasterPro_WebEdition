const express = require("express");
const sql = require("mssql");
const cors = require("cors");
const app = express();
app.use(cors());

const port = 3000;

// MS SQL Server configuration
const config = {
  user: "quizmasterpro", // Replace with your actual username if necessary
  password: "quizmasterpro", // Leave empty for Windows Authentication
  server: "MIAN\\SQLEXPRESS", // Your server name from SSMS
  database: "LAB8", // Replace with your database name
  options: {
    encrypt: false, // Use if you're on Windows Azure
    trustServerCertificate: true, // For local development
    trustedConnection: false,
    enableArithAbort: true,
    instancename: "SQLEXPRESS",
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
    const result = await pool.request().query('SELECT * FROM StudentCourses');
    res.json(result.recordset); // Ensure this returns an array
  } catch (err) {
    console.error('SQL error', err);
    res.status(500).send('SQL error');
  }
});
app.get('/ch', async (req, res) => {
  try {
    const pool = await sql.connect(config);
    const result = await pool.request().query('SELECT * FROM course');
    res.json(result.recordset); // Ensure this returns an array
  } catch (err) {
    console.error('SQL error', err);
    res.status(500).send('SQL error');
  }
});


app.listen(port, () => {
  console.log(`Backend server is running on http://localhost:${port}`);
});
