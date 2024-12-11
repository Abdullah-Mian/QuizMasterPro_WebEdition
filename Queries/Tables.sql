-- Table for Degree Program
CREATE TABLE Deg_Program
(
    Deg_Prog NVARCHAR(255) PRIMARY KEY,
    Deg_Prog_Name NVARCHAR(255) UNIQUE
);
GO

-- Table for Admins
CREATE TABLE Admins
(
    AdminID INT PRIMARY KEY IDENTITY,
    AdminName NVARCHAR(255) NOT NULL,
    Username NVARCHAR(255) UNIQUE NOT NULL,
    AdminRole NVARCHAR(255) NOT NULL
);
GO

-- Table for Students
CREATE TABLE Student
(
    StudentID INT PRIMARY KEY IDENTITY,
    StudentName NVARCHAR(255),
    Username NVARCHAR(255) UNIQUE NOT NULL,
    Deg_Prog NVARCHAR(255) NOT NULL,
    FOREIGN KEY (Deg_Prog) REFERENCES Deg_Program(Deg_Prog)
    -- Foreign key constraint
);
GO

-- Table for Courses
CREATE TABLE Course
(
    Course_id INT PRIMARY KEY IDENTITY,
    -- Added IDENTITY for auto-increment
    Course_Code NVARCHAR(255) NOT NULL,
    Course_Name NVARCHAR(255),
    Deg_Prog NVARCHAR(255),
    FOREIGN KEY (Deg_Prog) REFERENCES Deg_Program(Deg_Prog)
    -- Foreign key constraint
);
GO

-- Table for Student-Course Relationship
CREATE TABLE Student_Course
(
    SC_ID INT PRIMARY KEY IDENTITY,
    -- Optional surrogate key
    StudentID INT NOT NULL,
    Course_id INT NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    -- Cascade deletion if a student is removed
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id) ON DELETE CASCADE
    -- Cascade deletion if a course is removed
);

-- Populate Student_Course table
INSERT INTO Student_Course
    (StudentID, Course_id)
SELECT s.StudentID, c.Course_id
FROM Student s
    JOIN Course c ON s.Deg_Prog = c.Deg_Prog;
GO
GO

-- Table for Question Bank
CREATE TABLE Question_Bank
(
    QuestionID INT PRIMARY KEY IDENTITY,
    -- Unique identifier for each question
    Question_String NVARCHAR(255) NOT NULL,
    -- The actual question
    Course_Code NVARCHAR(50) NOT NULL
    -- Links the question to a course
);
GO

-- Table for Option Bank
CREATE TABLE Option_Bank
(
    OptionID INT PRIMARY KEY IDENTITY,
    -- Unique identifier for each option
    QuestionID INT NOT NULL,
    -- Links the option to a specific question
    Option_String NVARCHAR(255) NOT NULL,
    -- The text of the option
    FOREIGN KEY (QuestionID) REFERENCES Question_Bank(QuestionID) ON DELETE CASCADE
    -- Ensures options are deleted with their question
);
GO

-- Table for Answer Key
CREATE TABLE Answer_Key
(
    AnswerID INT PRIMARY KEY IDENTITY,
    -- Unique identifier for the answer
    QuestionID INT NOT NULL,
    -- Links the answer to a specific question
    CorrectOptionID INT NOT NULL,
    -- Points to the correct option in Option_Bank
    FOREIGN KEY (QuestionID) REFERENCES Question_Bank(QuestionID) ON DELETE CASCADE,
    -- Ensures answers are deleted with their question
    FOREIGN KEY (CorrectOptionID) REFERENCES Option_Bank(OptionID)
);
GO

-- Table for Quiz Session
CREATE TABLE Quiz_Session
(
    Quiz_SessionID INT PRIMARY KEY IDENTITY,
    -- Unique ID for each session
    StudentID INT NOT NULL,
    -- Links the session to a student
    Course_id int NOT NULL,
    -- Links the session to a course
    Quiz_Date DATE NOT NULL DEFAULT GETDATE(),
    -- Date when the quiz was taken
    Start_Time TIME NOT NULL,
    -- Time when the quiz started
    End_Time TIME NOT NULL,
    -- Time when the quiz ended
    Quiz_TotalScore INT,
    -- Total score of the quiz
    Obtained_Marks INT,
    -- Total marks earned
    Progress_Percentage INT,
    -- Progress percentage
    Scholastic_Status NVARCHAR(50),
    -- Status (e.g., "Pass", "Fail")
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id) ON DELETE CASCADE
);
GO

-- Table for Attempted Quiz
CREATE TABLE Attempted_Quiz
(
    AttemptID INT PRIMARY KEY IDENTITY,
    -- Unique ID for each attempt
    Quiz_SessionID INT NOT NULL,
    -- Links to the quiz session
    Question_String NVARCHAR(255) NOT NULL,
    -- The actual question text
    Actual_Answer NVARCHAR(255) NOT NULL,
    -- Correct answer to the question
    Student_Answer NVARCHAR(255),
    -- Student's provided answer
    Is_Correct BIT,
    -- Whether the student's answer was correct (1 for true, 0 for false)
    FOREIGN KEY (Quiz_SessionID) REFERENCES Quiz_Session(Quiz_SessionID) ON DELETE CASCADE
);
GO