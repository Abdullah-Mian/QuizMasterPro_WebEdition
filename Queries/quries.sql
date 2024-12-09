-- Create Database
CREATE DATABASE quizmasterpro;
GO

USE quizmasterpro;
GO

-- Create Tables
-- Table for Degree Program
CREATE TABLE Deg_Program
(
    Deg_Prog NVARCHAR(255) PRIMARY KEY,
    Deg_Prog_Name NVARCHAR(255) UNIQUE
);
GO

-- Table for Admins
CREATE TABLE Admins
(
    AdminID INT PRIMARY KEY IDENTITY,
    AdminName NVARCHAR(255) NOT NULL,
    Username NVARCHAR(255) UNIQUE NOT NULL,
    AdminRole NVARCHAR(255) NOT NULL
);
GO

-- Table for Students
CREATE TABLE Student
(
    StudentID INT PRIMARY KEY IDENTITY,
    StudentName NVARCHAR(255),
    Username NVARCHAR(255) UNIQUE NOT NULL,
    Deg_Prog NVARCHAR(255) NOT NULL,
    FOREIGN KEY (Deg_Prog) REFERENCES Deg_Program(Deg_Prog)
    -- Foreign key constraint
);
GO

-- Table for Courses
CREATE TABLE Course
(
    Course_id INT PRIMARY KEY IDENTITY,
    -- Added IDENTITY for auto-increment
    Course_Code NVARCHAR(255) NOT NULL,
    Course_Name NVARCHAR(255),
    Deg_Prog NVARCHAR(255),
    FOREIGN KEY (Deg_Prog) REFERENCES Deg_Program(Deg_Prog)
    -- Foreign key constraint
);
GO

-- Table for Student-Course Relationship
CREATE TABLE Student_Course
(
    SC_ID INT PRIMARY KEY IDENTITY,
    -- Optional surrogate key
    StudentID INT NOT NULL,
    Course_id INT NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    -- Cascade deletion if a student is removed
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id) ON DELETE CASCADE
    -- Cascade deletion if a course is removed
);

-- Populate Student_Course table
INSERT INTO Student_Course (StudentID, Course_id)
SELECT s.StudentID, c.Course_id
FROM Student s
JOIN Course c ON s.Deg_Prog = c.Deg_Prog;
GO
GO

-- Table for Question Bank
CREATE TABLE Question_Bank
(
    QuestionID INT PRIMARY KEY IDENTITY,
    -- Unique identifier for each question
    Question_String NVARCHAR(255) NOT NULL,
    -- The actual question
    Course_Code NVARCHAR(50) NOT NULL
    -- Links the question to a course
);
GO

-- Table for Option Bank
CREATE TABLE Option_Bank
(
    OptionID INT PRIMARY KEY IDENTITY,
    -- Unique identifier for each option
    QuestionID INT NOT NULL,
    -- Links the option to a specific question
    Option_String NVARCHAR(255) NOT NULL,
    -- The text of the option
    FOREIGN KEY (QuestionID) REFERENCES Question_Bank(QuestionID) ON DELETE CASCADE
    -- Ensures options are deleted with their question
);
GO

-- Table for Answer Key
CREATE TABLE Answer_Key
(
    AnswerID INT PRIMARY KEY IDENTITY,
    -- Unique identifier for the answer
    QuestionID INT NOT NULL,
    -- Links the answer to a specific question
    CorrectOptionID INT NOT NULL,
    -- Points to the correct option in Option_Bank
    FOREIGN KEY (QuestionID) REFERENCES Question_Bank(QuestionID) ON DELETE CASCADE,
    -- Ensures answers are deleted with their question
    FOREIGN KEY (CorrectOptionID) REFERENCES Option_Bank(OptionID)
);
GO

-- Table for Quiz Session
CREATE TABLE Quiz_Session
(
    Quiz_SessionID INT PRIMARY KEY IDENTITY,
    -- Unique ID for each session
    StudentID INT NOT NULL,
    -- Links the session to a student
    Course_id int NOT NULL,
    -- Links the session to a course
    Quiz_Date DATE NOT NULL DEFAULT GETDATE(),
    -- Date when the quiz was taken
    Start_Time TIME NOT NULL,
    -- Time when the quiz started
    End_Time TIME NOT NULL,
    -- Time when the quiz ended
    Quiz_TotalScore INT,
    -- Total score of the quiz
    Obtained_Marks INT,
    -- Total marks earned
    Progress_Percentage INT,
    -- Progress percentage
    Scholastic_Status NVARCHAR(50),
    -- Status (e.g., "Pass", "Fail")
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id) ON DELETE CASCADE
);
GO

