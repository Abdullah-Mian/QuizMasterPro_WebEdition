-- Create Database
CREATE DATABASE quizmasterpro;
GO
USE quizmasterpro;

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
SELECT Course.Course_Code, Course.Course_Name
FROM Course
    INNER JOIN Student_Course ON Course.Course_id = Student_Course.Course_id
WHERE Student_Course.StudentID = '1'
------------------------------------------------------------------------------------------

GO


CREATE PROCEDURE EnrollStudentWithElevatedPrivileges
    @StudentName NVARCHAR(255),
    @StudentUsername NVARCHAR(255),
    @StudentPassword NVARCHAR(255),
    @DegreeProgram NVARCHAR(255),
    @Courses NVARCHAR(MAX)
WITH
    EXECUTE AS OWNER
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
        INSERT INTO Student
        (StudentName, Username, Deg_Prog)
    VALUES
        (@StudentName, @StudentUsername, @DegreeProgram);
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
        INSERT INTO Student_Course
            (StudentID, Course_id)
        VALUES
            (@StudentID, @CourseID);

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

select *  from student_course
go 
select * from student

SELECT Course.Course_Code, Course.Course_Name, 
              (SELECT COUNT(*) FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = 1) AS AttemptedQuizzes,
              (SELECT Quiz_SessionID, Obtained_Marks, Quiz_TotalScore FROM Quiz_Session WHERE Quiz_Session.Course_id = Course.Course_id AND Quiz_Session.StudentID = 1) AS AttemptedQuizzes
              FROM Course
              WHERE Course.Course_id = 1