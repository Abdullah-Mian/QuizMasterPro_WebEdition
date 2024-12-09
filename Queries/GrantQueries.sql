
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

-- Grant SELECT permissions to the Student role
GRANT SELECT ON Question_Bank TO Student;
GRANT SELECT ON Option_Bank TO Student;
GRANT SELECT ON Answer_Key TO Student;

-- Grant EXECUTE permissions to the Student role
GRANT EXECUTE ON OBJECT::GetRandomQuestions TO Student;