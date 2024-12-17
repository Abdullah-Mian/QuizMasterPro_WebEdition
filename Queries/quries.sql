-- Create Database
CREATE DATABASE quizmasterpro;
GO
-- Create login and user for a student
CREATE LOGIN StudentLogin1 WITH PASSWORD = 'SecurePassword123!';
CREATE USER StudentUser1 FOR LOGIN StudentLogin1;
ALTER ROLE Student ADD MEMBER StudentUser1;
GO
-- Create login and user for a student
CREATE LOGIN FA22_BCE_086 WITH PASSWORD = 'Faziy123!';
CREATE USER Faizy FOR LOGIN FA22_BCE_086;
ALTER ROLE Student ADD MEMBER Faizy;

-- Insert data into Student table
INSERT INTO Student
    (StudentName, Username, Deg_Prog)
VALUES
    ('Faizan', 'FA22_BCE_086', 'BSCS');

-- Course Registration for Faizan
INSERT INTO Student_Course
    (StudentID, Course_id)
VALUES
    (8, 1);
INSERT INTO Student_Course
    (StudentID, Course_id)
VALUES
    (8, 2);
INSERT INTO Student_Course
    (StudentID, Course_id)
VALUES
    (8, 3);
GO

-- Create login and user for a student
CREATE LOGIN FA22_BCE_026 WITH PASSWORD = 'Abd123!';
CREATE USER Abd FOR LOGIN FA22_BCE_026;
ALTER ROLE Student ADD MEMBER Abdullah;

-- Insert data into Student table
INSERT INTO Student
    (StudentName, Username, Deg_Prog)
VALUES
    ('Abdullah', 'FA22_BCE_026', 'BCE');

-- Course Registration for Abdullah
INSERT INTO Student_Course
    (StudentID, Course_id)
VALUES
    (5, 4);
INSERT INTO Student_Course
    (StudentID, Course_id)
VALUES
    (5, 5);
INSERT INTO Student_Course
    (StudentID, Course_id)
VALUES
    (5, 6);
GO
-- Create login and user for a student
CREATE LOGIN Theta WITH PASSWORD = 'Theta123!';
CREATE USER Theta FOR LOGIN Theta;
ALTER ROLE Student ADD MEMBER Theta;

-- Insert data into Student table
INSERT INTO Student
    (StudentName, Username, Deg_Prog)
VALUES
    ('Theta', 'Theta', 'BSEE');

-- Course Registration for Theta
INSERT INTO Student_Course
    (StudentID, Course_id)
VALUES
    (10, 10);
INSERT INTO Student_Course
    (StudentID, Course_id)
VALUES
    (10, 11);
INSERT INTO Student_Course
    (StudentID, Course_id)
VALUES
    (10, 12);
GO
-- Create login and user for an SuperAdmin
CREATE LOGIN AdminLogin1 WITH PASSWORD = 'AdminSecurePass!';
CREATE USER AdminUser1 FOR LOGIN AdminLogin1;
ALTER ROLE SuperAdmin ADD MEMBER AdminUser1;
GO
