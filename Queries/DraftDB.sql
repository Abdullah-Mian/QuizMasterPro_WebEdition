CREATE DATABASE DraftDB;
GO
Use DraftDB;
GO
-- CREATE TABLE Users
-- (
--     UserID INT PRIMARY KEY IDENTITY,
--     UserName NVARCHAR(50),
--     Password NVARCHAR(50) NOT NULL UNIQUE,
--     PasswordHash NVARCHAR(255),
--     Role NVARCHAR(50) NOT NULL
-- );
CREATE TABLE Admins
(
    AdminID INT PRIMARY KEY IDENTITY,
    AdminName NVARCHAR(50),
    -- AdminPassword NVARCHAR(50) NOT NULL UNIQUE,
    -- AdminPasswordHash NVARCHAR(255),
    AdminRole NVARCHAR(50) NOT NULL
);
GO
-- Drop Table Admins;
-- Select *
-- from Admins;

CREATE TABLE Solution_Bank
(
    Solution_Key INT PRIMARY KEY IDENTITY,
    -- SolutionName NVARCHAR(50),
    -- SolutionDescription NVARCHAR(255),
    -- SolutionCode NVARCHAR(255),
    -- SolutionLanguage NVARCHAR(50),
    Option1 NVARCHAR(255),
    Option2 NVARCHAR(255),
    Option3 NVARCHAR(255),
    Option4 NVARCHAR(255),
    -- SolutionDifficulty NVARCHAR(50),
    -- SolutionCategory NVARCHAR(50),
    -- SolutionDate DATE
    Solution_Characters NVARCHAR(255)
);
GO
CREATE TABLE Question_Bank
(
    -- Question_Key INT PRIMARY KEY IDENTITY,
    Course_Code NVARCHAR(50),
    Question_String NVARCHAR(255) PRIMARY KEY,
    Solution_Key INT,
    -- Answer NVARCHAR(255),
);
GO
CREATE TABLE Course
(
    Course_Code NVARCHAR(50) PRIMARY KEY,
    Deg_Prog NVARCHAR(50),
);
GO
CREATE TABLE Deg_Program
(
    Deg_Prog NVARCHAR(50) PRIMARY KEY,
    -- Deg_Prog_Name NVARCHAR(50),
);
GO
CREATE TABLE Student
(
    StudentID INT PRIMARY KEY IDENTITY,
    StudentName NVARCHAR(50),
    -- StudentPassword NVARCHAR(50) NOT NULL UNIQUE,
    -- StudentPasswordHash NVARCHAR(255),
    -- StudentRole NVARCHAR(50) NOT NULL
);
GO
CREATE TABLE Quiz_Session
(
    Quiz_SessionID INT PRIMARY KEY IDENTITY,
    StudentID INT,
    Course_Code NVARCHAR(50),
    -- Quiz_Date DATE,
    -- Quiz_Score INT,
    -- Quiz_Time TIME
);
GO
CREATE TABLE Student_Progress
(
    Quiz_SessionID INT PRIMARY KEY,
    Scholastic_Status NVARCHAR(50),
    Marks INT,
    -- StudentID INT,
    -- Course_Code NVARCHAR(50),
    -- Progress INT,
    -- Progress_Date DATE
);
GO
CREATE TABLE Time_Details
(
    Quiz_SessionID INT PRIMARY KEY IDENTITY,
    Start_Time TIME,
    End_Time TIME,
    -- Time_Stamp DATETIME
);
GO
CREATE TABLE Attempted_Quiz
(
    Quiz_SessionID INT,
    -- StudentID INT,
    -- Course_Code NVARCHAR(50),
    Question_String NVARCHAR(255),
    Actual_Answer NVARCHAR(255),
    Student_Answer NVARCHAR(255),
);
GO