-- Table for Attempted Quiz
CREATE TABLE Attempted_Quiz
(
    AttemptID INT PRIMARY KEY IDENTITY,
    -- Unique ID for each attempt
    Quiz_SessionID INT NOT NULL,
    -- Links to the quiz session
    Question_String NVARCHAR(255) NOT NULL,
    -- The actual question text
    Actual_Answer NVARCHAR(255) NOT NULL,
    -- Correct answer to the question
    Student_Answer NVARCHAR(255),
    -- Student's provided answer
    Is_Correct BIT,
    -- Whether the student's answer was correct (1 for true, 0 for false)
    FOREIGN KEY (Quiz_SessionID) REFERENCES Quiz_Session(Quiz_SessionID) ON DELETE CASCADE
);
GO

-- Populate Tables
INSERT INTO Deg_Program
    (Deg_Prog, Deg_Prog_Name)
VALUES
    ('BSCS', 'Bachelor of Science in Computer Science'),
    ('BCE', 'Bachelor of Computer Engineering'),
    ('BSSE', 'Bachelor of Science in Software Engineering'),
    ('BSEE', 'Bachelor of Science in Electrical Engineering'),
    ('BSME', 'Bachelor of Science in Mechanical Engineering'),
    ('BSIT', 'Bachelor of Science in Information Technology'),
    ('BBA', 'Bachelor of Business Administration');
GO

INSERT INTO Course
    (Course_Code, Course_Name, Deg_Prog)
VALUES
    -- Courses for BSCS
    ('CS101', 'Introduction to Programming', 'BSCS'),
    ('CS102', 'Data Structures', 'BSCS'),
    ('CS103', 'Algorithms', 'BSCS'),

    -- Courses for BCE
    ('CE101', 'Digital Logic Design', 'BCE'),
    ('CE102', 'Computer Architecture', 'BCE'),
    ('CE103', 'Embedded Systems', 'BCE'),

    -- Courses for BSSE
    ('SE101', 'Software Design and Architecture', 'BSSE'),
    ('SE102', 'Software Testing', 'BSSE'),
    ('SE103', 'Software Project Management', 'BSSE'),

    -- Courses for BSEE
    ('EE101', 'Circuit Analysis', 'BSEE'),
    ('EE102', 'Electromagnetic Theory', 'BSEE'),
    ('EE103', 'Power Systems', 'BSEE'),

    -- Courses for BSME
    ('ME101', 'Thermodynamics', 'BSME'),
    ('ME102', 'Fluid Mechanics', 'BSME'),
    ('ME103', 'Mechanics of Materials', 'BSME'),

    -- Courses for BSIT
    ('IT101', 'Introduction to Networking', 'BSIT'),
    ('IT102', 'Web Development', 'BSIT'),
    ('IT103', 'Database Management Systems', 'BSIT'),

    -- Courses for BBA
    ('BA101', 'Principles of Management', 'BBA'),
    ('BA102', 'Business Communication', 'BBA'),
    ('BA103', 'Marketing Fundamentals', 'BBA');
GO

INSERT INTO Admins
    (AdminName, Username, AdminRole)
VALUES
    ('Admin1', 'AdminLogin1', 'admin');
GO

INSERT INTO Student
    (StudentName, Username, Deg_Prog)
VALUES
    ('Student1', 'StudentLogin1', 'BSCS');
GO

-- Create Roles and Grant Permissions
-- Create roles
CREATE ROLE Student;
CREATE ROLE SuperAdmin;
GO

-- Grant permissions to Student role
-- Grant permissions to Student role
GRANT SELECT ON Deg_Program TO Student;
GRANT SELECT ON Course TO Student;
GRANT SELECT ON Question_Bank TO Student;
GRANT SELECT, INSERT, UPDATE ON Attempted_Quiz TO Student;
GRANT SELECT ON Student TO Student;
GRANT SELECT ON Student_Course TO Student;
GO

-- Grant permissions to SuperAdmin role
GRANT SELECT, INSERT, UPDATE, DELETE ON Student TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Deg_Program TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Course TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Question_Bank TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Option_Bank TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Answer_Key TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Admins TO SuperAdmin;
GRANT EXECUTE ON OBJECT::dbo.EnrollStudent TO SuperAdmin;
GRANT CREATE USER TO SuperAdmin;
GRANT ALTER ANY USER TO SuperAdmin;
GRANT ALTER ANY ROLE TO SuperAdmin;

GRANT CREATE LOGIN TO SuperAdminRole;
GO

-- Create Logins and Users
-- Create login and user for a student
CREATE LOGIN StudentLogin1 WITH PASSWORD = 'SecurePassword123!';
CREATE USER StudentUser1 FOR LOGIN StudentLogin1;
ALTER ROLE Student ADD MEMBER StudentUser1;
GO

-- Create login and user for an SuperAdmin
CREATE LOGIN AdminLogin1 WITH PASSWORD = 'AdminSecurePass!';
CREATE USER AdminUser1 FOR LOGIN AdminLogin1;
ALTER ROLE SuperAdmin ADD MEMBER AdminUser1;
GO

