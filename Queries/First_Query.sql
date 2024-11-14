# Generating SQL CREATE TABLE statements for the schema

sql_queries = {
    "Admin": """
CREATE TABLE Admin (
    Admin_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Role VARCHAR(255)
);
""",
    "Degree_Program": """
CREATE TABLE Degree_Program (
    DEG_PRG INT PRIMARY KEY
);
""",
    "Course": """
CREATE TABLE Course (
    Course_Code INT PRIMARY KEY,
    DEG_PRG INT
);
""",
    "Student": """
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(255),
    DEG_PRG INT
);
""",
    "Question_Bank": """
CREATE TABLE Question_Bank (
    Course_Code INT,
    Question_String VARCHAR(255),
    Solution_Key VARCHAR(255),
    PRIMARY KEY (Course_Code, Question_String, Solution_Key)
);
""",
    "Solution_Bank": """
CREATE TABLE Solution_Bank (
    Solution_Key VARCHAR(255) PRIMARY KEY,
    Option_1 VARCHAR(255),
    Option_2 VARCHAR(255),
    Option_3 VARCHAR(255),
    Option_4 VARCHAR(255),
    Solution_Character CHAR(1)
);
""",
    "Quiz_Session": """
CREATE TABLE Quiz_Session (
    Session_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_Code INT
);
""",
    "Timestamp": """
CREATE TABLE Timestamp (
    Session_ID INT PRIMARY KEY,
    Start_Time TIMESTAMP,
    End_Time TIMESTAMP
);
""",
    "Student_Progress": """
CREATE TABLE Student_Progress (
    Quiz_ID INT PRIMARY KEY,
    Scholastic_Status VARCHAR(255),
    Marks INT
);
""",
    "Attempted_Quiz": """
CREATE TABLE Attempted_Quiz (
    Session_ID INT,
    Question_String VARCHAR(255),
    Actual_Ans_Character CHAR(1),
    Students_Ans_Character CHAR(1)
);
"""
}
