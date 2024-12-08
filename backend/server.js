// backend/server.js
const express = require("express");
const sql = require("mssql");
const cors = require("cors");
const app = express();
const corsOptions = {
  origin: "http://localhost:3000", // Adjust this to match your frontend's URL
  optionsSuccessStatus: 200,
};
app.use(cors(corsOptions));
app.use(express.json());

const port = 3000; // Ensure the port is set to 3000

// User login endpoint
app.post("/login", async (req, res) => {
  console.log("Login attempt:", req.body);
  const { username, password } = req.body;
  const config = {
    user: username,
    password: password,
    server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
    database: "quizmasterpro",
    options: {
      encrypt: true,
      trustServerCertificate: true,
      connectionTimeout: 30000,
      enableArithAbort: true,
    },
  };

  try {
    console.log("Attempting database connection...");
    await sql.connect(config);
    console.log("Database connection successful");
    res.json({ message: "Login successful" });
  } catch (err) {
    console.error("SQL error:", err);
    res.status(401).json({ error: "Invalid credentials" });
  }
});

// Middleware for authentication
const authenticate = (req, res, next) => {
  console.log("Authenticate middleware - Headers:", req.headers);

  const username = req.headers["x-username"];
  const password = req.headers["x-password"];

  if (!username || !password) {
    console.log("Missing credentials");
    return res.status(401).json({ error: "Credentials required" });
  }

  const config = {
    user: username,
    password: password,
    server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
    database: "quizmasterpro",
    options: {
      encrypt: true,
      trustServerCertificate: true,
      connectionTimeout: 30000,
      enableArithAbort: true,
    },
  };

  console.log("Attempting authentication...");
  sql.connect(config, (err) => {
    if (err) {
      console.error("Database connection failed:", err);
      return res.status(401).json({ error: "Invalid credentials" });
    }
    console.log("Connected to the database");
    next();
  });
};

// User verification endpoint
app.get("/userverification", authenticate, async (req, res) => {
  console.log("User verification endpoint reached");
  const username = req.headers["x-username"];
  const loginType = req.headers["x-logintype"];

  try {
    const pool = await sql.connect({
      user: req.headers["x-username"],
      password: req.headers["x-password"],
      server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
      database: "quizmasterpro",
      options: {
        encrypt: true,
        trustServerCertificate: true,
        connectionTimeout: 30000,
        enableArithAbort: true,
      },
    });

    let query;
    if (loginType === "admin") {
      query = `SELECT * FROM Admins WHERE Username = '${username}' AND AdminRole = 'admin'`;
    } else if (loginType === "student") {
      query = `SELECT * FROM Student WHERE Username = '${username}'`;
    } else {
      return res.status(401).json({ error: "Invalid login type" });
    }

    const result = await pool.request().query(query);
    console.log("Query result:", result); // Log the entire result object
    if (result.recordset.length === 0) {
      return res.status(401).json({ error: "User verification failed" });
    }

    console.log("User verification successful");
    res.json({
      message: "User verification successful",
      data: result.recordset,
    });
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

// Endpoint for fetching all courses
app.get("/courses", authenticate, async (req, res) => {
  console.log("Courses endpoint reached");
  try {
    const pool = await sql.connect({
      user: req.headers["x-username"],
      password: req.headers["x-password"],
      server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
      database: "quizmasterpro",
      options: {
        encrypt: true,
        trustServerCertificate: true,
        connectionTimeout: 30000,
        enableArithAbort: true,
      },
    });
    const result = await pool.request().query("SELECT * FROM Course");
    console.log("Query executed successfully");
    res.json(result.recordset);
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

// Endpoint for fetching students
app.get("/students", authenticate, async (req, res) => {
  console.log("Students endpoint reached");
  try {
    const pool = await sql.connect({
      user: req.headers["x-username"],
      password: req.headers["x-password"],
      server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
      database: "quizmasterpro",
      options: {
        encrypt: true,
        trustServerCertificate: true,
        connectionTimeout: 30000,
        enableArithAbort: true,
      },
    });
    const result = await pool.request().query("SELECT * FROM Student");
    console.log("Query executed successfully");
    res.json(result.recordset);
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

// Endpoint for fetching degree programs
app.get("/degreeprograms", authenticate, async (req, res) => {
  console.log("Degree programs endpoint reached");
  try {
    const pool = await sql.connect({
      user: req.headers["x-username"],
      password: req.headers["x-password"],
      server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
      database: "quizmasterpro",
      options: {
        encrypt: true,
        trustServerCertificate: true,
        connectionTimeout: 30000,
        enableArithAbort: true,
      },
    });
    const result = await pool.request().query("SELECT * FROM Deg_Program");
    console.log("Query executed successfully");
    res.json(result.recordset);
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

// Endpoint for fetching students
app.get("/students", authenticate, async (req, res) => {
  console.log("Students endpoint reached");
  const degProg = req.query.degProg;
  try {
    const pool = await sql.connect({
      user: req.headers["x-username"],
      password: req.headers["x-password"],
      server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
      database: "quizmasterpro",
      options: {
        encrypt: true,
        trustServerCertificate: true,
        connectionTimeout: 30000,
        enableArithAbort: true,
      },
    });
    const result = await pool
      .request()
      .query(`SELECT * FROM Student WHERE Deg_Prog = '${degProg}'`);
    console.log("Query executed successfully");
    res.json(result.recordset);
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

// Endpoint for enrolling students
app.post("/enrollstudent", authenticate, async (req, res) => {
  console.log("Enroll student endpoint reached");
  const {
    studentName,
    studentUsername,
    studentPassword,
    degreeProgram,
    courses,
  } = req.body;

  try {
    const pool = await sql.connect({
      user: req.headers["x-username"],
      password: req.headers["x-password"],
      server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
      database: "quizmasterpro",
      options: {
        encrypt: true,
        trustServerCertificate: true,
        connectionTimeout: 30000,
        enableArithAbort: true,
      },
    });

    // Convert courses array to XML format
    const coursesXML = `<Courses>${courses
      .map((courseId) => `<CourseID>${courseId}</CourseID>`)
      .join("")}</Courses>`;

    // Call the stored procedure
    await pool
      .request()
      .input("StudentName", sql.NVarChar, studentName)
      .input("StudentUsername", sql.NVarChar, studentUsername)
      .input("StudentPassword", sql.NVarChar, studentPassword)
      .input("DegreeProgram", sql.NVarChar, degreeProgram)
      .input("Courses", sql.NVarChar, coursesXML)
      .execute("EnrollStudent");

    console.log("Student enrolled successfully");
    res.json({ message: "Student enrolled successfully" });
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

app.listen(port, () => {
  console.log(`Backend server is running on http://localhost:${port}`);
});
