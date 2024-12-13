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
