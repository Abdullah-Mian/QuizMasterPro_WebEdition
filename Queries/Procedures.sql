CREATE OR ALTER PROCEDURE GetRandomQuestions
    @CourseCode NVARCHAR(50),
    @Limit INT,
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@Limit) q.QuestionID, q.Question_String, q.Course_Code
    FROM Question_Bank q
    LEFT JOIN Attempted_Quiz aq ON q.Question_String = aq.Question_String
    LEFT JOIN Quiz_Session qs ON aq.Quiz_SessionID = qs.Quiz_SessionID
    WHERE q.Course_Code = @CourseCode
    AND (qs.StudentID IS NULL OR qs.StudentID != @StudentID)
    ORDER BY NEWID();
END;
GO
EXEC GetRandomQuestions @CourseCode = 'CS101', @Limit = 10, @StudentID = 1;

-------------------------------------------------------------------------------

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

    INSERT INTO Quiz_Session (StudentID, Course_id, Start_Time, End_Time, Quiz_TotalScore, Obtained_Marks, Progress_Percentage, Scholastic_Status)
    VALUES (@StudentID, @CourseID, @StartTime, @EndTime, @TotalMarks, @ObtainedMarks, @ProgressPercentage, @ScholasticStatus);

    SELECT SCOPE_IDENTITY() AS QuizSessionID;
END;
GO

CREATE OR ALTER PROCEDURE InsertAttemptedQuiz
    @QuizSessionID INT,
    @Questions NVARCHAR(MAX), -- JSON string containing question details
    @Answers NVARCHAR(MAX), -- JSON string containing student answers
    @CorrectAnswers NVARCHAR(MAX) -- JSON string containing correct answers
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @QuestionID INT;
    DECLARE @QuestionString NVARCHAR(255);
    DECLARE @ActualAnswer NVARCHAR(255);
    DECLARE @StudentAnswer NVARCHAR(255);
    DECLARE @IsCorrect BIT;

    DECLARE @QuestionTable TABLE (QuestionID INT, QuestionString NVARCHAR(255));
    INSERT INTO @QuestionTable (QuestionID, QuestionString)
    SELECT QuestionID, QuestionString
    FROM OPENJSON(@Questions)
    WITH (QuestionID INT, QuestionString NVARCHAR(255));

    DECLARE @AnswerTable TABLE (QuestionID INT, SelectedOptionID INT);
    INSERT INTO @AnswerTable (QuestionID, SelectedOptionID)
    SELECT QuestionID, SelectedOptionID
    FROM OPENJSON(@Answers)
    WITH (QuestionID INT, SelectedOptionID INT);

    DECLARE @CorrectAnswerTable TABLE (QuestionID INT, CorrectOptionID INT);
    INSERT INTO @CorrectAnswerTable (QuestionID, CorrectOptionID)
    SELECT QuestionID, CorrectOptionID
    FROM OPENJSON(@CorrectAnswers)
    WITH (QuestionID INT, CorrectOptionID INT);

    DECLARE answer_cursor CURSOR FOR
    SELECT q.QuestionID, q.QuestionString, a.SelectedOptionID, c.CorrectOptionID
    FROM @QuestionTable q
    JOIN @AnswerTable a ON q.QuestionID = a.QuestionID
    JOIN @CorrectAnswerTable c ON q.QuestionID = c.QuestionID;

    OPEN answer_cursor;
    FETCH NEXT FROM answer_cursor INTO @QuestionID, @QuestionString, @StudentAnswer, @ActualAnswer;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @IsCorrect = CASE WHEN @StudentAnswer = @ActualAnswer THEN 1 ELSE 0 END;

        INSERT INTO Attempted_Quiz (Quiz_SessionID, Question_String, Actual_Answer, Student_Answer, Is_Correct)
        VALUES (@QuizSessionID, @QuestionString, (SELECT Option_String FROM Option_Bank WHERE OptionID = @ActualAnswer), (SELECT Option_String FROM Option_Bank WHERE OptionID = @StudentAnswer), @IsCorrect);

        FETCH NEXT FROM answer_cursor INTO @QuestionID, @QuestionString, @StudentAnswer, @ActualAnswer;
    END;

    CLOSE answer_cursor;
    DEALLOCATE answer_cursor;
END;
GO

-------------------------------------------------------------------------------