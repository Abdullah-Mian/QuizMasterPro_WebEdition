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

    -- Parse the JSON strings into table variables
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

    -- Insert data into Attempted_Quiz
    INSERT INTO Attempted_Quiz (Quiz_SessionID, Question_String, Actual_Answer, Student_Answer, Is_Correct)
    SELECT 
        @QuizSessionID,
        q.QuestionString,
        (SELECT Option_String FROM Option_Bank WHERE OptionID = c.CorrectOptionID),
        (SELECT Option_String FROM Option_Bank WHERE OptionID = a.SelectedOptionID),
        CASE WHEN a.SelectedOptionID = c.CorrectOptionID THEN 1 ELSE 0 END
    FROM @QuestionTable q
    JOIN @AnswerTable a ON q.QuestionID = a.QuestionID
    JOIN @CorrectAnswerTable c ON q.QuestionID = c.QuestionID;
END;
GO

GRANT SELECT ON Question_Bank TO Student;
GRANT SELECT ON Option_Bank TO Student;
GRANT SELECT ON Answer_Key TO Student;

select * from Attempted_Quiz

DECLARE @QuizSessionID INT = 5;

DECLARE @Questions NVARCHAR(MAX) = N'[
    {"QuestionID": 1, "QuestionString": "Question 1"},
    {"QuestionID": 3, "QuestionString": "Question 3"},
    {"QuestionID": 4, "QuestionString": "Question 4"},
    {"QuestionID": 9, "QuestionString": "Question 9"},
    {"QuestionID": 10, "QuestionString": "Question 10"},
    {"QuestionID": 11, "QuestionString": "Question 11"},
    {"QuestionID": 12, "QuestionString": "Question 12"},
    {"QuestionID": 13, "QuestionString": "Question 13"},
    {"QuestionID": 15, "QuestionString": "Question 15"},
    {"QuestionID": 17, "QuestionString": "Question 17"}
]';

DECLARE @Answers NVARCHAR(MAX) = N'[
    {"QuestionID": 1, "SelectedOptionID": 1},
    {"QuestionID": 3, "SelectedOptionID": 10},
    {"QuestionID": 4, "SelectedOptionID": 13},
    {"QuestionID": 9, "SelectedOptionID": 35},
    {"QuestionID": 10, "SelectedOptionID": 38},
    {"QuestionID": 11, "SelectedOptionID": 44},
    {"QuestionID": 12, "SelectedOptionID": 47},
    {"QuestionID": 13, "SelectedOptionID": 51},
    {"QuestionID": 15, "SelectedOptionID": 59},
    {"QuestionID": 17, "SelectedOptionID": 67}
]';

DECLARE @CorrectAnswers NVARCHAR(MAX) = N'[
    {"QuestionID": 1, "CorrectOptionID": 1},
    {"QuestionID": 3, "CorrectOptionID": 10},
    {"QuestionID": 4, "CorrectOptionID": 16},
    {"QuestionID": 9, "CorrectOptionID": 4},
    {"QuestionID": 10, "CorrectOptionID": 1},
    {"QuestionID": 11, "CorrectOptionID": 1},
    {"QuestionID": 12, "CorrectOptionID": 1},
    {"QuestionID": 13, "CorrectOptionID": 1},
    {"QuestionID": 15, "CorrectOptionID": 3},
    {"QuestionID": 17, "CorrectOptionID": 1}
]';

EXEC InsertAttemptedQuiz
    @QuizSessionID = @QuizSessionID,
    @Questions = @Questions,
    @Answers = @Answers,
    @CorrectAnswers = @CorrectAnswers;