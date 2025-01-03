-- For Route /randomquizzes
-- Get Random Questions Procedure
CREATE OR ALTER PROCEDURE GetRandomQuestions
    @CourseCode NVARCHAR(50),
    @Limit INT,
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@Limit)
        q.QuestionID, q.Question_String, q.Course_Code
    FROM Question_Bank q
        LEFT JOIN Attempted_Quiz aq ON q.Question_String = aq.Question_String
    WHERE q.Course_Code = @CourseCode
    ORDER BY NEWID();
END;
GO

-- Execute GetRandomQuestions Procedure
EXEC GetRandomQuestions @CourseCode = 'CS101', @Limit = 10, @StudentID = 1;
GO
-------------------------------------------------------------------------------
-- CREATE OR ALTER PROCEDURE GetCourseDetails
--     @StudentID INT,
--     @CourseID INT
-- AS
-- BEGIN
--     SELECT
--         Course.Course_Code,
--         Course.Course_Name,
--         (SELECT COUNT(*)
--         FROM Quiz_Session
--         WHERE Quiz_Session.Course_id = Course.Course_id
--             AND Quiz_Session.StudentID = @StudentID) AS AttemptedQuizzes,
--         (SELECT STRING_AGG(CONCAT(Quiz_SessionID, ',', Obtained_Marks, ',', Quiz_TotalScore, ',', Progress_Percentage, ',', Scholastic_Status), ';')
--         FROM Quiz_Session
--         WHERE Quiz_Session.Course_id = Course.Course_id
--             AND Quiz_Session.StudentID = @StudentID) AS QuizDetails
--     FROM Course
--     WHERE Course.Course_id = @CourseID;
-- END;
-- GO
-------------------------------------------------------------------------------
-- CREATE OR ALTER PROCEDURE GetQuizQuestions
--     @QuizSessionID INT
-- AS
-- BEGIN
--     SELECT
--         aq.Question_String,
--         aq.Actual_Answer,
--         aq.Student_Answer
--     FROM Attempted_Quiz aq
--     WHERE aq.Quiz_SessionID = @QuizSessionID;
-- END;
-- GO
-------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetCourseDetailsWithOptionStrings
    @StudentID INT,
    @CourseID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- First result set: Course details
    SELECT
        Course.Course_Code,
        Course.Course_Name,
        (SELECT COUNT(*)
        FROM Quiz_Session
        WHERE Quiz_Session.Course_id = Course.Course_id
            AND Quiz_Session.StudentID = @StudentID) AS AttemptedQuizzes,
        (SELECT STRING_AGG(CONCAT(Quiz_SessionID, ',', Obtained_Marks, ',', Quiz_TotalScore, ',', Progress_Percentage, ',', Scholastic_Status), ';')
        FROM Quiz_Session
        WHERE Quiz_Session.Course_id = Course.Course_id
            AND Quiz_Session.StudentID = @StudentID) AS QuizDetails
    FROM Course
    WHERE Course.Course_id = @CourseID;

    -- Second result set: Quiz Questions with Option Strings
    SELECT
        aq.Quiz_SessionID,
        aq.Question_String,
        correct_opt.Option_String AS Actual_Answer,
        student_opt.Option_String AS Student_Answer
    FROM Attempted_Quiz aq
        INNER JOIN Quiz_Session qs
        ON aq.Quiz_SessionID = qs.Quiz_SessionID
        LEFT JOIN Option_Bank correct_opt
        ON aq.Actual_Answer  = correct_opt.OptionID
        LEFT JOIN Option_Bank student_opt
        ON aq.Student_Answer = student_opt.OptionID
    WHERE qs.Course_id = @CourseID
        AND qs.StudentID = @StudentID;
END;


Exec  GetCourseDetailsWithOptionStrings @StudentID= 1, @CourseID =1

			  
GO

