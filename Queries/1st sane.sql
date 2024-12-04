CREATE DATABASE quizmasterpro;
GO
Use quizmasterpro;

-- Table for Degree Program
CREATE TABLE Deg_Program
(
    Deg_Prog NVARCHAR(255) PRIMARY KEY, 
    Deg_Prog_Name NVARCHAR(255) UNIQUE
);

-- Table for Admins
CREATE TABLE Admins
(
    AdminID		INT PRIMARY KEY IDENTITY,
    AdminName	NVARCHAR(255) NOT NULL, 
    Username	NVARCHAR(255) UNIQUE NOT NULL,
    AdminRole	NVARCHAR(255) NOT NULL
);

-- Table for Students
CREATE TABLE Student
(
    StudentID	INT PRIMARY KEY IDENTITY,
    StudentName NVARCHAR(255),
    Username	NVARCHAR(255) UNIQUE NOT NULL,
    Deg_Prog NVARCHAR(255) NOT NULL,
    FOREIGN KEY (Deg_Prog) REFERENCES Deg_Program(Deg_Prog) -- Foreign key constraint
);

-- Table for Courses
CREATE TABLE Course
(	
    Course_id   INT PRIMARY KEY IDENTITY, -- Added IDENTITY for auto-increment
    Course_Code NVARCHAR(255) NOT NULL,
    Course_Name NVARCHAR(255),
    Deg_Prog NVARCHAR(255),
    FOREIGN KEY (Deg_Prog) REFERENCES Deg_Program(Deg_Prog) -- Foreign key constraint
);

-- Table for Student-Course Relationship
CREATE TABLE Student_Course
(
	SC_ID       INT PRIMARY KEY IDENTITY, -- Optional surrogate key
    StudentID   INT NOT NULL,
    Course_id   INT NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE, -- Cascade deletion if a student is removed
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id) ON DELETE CASCADE -- Cascade deletion if a course is removed
);

CREATE TABLE Question_Bank
(
    QuestionID INT PRIMARY KEY IDENTITY, -- Unique identifier for each question
    Question_String NVARCHAR(255) NOT NULL, -- The actual question
    Course_Code NVARCHAR(50) NOT NULL -- Links the question to a course
);

CREATE TABLE Option_Bank
(
    OptionID INT PRIMARY KEY IDENTITY, -- Unique identifier for each option
    QuestionID INT NOT NULL, -- Links the option to a specific question
    Option_String NVARCHAR(255) NOT NULL, -- The text of the option
    FOREIGN KEY (QuestionID) REFERENCES Question_Bank(QuestionID) ON DELETE CASCADE -- Ensures options are deleted with their question
);

CREATE TABLE Answer_Key
(
    AnswerID INT PRIMARY KEY IDENTITY, -- Unique identifier for the answer
    QuestionID INT NOT NULL, -- Links the answer to a specific question
    CorrectOptionID INT NOT NULL, -- Points to the correct option in Option_Bank
    FOREIGN KEY (QuestionID) REFERENCES Question_Bank(QuestionID) ON DELETE CASCADE, -- Ensures answers are deleted with their question
    FOREIGN KEY (CorrectOptionID) REFERENCES Option_Bank(OptionID) 
);
---------------------------------------

CREATE TABLE Quiz_Session
(
    Quiz_SessionID INT PRIMARY KEY IDENTITY, -- Unique ID for each session
    StudentID INT NOT NULL, -- Links the session to a student
    Course_id int NOT NULL, -- Links the session to a course
    Quiz_Date DATE NOT NULL DEFAULT GETDATE(), -- Date when the quiz was taken
    Start_Time TIME NOT NULL, -- Time when the quiz started
    End_Time TIME NOT NULL, -- Time when the quiz ended
    Quiz_TotalScore INT, -- Total score of the quiz
    Obtained_Marks INT, -- Total marks earned
    Progress_Percentage INT, -- Progress percentage
    Scholastic_Status NVARCHAR(50), -- Status (e.g., "Pass", "Fail")
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id) ON DELETE CASCADE
);

CREATE TABLE Attempted_Quiz
(
    AttemptID INT PRIMARY KEY IDENTITY, -- Unique ID for each attempt
    Quiz_SessionID INT NOT NULL, -- Links to the quiz session
    Question_String NVARCHAR(255) NOT NULL, -- The actual question text
    Actual_Answer NVARCHAR(255) NOT NULL, -- Correct answer to the question
    Student_Answer NVARCHAR(255), -- Student's provided answer
    Is_Correct BIT, -- Whether the student's answer was correct (1 for true, 0 for false)
    FOREIGN KEY (Quiz_SessionID) REFERENCES Quiz_Session(Quiz_SessionID) ON DELETE CASCADE
);


