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
    const result = await pool.request().query("SELECT * FROM vw_allCourses");
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
    const result = await pool
      .request()
      .query("SELECT * FROM vw_allDegreePrograms");
    console.log("Query executed successfully");
    res.json(result.recordset);
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

// Endpoint for fetching students by degree program
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
      .input("DegProg", sql.NVarChar, degProg)
      .execute("GetStudentsByDegProg");

    console.log("Procedure executed successfully");
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

// Endpoint for fetching 10 random quizzes
app.get("/randomquizzes", authenticate, async (req, res) => {
  const courseId = req.query.courseId;
  const limit = parseInt(req.query.limit, 10) || 10;
  const studentId = req.headers["x-studentid"];

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

    const questionsResult = await pool
      .request()
      .input("CourseCode", sql.NVarChar, courseId)
      .input("Limit", sql.Int, limit)
      .input("StudentID", sql.Int, studentId)
      .execute("GetRandomQuestions");

    const questions = questionsResult.recordset;
    for (const question of questions) {
      const optionsResult = await pool
        .request()
        .input("questionId", sql.Int, question.QuestionID).query(`
          SELECT *
          FROM Option_Bank
          WHERE QuestionID = @questionId
        `);
      question.Options = optionsResult.recordset;
    }

    res.json(questions);
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

// Endpoint for inserting quiz session
app.post("/insertquizsession", authenticate, async (req, res) => {
  const {
    studentId,
    courseId,
    startTime,
    endTime,
    totalMarks,
    obtainedMarks,
    progressPercentage,
    scholasticStatus,
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

    const result = await pool
      .request()
      .input("StudentID", sql.Int, studentId)
      .input("CourseID", sql.Int, courseId)
      .input("StartTime", sql.DateTime, startTime)
      .input("EndTime", sql.DateTime, endTime)
      .input("TotalMarks", sql.Int, totalMarks)
      .input("ObtainedMarks", sql.Int, obtainedMarks)
      .input("ProgressPercentage", sql.Int, progressPercentage)
      .input("ScholasticStatus", sql.NVarChar, scholasticStatus)
      .execute("InsertQuizSession");

    res.json({ quizSessionId: result.recordset[0].QuizSessionID });
  } catch (err) {
    console.error("Error inserting quiz session:", err);
    res.status(500).json({ error: "Error inserting quiz session" });
  }
});

// Endpoint for inserting attempted quiz
app.post("/insertattemptedquiz", authenticate, async (req, res) => {
  const {
    quizSessionId,
    questionString1,
    studentAnswer1,
    correctAnswer1,
    questionString2,
    studentAnswer2,
    correctAnswer2,
    questionString3,
    studentAnswer3,
    correctAnswer3,
    questionString4,
    studentAnswer4,
    correctAnswer4,
    questionString5,
    studentAnswer5,
    correctAnswer5,
    questionString6,
    studentAnswer6,
    correctAnswer6,
    questionString7,
    studentAnswer7,
    correctAnswer7,
    questionString8,
    studentAnswer8,
    correctAnswer8,
    questionString9,
    studentAnswer9,
    correctAnswer9,
    questionString10,
    studentAnswer10,
    correctAnswer10,
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

    const result = await pool
      .request()
      .input("QuizSessionID", sql.Int, quizSessionId)
      .input("QuestionString1", sql.NVarChar, questionString1 || "")
      .input("StudentAnswer1", sql.NVarChar, studentAnswer1 || "")
      .input("CorrectAnswer1", sql.NVarChar, correctAnswer1 || "")
      .input("QuestionString2", sql.NVarChar, questionString2 || "")
      .input("StudentAnswer2", sql.NVarChar, studentAnswer2 || "")
      .input("CorrectAnswer2", sql.NVarChar, correctAnswer2 || "")
      .input("QuestionString3", sql.NVarChar, questionString3 || "")
      .input("StudentAnswer3", sql.NVarChar, studentAnswer3 || "")
      .input("CorrectAnswer3", sql.NVarChar, correctAnswer3 || "")
      .input("QuestionString4", sql.NVarChar, questionString4 || "")
      .input("StudentAnswer4", sql.NVarChar, studentAnswer4 || "")
      .input("CorrectAnswer4", sql.NVarChar, correctAnswer4 || "")
      .input("QuestionString5", sql.NVarChar, questionString5 || "")
      .input("StudentAnswer5", sql.NVarChar, studentAnswer5 || "")
      .input("CorrectAnswer5", sql.NVarChar, correctAnswer5 || "")
      .input("QuestionString6", sql.NVarChar, questionString6 || "")
      .input("StudentAnswer6", sql.NVarChar, studentAnswer6 || "")
      .input("CorrectAnswer6", sql.NVarChar, correctAnswer6 || "")
      .input("QuestionString7", sql.NVarChar, questionString7 || "")
      .input("StudentAnswer7", sql.NVarChar, studentAnswer7 || "")
      .input("CorrectAnswer7", sql.NVarChar, correctAnswer7 || "")
      .input("QuestionString8", sql.NVarChar, questionString8 || "")
      .input("StudentAnswer8", sql.NVarChar, studentAnswer8 || "")
      .input("CorrectAnswer8", sql.NVarChar, correctAnswer8 || "")
      .input("QuestionString9", sql.NVarChar, questionString9 || "")
      .input("StudentAnswer9", sql.NVarChar, studentAnswer9 || "")
      .input("CorrectAnswer9", sql.NVarChar, correctAnswer9 || "")
      .input("QuestionString10", sql.NVarChar, questionString10 || "")
      .input("StudentAnswer10", sql.NVarChar, studentAnswer10 || "")
      .input("CorrectAnswer10", sql.NVarChar, correctAnswer10 || "")
      .execute("InsertAttemptedQuiz");

    res.json({ message: result.recordset[0].ConfirmationMessage });
  } catch (err) {
    console.error("Error inserting attempted quiz:", err);
    res.status(500).json({ error: "Error inserting attempted quiz" });
  }
});

// Endpoint for fetching correct answers
app.post("/correctanswers", authenticate, async (req, res) => {
  const { questionIds } = req.body;

  if (!Array.isArray(questionIds) || questionIds.length === 0) {
    return res.status(400).json({ error: "Invalid question IDs" });
  }

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

    const questionIdsString = questionIds.join(",");
    const result = await pool.request().query(`
      SELECT QuestionID, CorrectOptionID
      FROM Answer_Key
      WHERE QuestionID IN (${questionIdsString})
    `);

    const correctAnswers = {};
    result.recordset.forEach((row) => {
      correctAnswers[row.QuestionID] = row.CorrectOptionID;
    });

    res.json({ correctAnswers });
  } catch (err) {
    console.error("SQL error:", err);
    res.status(500).json({ error: "SQL error" });
  }
});

app.listen(port, () => {
  console.log(`Backend server is running on http://localhost:${port}`);
});
