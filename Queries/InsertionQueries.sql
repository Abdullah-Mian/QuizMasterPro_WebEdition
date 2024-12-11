
-- Populate Tables
INSERT INTO Deg_Program
    (Deg_Prog, Deg_Prog_Name)
VALUES
    ('BSCS', 'Bachelor of Science in Computer Science'),
    ('BCE', 'Bachelor of Computer Engineering'),
    ('BSSE', 'Bachelor of Science in Software Engineering'),
    ('BSEE', 'Bachelor of Science in Electrical Engineering'),
    ('BSME', 'Bachelor of Science in Mechanical Engineering'),
    ('BSIT', 'Bachelor of Science in Information Technology'),
    ('BBA', 'Bachelor of Business Administration');
GO

INSERT INTO Course
    (Course_Code, Course_Name, Deg_Prog)
VALUES
    -- Courses for BSCS
    ('CS101', 'Introduction to Programming', 'BSCS'),
    ('CS102', 'Data Structures', 'BSCS'),
    ('CS103', 'Algorithms', 'BSCS'),

    -- Courses for BCE
    ('CE101', 'Digital Logic Design', 'BCE'),
    ('CE102', 'Computer Architecture', 'BCE'),
    ('CE103', 'Embedded Systems', 'BCE'),

    -- Courses for BSSE
    ('SE101', 'Software Design and Architecture', 'BSSE'),
    ('SE102', 'Software Testing', 'BSSE'),
    ('SE103', 'Software Project Management', 'BSSE'),

    -- Courses for BSEE
    ('EE101', 'Circuit Analysis', 'BSEE'),
    ('EE102', 'Electromagnetic Theory', 'BSEE'),
    ('EE103', 'Power Systems', 'BSEE'),

    -- Courses for BSME
    ('ME101', 'Thermodynamics', 'BSME'),
    ('ME102', 'Fluid Mechanics', 'BSME'),
    ('ME103', 'Mechanics of Materials', 'BSME'),

    -- Courses for BSIT
    ('IT101', 'Introduction to Networking', 'BSIT'),
    ('IT102', 'Web Development', 'BSIT'),
    ('IT103', 'Database Management Systems', 'BSIT'),

    -- Courses for BBA
    ('BA101', 'Principles of Management', 'BBA'),
    ('BA102', 'Business Communication', 'BBA'),
    ('BA103', 'Marketing Fundamentals', 'BBA');
GO

INSERT INTO Admins
    (AdminName, Username, AdminRole)
VALUES
    ('Admin1', 'AdminLogin1', 'admin');
GO

INSERT INTO Student
    (StudentName, Username, Deg_Prog)
VALUES
    ('Student1', 'StudentLogin1', 'BSCS');
GO

-- Insert questions into Question_Bank
INSERT INTO Question_Bank (Question_String, Course_Code)
VALUES
    ('What is the output of the following code: System.out.println("Hello World");', 'CS101'),
    ('Which of the following is a valid variable declaration in Java?', 'CS101'),
    ('What is the default value of a boolean variable in Java?', 'CS101'),
    ('Which of the following is not a Java keyword?', 'CS101'),
    ('What is the size of an int variable in Java?', 'CS101');

-- Insert options into Option_Bank
INSERT INTO Option_Bank (QuestionID, Option_String)
VALUES
    -- Options for Question 1
    (1, 'Hello World'),
    (1, 'hello world'),
    (1, 'HELLO WORLD'),
    (1, 'None of the above'),

    -- Options for Question 2
    (2, 'int 1x=10;'),
    (2, 'int x=10;'),
    (2, 'float x=10.0f;'),
    (2, 'string x="10";'),

    -- Options for Question 3
    (3, 'true'),
    (3, 'false'),
    (3, '0'),
    (3, 'null'),

    -- Options for Question 4
    (4, 'class'),
    (4, 'interface'),
    (4, 'extends'),
    (4, 'implement'),

    -- Options for Question 5
    (5, '4 bytes'),
    (5, '8 bytes'),
    (5, '16 bytes'),
    (5, '32 bytes');

-- Insert correct answers into Answer_Key
INSERT INTO Answer_Key (QuestionID, CorrectOptionID)
VALUES
    (1, 1), -- Correct option for Question 1
    (2, 2), -- Correct option for Question 2
    (3, 2), -- Correct option for Question 3
    (4, 4), -- Correct option for Question 4
    (5, 1); -- Correct option for Question 5