----------------------------------------------------------------------------------------------------
-- Create roles
CREATE ROLE Student;
CREATE ROLE Admin;

-- Grant permissions to Student role
GRANT SELECT ON Deg_Program TO Student;
GRANT SELECT ON Course TO Student;
GRANT SELECT ON Question_Bank TO Student;
GRANT SELECT, INSERT, UPDATE ON Attempted_Quiz TO Student;

-- Grant permissions to Admin role
GRANT SELECT, INSERT, UPDATE, DELETE ON Student TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Deg_Program TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Course TO Admin;


-- Create login and user for a student
CREATE LOGIN StudentLogin1 WITH PASSWORD = 'SecurePassword123!';
CREATE USER StudentUser1 FOR LOGIN StudentLogin1;
ALTER ROLE Student ADD MEMBER StudentUser1;

-- Create login and user for an admin
CREATE LOGIN AdminLogin1 WITH PASSWORD = 'AdminSecurePass!';
CREATE USER AdminUser1 FOR LOGIN AdminLogin1;
ALTER ROLE Admin ADD MEMBER AdminUser1;

-----------------------------------------------------------------------------------------
CREATE PROCEDURE CreateUserAndAssignRole
    @Username NVARCHAR(255),
    @Password NVARCHAR(50),
    @Role NVARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Create a login
        DECLARE @Login NVARCHAR(255) = CONCAT(@Username, '_Login');
        EXEC ('CREATE LOGIN ' + @Login + ' WITH PASSWORD = ''' + @Password + ''';');

        -- Create a user for the login
        EXEC ('CREATE USER ' + @Username + ' FOR LOGIN ' + @Login + ';');

        -- Assign role to the user
        IF @Role = 'Student'
            EXEC ('ALTER ROLE Student ADD MEMBER ' + @Username + ';');
        ELSE IF @Role = 'Admin'
            EXEC ('ALTER ROLE Admin ADD MEMBER ' + @Username + ';');
        ELSE
            THROW 50000, 'Invalid Role. Must be Student or Admin.', 1;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END;


CREATE PROCEDURE AttemptQuiz
    @Quiz_SessionID INT,
    @QuestionID INT,
    @Student_Answer NVARCHAR(255)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Fetch the correct answer
        DECLARE @CorrectAnswer NVARCHAR(255);
        SELECT @CorrectAnswer = Option_String
        FROM Option_Bank
        WHERE OptionID = (SELECT CorrectOptionID FROM Answer_Key WHERE QuestionID = @QuestionID);

        -- Determine if the answer is correct
        DECLARE @Is_Correct BIT = CASE WHEN @CorrectAnswer = @Student_Answer THEN 1 ELSE 0 END;

        -- Insert into Attempted_Quiz
        INSERT INTO Attempted_Quiz (Quiz_SessionID, Question_String, Actual_Answer, Student_Answer, Is_Correct)
        VALUES (@Quiz_SessionID, (SELECT Question_String FROM Question_Bank WHERE QuestionID = @QuestionID),
                @CorrectAnswer, @Student_Answer, @Is_Correct);

        -- Update progress or scores (example)
        UPDATE Quiz_Session
        SET Obtained_Marks = Obtained_Marks + CASE WHEN @Is_Correct = 1 THEN 1 ELSE 0 END,
            Progress_Percentage = Progress_Percentage + 10 -- Example progress increment
        WHERE Quiz_SessionID = @Quiz_SessionID;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END;


================================
SELECT Deg_Prog_Name FROM Deg_Program WHERE Deg_Prog = (SELECT Deg_Prog FROM Student WHERE StudentID = @StudentID);
SELECT Course_Name FROM Course WHERE Deg_Prog = (SELECT Deg_Prog FROM Student WHERE StudentID = @StudentID);

--------------------------------
SELECT TOP (@NumberOfQuestions) *
FROM Question_Bank
WHERE Course_Code = @CourseCode
ORDER BY NEWID(); -- Randomize questions

----------------------------------------
CREATE PROCEDURE EnrollStudentInCourse
    @StudentID INT,
    @CourseID INT
AS
BEGIN
    INSERT INTO Student_Course (StudentID, Course_id)
    VALUES (@StudentID, @CourseID);
END;

DENY SELECT, INSERT, UPDATE, DELETE ON Attempted_Quiz TO PUBLIC;
GRANT EXECUTE ON OBJECT::dbo.AttemptQuiz TO Student;

CREATE VIEW StudentProgressView AS
SELECT s.StudentID, s.StudentName, qs.Course_id, qs.Quiz_TotalScore, qs.Obtained_Marks, qs.Progress_Percentage
FROM Student s
JOIN Quiz_Session qs ON s.StudentID = qs.StudentID;
