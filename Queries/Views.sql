--------------------------------
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

--------------------------------
-- Create or alter view for fetching all courses
CREATE OR ALTER VIEW AllCourses AS
SELECT * FROM Course;

-- Grant select permission on the view to the Student role
GRANT SELECT ON AllCourses TO Student,SuperAdmin;

-------------------------------- Call
Select * from AllCourses
--------------------------------


--2
--------------------------------
// Endpoint for fetching students
app.get("/students", authenticaDROP VIEW StudentsByDegreeProgram;
te, async (req, res) => {
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

--------------------------------
-- Create or alter view for fetching all students
CREATE OR ALTER VIEW AllStudents AS
SELECT * FROM Student;

-- Grant select permission on the view to the Student role
GRANT SELECT ON AllStudents TO Student;
-------------------------------- Call
SELECT * FROM AllStudents;
--PROBLEMATIC!!!!!!!!!!!!!!!!!!!!!!!!
--Checked With SSMS!!!!!!!!!!!!!!!!!!!!!!!!


--3
--------------------------------
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

--------------------------------
-- Create or alter view for fetching all degree programs
CREATE OR ALTER VIEW AllDegreePrograms AS
SELECT * FROM Deg_Program;

-- Grant select permission on the view to the Student role
GRANT SELECT ON AllDegreePrograms TO Student;
-------------------------------- Call
Select * from AllDegreePrograms
!--Checked With SSMS ONLY!!!!!!!!!!!!!!!!!!!!!!!!
--------------------------------

--------------------------------
------4
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
--------------------------------
-- Create or alter Procedure for fetching all students
CREATE PROCEDURE GetStudentsByDegProg
    @DegProg NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Student WHERE Deg_Prog = @DegProg;
END
-- Grant select permission on the view to the Student role
GRANT EXECUTE ON OBJECT::dbo.GetStudentsByDegProg TO Student;
GRANT EXECUTE ON OBJECT::dbo.GetStudentsByDegProg TO SuperAdmin;
-------------------------------- Call
EXEC GetStudentsByDegProg @DegProg = 'BSCS';

--Checked With SSMS ONLY!!!!!!!!!!!!!!!!!!!!!!!!
--------------------------------


-- --------------------------------5
-- // Endpoint for enrolling students
-- app.post("/enrollstudent", authenticate, async (req, res) => {
--   console.log("Enroll student endpoint reached");
--   const {
--     studentName,
--     studentUsername,
--     studentPassword,
--     degreeProgram,
--     courses,
--   } = req.body;

--   try {
--     console.log("executing try in enrollstudent");
--     const pool = await sql.connect({
--       user: DB_USER,
--       password: DB_PASSWORD,
--       server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
--       database: "quizmasterpro",
--       options: {
--         encrypt: true,
--         trustServerCertificate: true,
--       },
--     });

--     const coursesXML = `<Courses>${courses
--       .map((courseId) => `<CourseID>${courseId}</CourseID>`)
--       .join("")}</Courses>`;

--     const result = await pool
--       .request()
--       .input("StudentName", sql.NVarChar, studentName)
--       .input("StudentUsername", sql.NVarChar, studentUsername)
--       .input("StudentPassword", sql.NVarChar, studentPassword)
--       .input("DegreeProgram", sql.NVarChar, degreeProgram)
--       .input("Courses", sql.NVarChar, coursesXML)
--       .execute("EnrollNewStudent");

--     if (result.recordset[0].Result === "Success") {
--       res.json({ message: "Student enrolled successfully" });
--     } else {
--       throw new Error("Enrollment failed");
--     }
--   } catch (err) {
--     console.error("Enrollment error:", err);
--     res.status(500).json({
--       error: "Failed to enroll student",
--       details: err.message,
--     });
--   }
-- });
-- --------------------------------
-- CREATE PROCEDURE EnrollNewStudent
--     @StudentName NVARCHAR(50),
--     @StudentUsername NVARCHAR(50),
--     @StudentPassword NVARCHAR(50),
--     @DegreeProgram NVARCHAR(50),
--     @Courses NVARCHAR(MAX)
-- AS
-- BEGIN
--     -- Assuming you have a Student table and a StudentCourses table
--     BEGIN TRANSACTION;

--     BEGIN TRY
--         -- Insert into Student table
--         INSERT INTO Student (Name, Username, Password, Deg_Prog)
--         VALUES (@StudentName, @StudentUsername, @StudentPassword, @DegreeProgram);

--         DECLARE @StudentID INT = SCOPE_IDENTITY();

--         -- Parse the XML and insert into StudentCourses table
--         DECLARE @xml XML = @Courses;
--         INSERT INTO StudentCourses (StudentID, CourseID)
--         SELECT @StudentID, T.value('.', 'INT')
--         FROM @xml.nodes('/Courses/CourseID') AS X(T);

--         COMMIT TRANSACTION;
--         SELECT 'Success' AS Result;
--     END TRY
--     BEGIN CATCH
--         ROLLBACK TRANSACTION;
--         SELECT 'Failure' AS Result, ERROR_MESSAGE() AS ErrorMessage;
--     END CATCH
-- END
-- -- Grant execute permission on the procedure to the Student, SuperAdmin role
-- GRANT EXECUTE ON PROCEDURE EnrollNewStudent TO Student;
-- GRANT EXECUTE ON PROCEDURE EnrollNewStudent TO SuperAdmin;

-- -------------------------------- Call
---------SKIPPED!!!!!!



-- --------------------------------
-- --6
-- // Endpoint for fetching courses associated with a specific student
-- app.get("/studentcourses", authenticate, async (req, res) => {
--   console.log("Student courses endpoint reached");
--   const studentId = req.query.studentId;
--
--   try {
--     const pool = await sql.connect({
--       user: req.headers["x-username"],
--       password: req.headers["x-password"],
--       server: "quizmasterpro.c568kmee42lu.eu-north-1.rds.amazonaws.com",
--       database: "quizmasterpro",
--       options: {
--         encrypt: true,
--         trustServerCertificate: true,
--         connectionTimeout: 30000,
--         enableArithAbort: true,
--       },
--     });
--
--     const result = await pool.request()
--       .query(`SELECT Course.Course_id, Course.Course_Code, Course.Course_Name,
--               (SELECT COUNT(*) FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = ${studentId}) AS AttemptedQuizzes,
--               (SELECT AVG(Progress_Percentage) FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = ${studentId}) AS Progress_Percentage
--               FROM Course
--               INNER JOIN Student_Course ON Course.Course_id = Student_Course.Course_id
--               WHERE Student_Course.StudentID = ${studentId}`);
--     console.log("Query executed successfully");
--     res.json(result.recordset);
--   } catch (err) {
--     console.error("SQL error:", err);
--     res.status(500).json({ error: "SQL error" });
--   }
-- });
-- --------------------------------
-- CREATE PROCEDURE GetStudentCourses
--     @StudentID INT
-- AS
-- BEGIN
--     SELECT
--         Course.Course_id,
--         Course.Course_Code,
--         Course.Course_Name,
--         (SELECT COUNT(*) FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = @StudentID) AS AttemptedQuizzes,
--         (SELECT AVG(Progress_Percentage) FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = @StudentID) AS Progress_Percentage
--     FROM
--         Course
--     INNER JOIN
--         Student_Course ON Course.Course_id = Student_Course.Course_id
--     WHERE
--         Student_Course.StudentID = @StudentID;
-- END
-- GO
--
-- GRANT EXECUTE ON PROCEDURE GetStudentCourses TO Student;
-- GRANT EXECUTE ON PROCEDURE GetStudentCourses TO SuperAdmin;
-- GO
--
--
-- -------------------------------- Call
-- Select * from StudentCoursesView WHERE StudentID = 1
