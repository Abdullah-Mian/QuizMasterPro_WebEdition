
 --------------------------------
 CREATE PROCEDURE GetStudentCourses
     @StudentID INT
 AS
 BEGIN
     SELECT
         Course.Course_id,
         Course.Course_Code,
         Course.Course_Name,
         (SELECT COUNT(*) FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = @StudentID) AS AttemptedQuizzes,
         (SELECT AVG(Progress_Percentage) FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = @StudentID) AS Progress_Percentage
     FROM
         Course
     INNER JOIN
         Student_Course ON Course.Course_id = Student_Course.Course_id
     WHERE
         Student_Course.StudentID = @StudentID;
 END
 GO
--
 GRANT EXECUTE ON PROCEDURE GetStudentCourses TO Student;
 GRANT EXECUTE ON PROCEDURE GetStudentCourses TO SuperAdmin;
-- GO
--
--
-- -------------------------------- Call
 Select * from StudentCoursesView WHERE StudentID = 1
