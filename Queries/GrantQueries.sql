
-- Create Roles and Grant Permissions
-- Create roles
CREATE ROLE Student;
CREATE ROLE SuperAdmin;
GO

-- Grant permissions to Student role
GRANT SELECT ON Deg_Program TO Student;
GRANT SELECT ON Course TO Student;
GRANT SELECT ON Question_Bank TO Student;
GRANT SELECT, INSERT, UPDATE ON Attempted_Quiz TO Student;
GRANT SELECT ON Student TO Student;
GRANT SELECT ON Student_Course TO Student;
GRANT SELECT ON Question_Bank TO Student;
GRANT SELECT ON Option_Bank TO Student;
GRANT SELECT ON Answer_Key TO Student;

-- Grant EXECUTE permissions to the Student role for GetCourseDetailsWithOptionStrings procedure
GRANT EXECUTE ON OBJECT::dbo.GetCourseDetailsWithOptionStrings TO Student;
-- Grant EXECUTE permissions to the Student role for GetCorrectAnswers procedure
GRANT EXECUTE ON OBJECT::dbo.GetCourseDetails TO Student;
-- Grant EXECUTE permissions to the Student role for GetCourseDetails procedure
GRANT EXECUTE ON OBJECT::dbo.GetQuizQuestions TO Student;
-- Grant EXECUTE permissions to the Student role for GetCorrectAnswers procedure
GRANT EXECUTE ON OBJECT::dbo.GetCorrectAnswers TO Student;
-- Grant EXECUTE permissions to the Student role for GetCourseDetails procedure
GRANT EXECUTE ON OBJECT::dbo.GetCourseDetails TO Student;
-- Grant EXECUTE permissions to the Student role for GetStudentCourses procedure
GRANT EXECUTE ON OBJECT::dbo.GetStudentCourses TO Student;
-- Grant EXECUTE permissions to the Student role for GetRandomQuestions procedure
GRANT EXECUTE ON OBJECT::GetRandomQuestions TO Student;
-- Grant EXECUTE permissions to the Student role for InsertQuizSession procedure
GRANT EXECUTE ON OBJECT::dbo.InsertQuizSession TO Student;
-- Grant EXECUTE permissions to the Student role for InsertAttemptedQuiz procedure
GRANT EXECUTE ON OBJECT::dbo.InsertAttemptedQuiz TO Student;
-- Grant SELECT permissions to the Student role for required tables
GRANT SELECT ON Question_Bank TO Student;
GRANT SELECT ON Option_Bank TO Student;
GRANT SELECT ON Answer_Key TO Student;
GO

-- Grant permissions to SuperAdmin role
GRANT SELECT, INSERT, UPDATE, DELETE ON Student TO SuperAdmin;
Grant SELECT ON vw_allStudents TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Deg_Program TO SuperAdmin;
GRANT SELECT ON vw_allDegreePrograms TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Course TO SuperAdmin;
GRANT SELECT ON vw_allCourses TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Question_Bank TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Option_Bank TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Answer_Key TO SuperAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Admins TO SuperAdmin;
GRANT EXECUTE ON OBJECT::dbo.EnrollNewStudent TO SuperAdmin;

GRANT CREATE USER TO SuperAdmin;
GRANT ALTER ANY USER TO SuperAdmin;
GRANT ALTER ANY ROLE TO SuperAdmin;
-- Grant select permission on the view to the Student role
GRANT EXECUTE ON OBJECT::dbo.GetStudentsByDegProg TO SuperAdmin;

GRANT CREATE LOGIN TO SuperAdminRole;