CREATE LOGIN TestAdmin WITH PASSWORD = 'TestAdmin123!';
CREATE USER TestUser FOR LOGIN TestAdmin;
ALTER ROLE SuperAdmin ADD MEMBER TestUser;
GO
------------------------------------------------------------------------------------------
-- Query to Fetch Courses for one student
SELECT Course.Course_Code, Course.Course_Name FROM Course
              INNER JOIN Student_Course ON Course.Course_id = Student_Course.Course_id
              WHERE Student_Course.StudentID = '1'
------------------------------------------------------------------------------------------
-- Stored Procedure for Enrolling Students
CREATE PROCEDURE EnrollStudent
    @StudentName NVARCHAR(255),
    @StudentUsername NVARCHAR(255),
    @StudentPassword NVARCHAR(255),
    @DegreeProgram NVARCHAR(255),
    @Courses NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Create login for the student
        DECLARE @Login NVARCHAR(255) = @StudentUsername;
        EXEC sp_executesql N'CREATE LOGIN [' + @Login + '] WITH PASSWORD = @Password', N'@Password NVARCHAR(255)', @Password = @StudentPassword;

        -- Create user for the login
        EXEC sp_executesql N'CREATE USER [' + @StudentUsername + '] FOR LOGIN [' + @Login + ']';
        EXEC sp_executesql N'ALTER ROLE Student ADD MEMBER [' + @StudentUsername + ']';

        -- Add student to the Student table
        DECLARE @StudentID INT;
        INSERT INTO Student (StudentName, Username, Deg_Prog)
        VALUES (@StudentName, @StudentUsername, @DegreeProgram);
        SELECT @StudentID = SCOPE_IDENTITY();

        -- Add courses to the Student_Course table
        DECLARE @CourseID INT;
        DECLARE @XMLCourses XML = CAST(@Courses AS XML);
        DECLARE CourseCursor CURSOR FOR
            SELECT T.C.value('.', 'INT') AS CourseID
            FROM @XMLCourses.nodes('/Courses/CourseID') AS T(C);

        OPEN CourseCursor;
        FETCH NEXT FROM CourseCursor INTO @CourseID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO Student_Course (StudentID, Course_id)
            VALUES (@StudentID, @CourseID);

            FETCH NEXT FROM CourseCursor INTO @CourseID;
        END;

        CLOSE CourseCursor;
        DEALLOCATE CourseCursor;

        COMMIT;
        PRINT 'Student enrolled successfully';
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END;
GO


CREATE PROCEDURE EnrollStudentWithElevatedPrivileges
    @StudentName NVARCHAR(255),
    @StudentUsername NVARCHAR(255),
    @StudentPassword NVARCHAR(255),
    @DegreeProgram NVARCHAR(255),
    @Courses NVARCHAR(MAX)
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Create login for the student
        DECLARE @Login NVARCHAR(255) = @StudentUsername;
        EXEC sp_executesql N'CREATE LOGIN ' + @Login + ' WITH PASSWORD = @Password', N'@Password NVARCHAR(255)', @Password = @StudentPassword;

        -- Create user for the login
        EXEC sp_executesql N'CREATE USER ' + @StudentUsername + ' FOR LOGIN ' + @Login;
        EXEC sp_executesql N'ALTER ROLE Student ADD MEMBER ' + @StudentUsername;

        -- Add student to the Student table
        DECLARE @StudentID INT;
        INSERT INTO Student (StudentName, Username, Deg_Prog)
        VALUES (@StudentName, @StudentUsername, @DegreeProgram);
        SELECT @StudentID = SCOPE_IDENTITY();

        -- Add courses to the Student_Course table
        DECLARE @CourseID INT;
        DECLARE @XMLCourses XML = CAST(@Courses AS XML);
        DECLARE CourseCursor CURSOR FOR
            SELECT T.C.value('.', 'INT') AS CourseID
            FROM @XMLCourses.nodes('/Courses/CourseID') AS T(C);

        OPEN CourseCursor;
        FETCH NEXT FROM CourseCursor INTO @CourseID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO Student_Course (StudentID, Course_id)
            VALUES (@StudentID, @CourseID);

            FETCH NEXT FROM CourseCursor INTO @CourseID;
        END;

        CLOSE CourseCursor;
        DEALLOCATE CourseCursor;

        COMMIT;
        PRINT 'Student enrolled successfully';
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END;
GO

DECLARE @Courses NVARCHAR(MAX) = '<Courses><CourseID>5</CourseID><CourseID>4</CourseID></Courses>';

EXEC EnrollStudent
    @StudentName = 'Faizan',
    @StudentUsername = 'FA22-BCE-086',
    @StudentPassword = 'Rfvg123!',
    @DegreeProgram = 'BCE',
    @Courses = @Courses;

-- delete procedere 
DROP PROCEDURE EnrollStudentWithElevatedPrivileges;