-------------------------------------------------------------------------------
-- For Route /insertquizsession
-- Insert Quiz Session Procedure
CREATE OR ALTER PROCEDURE InsertQuizSession
    @StudentID INT,
    @CourseID INT,
    @StartTime DATETIME,
    @EndTime DATETIME,
    @TotalMarks INT,
    @ObtainedMarks INT,
    @ProgressPercentage INT,
    @ScholasticStatus NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Quiz_Session
        (StudentID, Course_id, Start_Time, End_Time, Quiz_TotalScore, Obtained_Marks, Progress_Percentage, Scholastic_Status)
    VALUES
        (@StudentID, @CourseID, @StartTime, @EndTime, @TotalMarks, @ObtainedMarks, @ProgressPercentage, @ScholasticStatus);

    SELECT SCOPE_IDENTITY() AS QuizSessionID;
END;
GO

------------------------------------------------------------------------------------------------
-- For Route /insertattemptedquiz
-- Insert Attempted Quiz Procedure
CREATE OR ALTER PROCEDURE InsertAttemptedQuiz
    @QuizSessionID INT,
    @QuestionString1 NVARCHAR(255),
    @StudentAnswer1 NVARCHAR(255),
    @CorrectAnswer1 NVARCHAR(255),
    @QuestionString2 NVARCHAR(255),
    @StudentAnswer2 NVARCHAR(255),
    @CorrectAnswer2 NVARCHAR(255),
    @QuestionString3 NVARCHAR(255),
    @StudentAnswer3 NVARCHAR(255),
    @CorrectAnswer3 NVARCHAR(255),
    @QuestionString4 NVARCHAR(255),
    @StudentAnswer4 NVARCHAR(255),
    @CorrectAnswer4 NVARCHAR(255),
    @QuestionString5 NVARCHAR(255),
    @StudentAnswer5 NVARCHAR(255),
    @CorrectAnswer5 NVARCHAR(255),
    @QuestionString6 NVARCHAR(255),
    @StudentAnswer6 NVARCHAR(255),
    @CorrectAnswer6 NVARCHAR(255),
    @QuestionString7 NVARCHAR(255),
    @StudentAnswer7 NVARCHAR(255),
    @CorrectAnswer7 NVARCHAR(255),
    @QuestionString8 NVARCHAR(255),
    @StudentAnswer8 NVARCHAR(255),
    @CorrectAnswer8 NVARCHAR(255),
    @QuestionString9 NVARCHAR(255),
    @StudentAnswer9 NVARCHAR(255),
    @CorrectAnswer9 NVARCHAR(255),
    @QuestionString10 NVARCHAR(255),
    @StudentAnswer10 NVARCHAR(255),
    @CorrectAnswer10 NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert data into Attempted_Quiz
    INSERT INTO Attempted_Quiz
        (Quiz_SessionID, Question_String, Actual_Answer, Student_Answer, Is_Correct)
    VALUES
        (@QuizSessionID, @QuestionString1, @CorrectAnswer1, @StudentAnswer1, CASE WHEN @StudentAnswer1 = @CorrectAnswer1 THEN 1 ELSE 0 END),
        (@QuizSessionID, @QuestionString2, @CorrectAnswer2, @StudentAnswer2, CASE WHEN @StudentAnswer2 = @CorrectAnswer2 THEN 1 ELSE 0 END),
        (@QuizSessionID, @QuestionString3, @CorrectAnswer3, @StudentAnswer3, CASE WHEN @StudentAnswer3 = @CorrectAnswer3 THEN 1 ELSE 0 END),
        (@QuizSessionID, @QuestionString4, @CorrectAnswer4, @StudentAnswer4, CASE WHEN @StudentAnswer4 = @CorrectAnswer4 THEN 1 ELSE 0 END),
        (@QuizSessionID, @QuestionString5, @CorrectAnswer5, @StudentAnswer5, CASE WHEN @StudentAnswer5 = @CorrectAnswer5 THEN 1 ELSE 0 END),
        (@QuizSessionID, @QuestionString6, @CorrectAnswer6, @StudentAnswer6, CASE WHEN @StudentAnswer6 = @CorrectAnswer6 THEN 1 ELSE 0 END),
        (@QuizSessionID, @QuestionString7, @CorrectAnswer7, @StudentAnswer7, CASE WHEN @StudentAnswer7 = @CorrectAnswer7 THEN 1 ELSE 0 END),
        (@QuizSessionID, @QuestionString8, @CorrectAnswer8, @StudentAnswer8, CASE WHEN @StudentAnswer8 = @CorrectAnswer8 THEN 1 ELSE 0 END),
        (@QuizSessionID, @QuestionString9, @CorrectAnswer9, @StudentAnswer9, CASE WHEN @StudentAnswer9 = @CorrectAnswer9 THEN 1 ELSE 0 END),
        (@QuizSessionID, @QuestionString10, @CorrectAnswer10, @StudentAnswer10, CASE WHEN @StudentAnswer10 = @CorrectAnswer10 THEN 1 ELSE 0 END);

    -- Return a confirmation message
    SELECT 'Insertion into Attempted_Quiz table was successful' AS ConfirmationMessage;
