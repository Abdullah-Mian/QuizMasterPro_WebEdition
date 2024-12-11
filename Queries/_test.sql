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
EXEC GetRandomQuestions @CourseCode = 'CS101', @Limit = 10, @StudentID = 12345;