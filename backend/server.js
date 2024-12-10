// backend/server.js
const express = require("express");
const sql = require("mssql");
const cors = require("cors");
const dotenv = require("dotenv");

// Load environment variables from .env file
dotenv.config();
const DB_USER = process.env.MASTER_DB_USER;
const DB_PASSWORD = process.env.MASTER_DB_PASSWORD;
console.log("DB_USER:", DB_USER);
console.log("DB_PASSWORD:", DB_PASSWORD);

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
  console.log("Attempting user verification...");
  console.log("Login type:", loginType);
  console.log("Username:", username);
  console.log("Password:", req.headers["x-password"]);
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
    console.log("executing try in enrollstudent");
    const pool = await sql.connect({
      user: DB_USER,
      password: DB_PASSWORD,
      server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
      database: "quizmasterpro",
      options: {
        encrypt: true,
        trustServerCertificate: true,
      },
    });

    const coursesXML = `<Courses>${courses
      .map((courseId) => `<CourseID>${courseId}</CourseID>`)
      .join("")}</Courses>`;

    const result = await pool
      .request()
      .input("StudentName", sql.NVarChar, studentName)
      .input("StudentUsername", sql.NVarChar, studentUsername)
      .input("StudentPassword", sql.NVarChar, studentPassword)
      .input("DegreeProgram", sql.NVarChar, degreeProgram)
      .input("Courses", sql.NVarChar, coursesXML)
      .execute("EnrollNewStudent");

    if (result.recordset[0].Result === "Success") {
      res.json({ message: "Student enrolled successfully" });
    } else {
      throw new Error("Enrollment failed");
    }
  } catch (err) {
    console.error("Enrollment error:", err);
    res.status(500).json({
      error: "Failed to enroll student",
      details: err.message,
    });
  }
});

// Endpoint for fetching courses associated with a specific student
app.get("/studentcourses", authenticate, async (req, res) => {
  console.log("Student courses endpoint reached");
  const studentId = req.query.studentId;

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

    const result = await pool.request()
      .query(`SELECT Course.Course_id, Course.Course_Code, Course.Course_Name, 
              (SELECT COUNT(*) FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = ${studentId}) AS AttemptedQuizzes,
              (SELECT AVG(Progress_Percentage) FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = ${studentId}) AS Progress_Percentage
              FROM Course
              INNER JOIN Student_Course ON Course.Course_id = Student_Course.Course_id
              WHERE Student_Course.StudentID = ${studentId}`);
    console.log("Query executed successfully");
    res.json(result.recordset);
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

// Endpoint for fetching course details
app.get("/coursedetails", authenticate, async (req, res) => {
  console.log("Course details endpoint reached");
  const studentId = req.query.studentId;
  const courseId = req.query.courseId;

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

    const result = await pool.request().query(`SELECT 
    Course.Course_Code, 
    Course.Course_Name, 
    (SELECT COUNT(*) 
     FROM Quiz_Session 
     WHERE Quiz_Session.Course_id = Course.Course_id 
       AND Quiz_Session.StudentID = ${studentId}) AS AttemptedQuizzes,
    (SELECT STRING_AGG(CONCAT(Quiz_SessionID, ',', Obtained_Marks, ',', Quiz_TotalScore), ';') 
     FROM Quiz_Session 
     WHERE Quiz_Session.Course_id = Course.Course_id 
       AND Quiz_Session.StudentID = ${studentId}) AS QuizDetails
      FROM 
      Course
      WHERE 
    Course.Course_id = ${courseId}`);
    console.log("Query executed successfully");
    res.json(result.recordset[0]);
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

// Endpoint for fetching progress data
app.get("/progress", authenticate, async (req, res) => {
  console.log("Progress endpoint reached");
  const studentId = req.query.studentId;

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

    const result = await pool.request()
      .query(`SELECT Course.Course_Name, AVG(Quiz_Session.Progress_Percentage) AS Progress_Percentage
              FROM Quiz_Session
              INNER JOIN Course ON Quiz_Session.Course_id = Course.Course_id
              WHERE Quiz_Session.StudentID = ${studentId}
              GROUP BY Course.Course_Name`);
    console.log("Query executed successfully");
    res.json(result.recordset);
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

app.listen(port, () => {
  console.log(`Backend server is running on http://localhost:${port}`);
});