END;
GO

------------------------------------------------------------------------------------------------
-- Create or alter Procedure for fetching all students
CREATE PROCEDURE GetStudentsByDegProg
    @DegProg NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Student
    WHERE Deg_Prog = @DegProg;
END
GO

------------------------------------------------------------------------------------------------
-- For Route /studentcourses
CREATE PROCEDURE GetStudentCourses
    @StudentID INT
AS
BEGIN
    SELECT
        Course.Course_id,
        Course.Course_Code,
        Course.Course_Name,
        (SELECT COUNT(*)
        FROM Quiz_Session
        WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = @StudentID) AS AttemptedQuizzes,
        (SELECT AVG(Progress_Percentage)
        FROM Quiz_Session
        WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = @StudentID) AS Progress_Percentage
    FROM
        Course
        INNER JOIN
        Student_Course ON Course.Course_id = Student_Course.Course_id
    WHERE
         Student_Course.StudentID = @StudentID;
END
 GO

------------------------------------------------------------------------------------------------
-- For Route /coursedetails
CREATE PROCEDURE GetCourseDetails
    @StudentID INT,
    @CourseID INT
AS
BEGIN
    SELECT
        Course.Course_Code,
        Course.Course_Name,
        (SELECT COUNT(*)
        FROM Quiz_Session
        WHERE Quiz_Session.Course_id = Course.Course_id
            AND Quiz_Session.StudentID = @StudentID) AS AttemptedQuizzes,
        (SELECT STRING_AGG(CONCAT(Quiz_SessionID, ',', Obtained_Marks, ',', Quiz_TotalScore), ';')
        FROM Quiz_Session
        WHERE Quiz_Session.Course_id = Course.Course_id
            AND Quiz_Session.StudentID = @StudentID) AS QuizDetails
    FROM
        Course
    WHERE 
        Course.Course_id = @CourseID;
END;
GO
------------------------------------------------------------------------------------------------
-- For Route /correctanswers
CREATE PROCEDURE GetCorrectAnswers
    @QuestionIDs NVARCHAR(MAX)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = 'SELECT QuestionID, CorrectOptionID FROM Answer_Key WHERE QuestionID IN (' + @QuestionIDs + ')';
    EXEC sp_executesql @SQL;
END;
GO
EXEC GetCorrectAnswers @QuestionIDs = '1,2,3,4,5';
GO
------------------------------------- VIEWS ----------------------------------------------------

-- Create or alter view for fetching all courses
CREATE OR ALTER VIEW vw_allCourses
AS
    SELECT *
    FROM Course;
