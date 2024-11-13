const express = require('express');
const sql = require('mssql');
const cors = require('cors');
const app = express();
app.use(cors());

const port = 3000;

// MS SQL Server configuration
const config = {
  user: 'quizmasterpro', // Replace with your actual username if necessary
  password: 'quizmasterpro', // Leave empty for Windows Authentication
  server: 'MIAN\\SQLEXPRESS', // Your server name from SSMS
  database: 'LAB8', // Replace with your database name
  options: {
    encrypt: false, // Use if you're on Windows Azure
    trustServerCertificate: true, // For local development
    trustedConnection: false,
    enableArithAbort: true,
    instancename: 'SQLEXPRESS'
  },
  
};


// Connect to MS SQL Server
sql.connect(config, err => {
  if (err) {
    console.error('Database connection failed:', err);
  } else {
    console.log('Connected to the database');
  }
});

app.get('/COURSE', async(req, res) => {
  try { const pool  = await sql.connect(config);
  const data =  pool.request().query('SELECT * FROM COURSE');
  data.then(res1=>{
    res.json(res1);
  }
  );
} catch (err) {
    console.error('SQL error', err);
    res.status(500).send('SQL error');
  }
});

app.listen(port, () => {
  console.log(`Backend server is running on http://localhost:${port}`);
});