GO
-- Create or alter view for fetching all degree programs
CREATE OR ALTER VIEW vw_allDegreePrograms
AS
    SELECT *
    FROM Deg_Program;

GO


--------------------New Stored Procedure for Enrolling Students---------------------

CREATE PROCEDURE EnrollNewStudent
    @StudentName NVARCHAR(255),
    @StudentUsername NVARCHAR(255),
    @StudentPassword NVARCHAR(255),
    @DegreeProgram NVARCHAR(255),
    @Courses NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
            -- Create login with password
            DECLARE @CreateLogin NVARCHAR(MAX) = 
                N'CREATE LOGIN [' + @StudentUsername + '] WITH PASSWORD = ''' + @StudentPassword + ''', 
                CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF;'
            EXEC sp_executesql @CreateLogin;

            -- Create database user
            DECLARE @CreateUser NVARCHAR(MAX) = 
                N'CREATE USER [' + @StudentUsername + '] FOR LOGIN [' + @StudentUsername + '];'
            EXEC sp_executesql @CreateUser;

            -- Add user to Student role
            DECLARE @AddRole NVARCHAR(MAX) = 
                N'ALTER ROLE Student ADD MEMBER [' + @StudentUsername + '];'
            EXEC sp_executesql @AddRole;

            -- Insert student record
            INSERT INTO Student
        (StudentName, Username, Deg_Prog)
    VALUES
        (@StudentName, @StudentUsername, @DegreeProgram);

            DECLARE @StudentID INT = SCOPE_IDENTITY();

            -- Handle course enrollments
            DECLARE @CourseTable TABLE (CourseID INT);
            INSERT INTO @CourseTable
    SELECT T.C.value('.', 'INT')
    FROM (SELECT CAST(@Courses AS XML) AS CourseXML) AS X
            CROSS APPLY X.CourseXML.nodes('/Courses/CourseID') AS T(C);

            INSERT INTO Student_Course
        (StudentID, Course_id)
    SELECT @StudentID, CourseID
    FROM @CourseTable;

        COMMIT TRANSACTION;
        SELECT 'Success' AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO

-- Example call:
DECLARE @CoursesXML NVARCHAR(MAX) = '<Courses><CourseID>1</CourseID><CourseID>2</CourseID></Courses>';

EXEC EnrollNewStudent
    @StudentName = 'John Doe',
    @StudentUsername = 'john.doe',
    @StudentPassword = 'SecurePass123!',
    @DegreeProgram = 'BSCS',
    @Courses = @CoursesXML;

select *
from student_course
go
select *
from student

SELECT Course.Course_Code, Course.Course_Name,
    (SELECT COUNT(*)
    FROM Quiz_Session
    WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = 1) AS AttemptedQuizzes,
    (SELECT Quiz_SessionID, Obtained_Marks, Quiz_TotalScore
    FROM Quiz_Session
    WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = 1) AS AttemptedQuizzes
FROM Course
WHERE Course.Course_id = 1
                GO

-----------------------------------------Trigger ON Quiz_Session----------------------------------------------
CREATE OR ALTER TRIGGER trig_QuizSession_Record
ON Quiz_Session
FOR INSERT
AS
DECLARE @StudentID INT;
DECLARE @Quiz_SessionID INT;
DECLARE @Quiz_Date DATE;
DECLARE @Scholoastic_Status NVARCHAR(50);
BEGIN

    SELECT @StudentID = StudentID, @Quiz_SessionID = Quiz_SessionID, @Quiz_Date = Quiz_Date
    FROM INSERTED;

    IF @Quiz_Date > GETDATE()
    BEGIN
        RAISERROR('Quiz date cannot be in the future.', 16, 1);
        ROLLBACK TRANSACTION;
    END;

    INSERT INTO OperationLog
        (rollno, operation, performed_by,operation_date, session_id)
    VALUES
        (@StudentID, 'INSERT', SYSTEM_USER, @Quiz_Date , @Quiz_SessionID);
END;