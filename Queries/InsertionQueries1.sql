
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
    ('What is the correct way to declare a reference variable in C++?', 'CS101'),
    ('Which of the following is not a valid C++ data type?', 'CS101'),
    ('What is the output of the following C++ code snippet: cout << (5 + 3 * 2);', 'CS101'),
    ('Which keyword is used to inherit a class in C++?', 'CS101'),
    ('What does the "new" operator do in C++?', 'CS101'),
    ('Which of the following is a correct syntax for a C++ template function?', 'CS101'),
    ('How is memory allocated when using malloc in C++?', 'CS101'),
    ('Which of the following is used for exception handling in C++?', 'CS101'),
    ('What is the purpose of the "virtual" keyword in C++?', 'CS101'),
    ('Which of the following is not a feature of C++?', 'CS101'),
    ('What is the size of a pointer variable in a 64-bit system?', 'CS101'),
    ('Which C++ standard library is used for input and output operations?', 'CS101'),
    ('What is the correct way to open a file in C++ for reading?', 'CS101'),
    ('Which of the following is the correct way to declare an array of integers in C++?', 'CS101'),
    ('What is the purpose of a destructor in C++?', 'CS101');

    ('What is the time complexity of accessing an element in a std::vector by index?', 'CS102'),
    ('Which of the following is the correct way to declare a pointer to a function returning int?', 'CS102'),
    ('What does the following C++ code output?\n\nstd::cout << sizeof(char) << std::endl;', 'CS102'),
    ('Which keyword is used to prevent a class from being inherited?', 'CS102'),
    ('What is the purpose of the "const" keyword in C++?', 'CS102'),
    ('How do you create a multi-dimensional array in C++?', 'CS102'),
    ('Which of the following is not a valid access specifier in C++?', 'CS102'),
    ('What is the result of the following code snippet?\n\nint a = 5;\na += ++a;', 'CS102'),
    ('Which C++ feature allows a class to inherit properties from multiple classes?', 'CS102'),
    ('What is the correct way to handle exceptions in C++?', 'CS102'),
    ('Which of the following is a move constructor in C++?', 'CS102'),
    ('How can you prevent a header file from being included multiple times?', 'CS102'),
    ('What is the output of the following C++ code?\n\nstd::cout << "Hello" + 2;', 'CS102'),
    ('Which of the following is used to iterate over elements in a std::map?', 'CS102'),
    ('What is the purpose of the "explicit" keyword in C++ constructors?', 'CS102'),
    ('Which standard library container should be used for fast insertion and deletion of elements?', 'CS102'),
    ('What does the "auto" keyword do in C++?', 'CS102'),
    ('How do you declare an abstract class in C++?', 'CS102'),
    ('Which of the following is true about C++ destructors?', 'CS102'),
    ('What is the difference between "struct" and "class" in C++?', 'CS102');

    ('What is the time complexity of the QuickSort algorithm in the average case?', 'CS103'),
    ('Which data structure is primarily used in implementing a breadth-first search?', 'CS103'),
    ('What does the acronym "DP" stand for in algorithms?', 'CS103'),
    ('Which algorithm is used to find the shortest path in a weighted graph?', 'CS103'),
    ('What is the main idea behind the Divide and Conquer strategy?', 'CS103'),
    ('Which of the following is a greedy algorithm?', 'CS103'),
    ('What is the space complexity of the MergeSort algorithm?', 'CS103'),
    ('Which algorithm is optimal for finding the minimum spanning tree?', 'CS103'),
    ('What is the purpose of dynamic programming?', 'CS103'),
    ('Which sorting algorithm has the best worst-case time complexity?', 'CS103'),
    ('What is a topological sort used for?', 'CS103'),
    ('Which algorithm is used for pattern matching in strings?', 'CS103'),
    ('What is the primary difference between BFS and DFS?', 'CS103'),
    ('Which algorithm is inefficient for large datasets due to its high time complexity?', 'CS103'),
    ('What does NP stand for in computational complexity?', 'CS103'),
    ('Which algorithm is used in Huffman coding?', 'CS103'),
    ('What is the purpose of the Bellman-Ford algorithm?', 'CS103'),
    ('Which data structure uses LIFO principle?', 'CS103'),
    ('What is the amortized time complexity of inserting an element into a hash table?', 'CS103'),
    ('Which algorithm is known for its use in Google’s PageRank?', 'CS103');

    ('What is the basic unit of digital logic?', 'CE101'),
    ('What is a truth table used for?', 'CE101'),
    ('Which gate produces an output of true only when both inputs are true?', 'CE101'),
    ('What is the output of a XOR gate when both inputs are true?', 'CE101'),
    ('What is the difference between combinational and sequential logic circuits?', 'CE101'),
    ('What is a flip-flop?', 'CE101'),
    ('Which logic gate is used to implement a half adder?', 'CE101'),
    ('What is the purpose of a multiplexer?', 'CE101'),
    ('What is De Morgan's theorem?', 'CE101'),
    ('What is propagation delay in digital circuits?', 'CE101'),
    ('What is the function of a decoder?', 'CE101'),
    ('What is a binary counter?', 'CE101'),
    ('How many inputs does a 3-to-8 decoder have?', 'CE101'),
    ('What is an encoder in digital logic?', 'CE101'),
    ('What is the role of a register in digital circuits?', 'CE101'),
    ('What is a latch?', 'CE101'),
    ('What is a breadboard used for?', 'CE101'),
    ('What is a programmable logic device?', 'CE101'),
    ('Which gate produces an output of false only when both inputs are true?', 'CE101'),
    ('What is the significance of Karnaugh maps?', 'CE101');

    ('What is the primary function of the Control Unit in a CPU?', 'CE102'),
    ('Which memory hierarchy level is the fastest but most expensive per byte?', 'CE102'),
    ('What does ALU stand for in computer architecture?', 'CE102'),
    ('Which of the following is a CISC-based processor architecture?', 'CE102'),
    ('What is pipelining in CPU architecture?', 'CE102'),
    ('Which component is responsible for executing instructions in a CPU?', 'CE102'),
    ('What is the purpose of cache memory?', 'CE102'),
    ('Which type of memory is non-volatile and used for long-term storage?', 'CE102'),
    ('What does ISA stand for in computer architecture?', 'CE102'),
    ('Which bus is responsible for data transfer between the CPU and memory?', 'CE102'),
    ('What is the main advantage of RISC architectures?', 'CE102'),
    ('Which component manages the flow of data between the CPU and other peripherals?', 'CE102'),
    ('What is virtual memory?', 'CE102'),
    ('Which technique allows multiple instructions to be processed simultaneously?', 'CE102'),
    ('What is the purpose of the motherboard in a computer system?', 'CE102'),
    ('Which type of parallelism is achieved by executing multiple instructions at the same time?', 'CE102'),
    ('What does the term "clock speed" refer to?', 'CE102'),
    ('Which of the following is a secondary storage device?', 'CE102'),
    ('What is the role of the bus in computer architecture?', 'CE102'),
    ('Which architecture is primarily used in smartphones and tablets?', 'CE102');

    ('What is the primary purpose of a microcontroller in an embedded system?', 'CE103'),
    ('Which communication protocol is commonly used in embedded systems for short-distance communication?', 'CE103'),
    ('What does RTOS stand for in the context of embedded systems?', 'CE103'),
    ('In embedded systems, what is the function of an interrupt?', 'CE103'),
    ('Which of the following is a popular programming language for embedded systems?', 'CE103'),
    ('What is the role of a watchdog timer in an embedded system?', 'CE103'),
    ('Which memory type is non-volatile and typically used to store firmware in embedded systems?', 'CE103'),
    ('What is a common use of PWM (Pulse Width Modulation) in embedded systems?', 'CE103'),
    ('In embedded systems design, what does the term \'bare-metal\' refer to?', 'CE103'),
    ('Which peripheral interface is used for high-speed data transfer between an embedded device and external hardware?', 'CE103'),
    ('What is the main advantage of using an RTOS in an embedded system?', 'CE103'),
    ('Which sensor is commonly used in embedded systems for temperature measurement?', 'CE103'),
    ('In embedded systems, what is the purpose of DMA (Direct Memory Access)?', 'CE103'),
    ('What is the primary difference between MCU (Microcontroller Unit) and MPU (Microprocessor Unit)?', 'CE103'),
    ('Which of the following is an example of an embedded operating system?', 'CE103'),
    ('What is the function of GPIO pins in an embedded system?', 'CE103'),
    ('Which tool is commonly used for debugging embedded systems at the hardware level?', 'CE103'),
    ('In embedded systems, what is \'firmware\'?', 'CE103'),
    ('What is the purpose of using an Embedded Development Kit (EDK)?', 'CE103'),
    ('Which of the following power management techniques is commonly used in battery-powered embedded systems?', 'CE103');

    ('What design principle states that a class should have only one reason to change?', 'SE101'),
    ('Which design pattern ensures a class has only one instance and provides a global point of access to it?', 'SE101'),
    ('What architectural pattern separates an application into three main components: Model, View, and Controller?', 'SE101'),
    ('Which design pattern defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified?', 'SE101'),
    ('What is the main purpose of using design patterns in software engineering?', 'SE101'),
    ('Which design pattern provides a way to access the elements of an aggregate object sequentially without exposing its underlying representation?', 'SE101'),
    ('In a Layered Architecture, which layer is responsible for handling business logic?', 'SE101'),
    ('What does the acronym SOLID stand for in software design principles? (List any one)', 'SE101'),
    ('Which design pattern allows you to add new functionality to an existing object without altering its structure?', 'SE101'),
    ('What is the purpose of the Repository pattern in software architecture?', 'SE101'),
    ('Which architectural style emphasizes high cohesion and low coupling among software components?', 'SE101'),
    ('What is the main benefit of using the Dependency Injection pattern?', 'SE101'),
    ('In UML, which diagram is used to represent the dynamic behavior of a system by showing interactions between actors and the system?', 'SE101'),
    ('What is the purpose of the Facade pattern in software design?', 'SE101'),
    ('Which design pattern separates the construction of a complex object from its representation?', 'SE101'),
    ('In software architecture, what does "coupling" refer to?', 'SE101'),
    ('What is the main characteristic of microservices architecture?', 'SE101'),
    ('Which UML diagram is best suited to represent the static structure of a system by showing its classes and relationships?', 'SE101'),
    ('What is the primary goal of the Model-View-ViewModel (MVVM) architectural pattern?', 'SE101'),
    ('In software design, what does "high cohesion" mean?', 'SE101');

    ('What is the primary goal of unit testing?', 'SE102'),
    ('Which testing technique involves testing individual components without considering their interactions?', 'SE102'),
    ('What does the acronym "SIT" stand for in software testing?', 'SE102'),
    ('Which testing type verifies that a system meets the specified requirements?', 'SE102'),
    ('What is the main purpose of regression testing?', 'SE102'),
    ('Which model follows a sequential approach to software testing?', 'SE102'),
    ('What is the key benefit of automated testing?', 'SE102'),
    ('Which of the following is a white-box testing technique?', 'SE102'),
    ('What is exploratory testing?', 'SE102'),
    ('Which document outlines the scope, approach, resources, and schedule of intended test activities?', 'SE102'),
    ('What is the first level of testing where testers validate the functionality of an application?', 'SE102'),
    ('Which type of testing focuses on the user interface and user experience?', 'SE102'),
    ('What is the term for a flaw or fault in software that causes it to produce an incorrect or unexpected result?', 'SE102'),
    ('Which testing phase occurs after integration testing?', 'SE102'),
    ('What is acceptance testing?', 'SE102'),
    ('Which tool is commonly used for defect tracking?', 'SE102'),
    ('What does TDD stand for in software development?', 'SE102'),
    ('Which testing technique is used to estimate the number of defects in a software component?', 'SE102'),
    ('What is boundary value analysis?', 'SE102'),
    ('Which testing method involves testing the software from an end-user perspective?', 'SE102');

    ('What is the primary goal of project scope management?', 'SE103'),
    ('Which document outlines the project objectives and constraints?', 'SE103'),
    ('What methodology emphasizes iterative development and customer collaboration?', 'SE103'),
    ('Which tool is commonly used for project scheduling and tracking?', 'SE103'),
    ('What is the critical path in project management?', 'SE103'),
    ('Which technique is used to identify potential risks in a project?', 'SE103'),
    ('What does the acronym WBS stand for?', 'SE103'),
    ('Which type of chart displays project tasks against time?', 'SE103'),
    ('What is stakeholder analysis?', 'SE103'),
    ('Which process involves assigning resources to project tasks?', 'SE103'),
    ('What is the purpose of a Gantt chart?', 'SE103'),
    ('Which term describes changes to the project scope after approval?', 'SE103'),
    ('What is Earned Value Management used for?', 'SE103'),
    ('Which agile framework focuses on iterative progress through sprints?', 'SE103'),
    ('What is the main difference between Agile and Waterfall methodologies?', 'SE103'),
    ('Which process group involves finalizing all project activities?', 'SE103'),
    ('What is resource leveling?', 'SE103'),
    ('Which document formally authorizes the existence of a project?', 'SE103'),
    ('What is the purpose of a project charter?', 'SE103'),
    ('Which technique facilitates consensus building in project teams?', 'SE103');
    
    ('What is Ohm\'s Law?', 'EE101'),
    ('What is the unit of electrical resistance?', 'EE101'),
    ('Which component is used to store electrical energy in a circuit?', 'EE101'),
    ('What is Kirchhoff\'s Voltage Law?', 'EE101'),
    ('What is the purpose of a transformer in a circuit?', 'EE101'),
    ('Which device is used to measure electrical current?', 'EE101'),
    ('What is a series circuit?', 'EE101'),
    ('What is a parallel circuit?', 'EE101'),
    ('What is the power formula in electrical circuits?', 'EE101'),
    ('Which law explains the relationship between voltage, current, and resistance?', 'EE101'),
    ('What is the function of a capacitor in a circuit?', 'EE101'),
    ('Which component limits the flow of electrical current?', 'EE101'),
    ('What is the difference between AC and DC current?', 'EE101'),
    ('What is a semiconducting material?', 'EE101'),
    ('What is the role of a diode in a circuit?', 'EE101'),
    ('What is the frequency of a standard household AC supply in most countries?', 'EE101'),
    ('What is the purpose of grounding in electrical systems?', 'EE101'),
    ('Which instrument is used to measure voltage?', 'EE101'),
    ('What is inductance?', 'EE101'),
    ('What is the function of an inductor in a circuit?', 'EE101');

    ('What is Faraday\'s Law of Electromagnetic Induction?', 'EE102'),
    ('What does Gauss\'s Law state in electromagnetism?', 'EE102'),
    ('What is the unit of magnetic flux?', 'EE102'),
    ('What is Lenz\'s Law?', 'EE102'),
    ('What is the principle of superposition in electromagnetism?', 'EE102'),
    ('What is Maxwell\'s third equation in electromagnetism?', 'EE102'),
    ('How does a transformer work?', 'EE102'),
    ('What is displacement current in Maxwell\'s equations?', 'EE102'),
    ('What is the skin effect?', 'EE102'),
    ('What defines the wavelength of an electromagnetic wave?', 'EE102'),
    ('What is the role of permittivity in a medium?', 'EE102'),
    ('What is the primary function of a capacitor in a circuit?', 'EE102'),
    ('What is inductance?', 'EE102'),
    ('How is capacitance calculated for a parallel plate capacitor?', 'EE102'),
    ('What is the frequency of a standard household AC supply in most countries?', 'EE102'),
    ('What is the purpose of grounding in electrical systems?', 'EE102'),
    ('What is the main difference between static and dynamic magnetic fields?', 'EE102'),
    ('What is the relationship between electric field and electric potential?', 'EE102'),
    ('What is the purpose of Maxwell\'s displacement current?', 'EE102'),
    ('How does electromagnetic wave propagation occur?', 'EE102');

    ('What is the primary function of a power transformer?', 'EE103'),
    ('What is the unit of electrical power?', 'EE103'),
    ('What is the purpose of a circuit breaker in a power system?', 'EE103'),
    ('What is the difference between a generator and a motor?', 'EE103'),
    ('What is reactive power in an AC circuit?', 'EE103'),
    ('What is the function of a relay in a power system?', 'EE103'),
    ('What is the purpose of a transmission line?', 'EE103'),
    ('What is the power factor in an electrical system?', 'EE103'),
    ('What is the significance of the load factor in power systems?', 'EE103'),
    ('What is the role of a capacitor bank in a power system?', 'EE103'),
    ('What is the difference between single-phase and three-phase power?', 'EE103'),
    ('What is the purpose of grounding in power systems?', 'EE103'),
    ('What is the function of a synchronous condenser?', 'EE103'),
    ('What is the main advantage of using high voltage for power transmission?', 'EE103'),
    ('What is the purpose of a substation in a power system?', 'EE103'),
    ('What is the difference between AC and DC transmission?', 'EE103'),
    ('What is the role of a voltage regulator in a power system?', 'EE103'),
    ('What is the purpose of a load flow study in power systems?', 'EE103'),
    ('What is the function of a surge arrester?', 'EE103'),
    ('What is the significance of the per-unit system in power system analysis?', 'EE103');

    ('What is the first law of thermodynamics?', 'ME101'),
    ('What is the unit of entropy?', 'ME101'),
    ('What is the definition of enthalpy?', 'ME101'),
    ('What is the second law of thermodynamics?', 'ME101'),
    ('What is a Carnot engine?', 'ME101'),
    ('What is the definition of specific heat capacity?', 'ME101'),
    ('What is an isothermal process?', 'ME101'),
    ('What is the definition of thermal efficiency?', 'ME101'),
    ('What is the purpose of a heat exchanger?', 'ME101'),
    ('What is the definition of a closed system in thermodynamics?', 'ME101'),
    ('What is the difference between heat and temperature?', 'ME101'),
    ('What is the definition of a reversible process?', 'ME101'),
    ('What is the third law of thermodynamics?', 'ME101'),
    ('What is the definition of a heat pump?', 'ME101'),
    ('What is the purpose of a refrigeration cycle?', 'ME101'),
    ('What is the definition of a control volume?', 'ME101'),
    ('What is the difference between conduction and convection?', 'ME101'),
    ('What is the definition of a polytropic process?', 'ME101'),
    ('What is the purpose of a steam turbine?', 'ME101'),
    ('What is the definition of a phase change?', 'ME101');

    ('What is the definition of fluid mechanics?', 'ME102'),
    ('What is the difference between laminar and turbulent flow?', 'ME102'),
    ('What is the continuity equation in fluid mechanics?', 'ME102'),
    ('What is Bernoulli\'s principle?', 'ME102'),
    ('What is the unit of viscosity?', 'ME102'),
    ('What is Reynolds number?', 'ME102'),
    ('What is the purpose of a manometer?', 'ME102'),
    ('What is the definition of specific gravity?', 'ME102'),
    ('What is the function of a venturi meter?', 'ME102'),
    ('What is the difference between absolute and gauge pressure?', 'ME102'),
    ('What is the Navier-Stokes equation?', 'ME102'),
    ('What is the purpose of a hydraulic pump?', 'ME102'),
    ('What is the definition of flow rate?', 'ME102'),
    ('What is Pascal\'s law?', 'ME102'),
    ('What is the purpose of a hydraulic accumulator?', 'ME102'),
    ('What is the definition of buoyancy?', 'ME102'),
    ('What is the function of a centrifugal pump?', 'ME102'),
    ('What is the difference between a fluid and a solid?', 'ME102'),
    ('What is the purpose of a pitot tube?', 'ME102'),
    ('What is the definition of a streamline?', 'ME102');

    ('What is the definition of stress in mechanics of materials?', 'ME103'),
    ('What is the unit of stress?', 'ME103'),
    ('What is the definition of strain?', 'ME103'),
    ('What is Hooke\'s Law?', 'ME103'),
    ('What is the difference between elastic and plastic deformation?', 'ME103'),
    ('What is Young\'s modulus?', 'ME103'),
    ('What is the definition of shear stress?', 'ME103'),
    ('What is Poisson\'s ratio?', 'ME103'),
    ('What is the purpose of a stress-strain curve?', 'ME103'),
    ('What is the definition of yield strength?', 'ME103'),
    ('What is the difference between brittle and ductile materials?', 'ME103'),
    ('What is the definition of ultimate tensile strength?', 'ME103'),
    ('What is the purpose of a factor of safety?', 'ME103'),
    ('What is the definition of fatigue in materials?', 'ME103'),
    ('What is the difference between hardness and toughness?', 'ME103'),
    ('What is the definition of creep in materials?', 'ME103'),
    ('What is the purpose of a torsion test?', 'ME103'),
    ('What is the definition of bending moment?', 'ME103'),
    ('What is the difference between a simply supported beam and a cantilever beam?', 'ME103'),
    ('What is the purpose of a Mohr\'s circle?', 'ME103');


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

    -- Question 6
    (6, 'int& ref = var;'),
    (6, 'int *ref = &var;'),
    (6, 'int ref = var;'),
    (6, 'int ref& = var;'),

    -- Question 7
    (7, 'int, float, double'),
    (7, 'int, float, string'),
    (7, 'int, float, boolean'),
    (7, 'int, float, vector'),

    -- Question 8
    (8, '11'),
    (8, '16'),
    (8, '11'),
    (8, '10'),

    -- Question 9
    (9, 'public'),
    (9, 'private'),
    (9, 'protected'),
    (9, 'inherit'),

    -- Question 10
    (10, 'Allocate memory for an object'),
    (10, 'Delete memory allocated for an object'),
    (10, 'Create a new class instance'),
    (10, 'Initialize member variables'),

    -- Question 11
    (11, 'template<typename T> T add(T a, T b) { return a + b; }'),
    (11, 'function<T> add(T a, T b) { return a + b; }'),
    (11, 'template function add(T a, T b) { return a + b; }'),
    (11, 'template add(T a, T b) { return a + b; }'),

    -- Question 12
    (12, 'Heap memory'),
    (12, 'Stack memory'),
    (12, 'Global memory'),
    (12, 'Register memory'),

    -- Question 13
    (13, 'try and catch'),
    (13, 'if and else'),
    (13, 'for and while'),
    (13, 'switch and case'),

    -- Question 14
    (14, 'Enables polymorphism'),
    (14, 'Allocates memory dynamically'),
    (14, 'Handles exceptions'),
    (14, 'Overloads operators'),

    -- Question 15
    (15, 'Multiple inheritance'),
    (15, 'Encapsulation'),
    (15, 'Garbage collection'),
    (15, 'Templates'),

    -- Question 16
    (16, '8 bytes'),
    (16, '4 bytes'),
    (16, '2 bytes'),
    (16, '16 bytes'),

    -- Question 17
    (17, '<iostream>'),
    (17, '<fstream>'),
    (17, '<cstdlib>'),
    (17, '<cstring>'),

    -- Question 18
    (18, 'ifstream file("data.txt");'),
    (18, 'ofstream file("data.txt");'),
    (18, 'file.open("data.txt");'),
    (18, 'file.read("data.txt");'),

    -- Question 19
    (19, 'int arr[5];'),
    (19, 'int arr(5);'),
    (19, 'int arr = {5};'),
    (19, 'int arr{5};'),

    -- Question 20
    (20, 'To release resources before the object is destroyed'),
    (20, 'To allocate memory dynamically'),
    (20, 'To initialize member variables'),
    (20, 'To handle exceptions');

    -- Question 21
    (21, 'O(1)'),
    (21, 'O(n)'),
    (21, 'O(log n)'),
    (21, 'O(n log n)'),

    -- Question 22
    (22, 'int (*fptr)()'),
    (22, 'int *fptr()'),
    (22, 'int fptr*()'),
    (22, 'int (*fptr)'),

    -- Question 23
    (23, '1'),
    (23, '2'),
    (23, '4'),
    (23, 'Depends on the compiler'),

    -- Question 24
    (24, 'final'),
    (24, 'sealed'),
    (24, 'restrict'),
    (24, 'immutable'),

    -- Question 25
    (25, 'To make a variable immutable'),
    (25, 'To allow function overloading'),
    (25, 'To enable operator overloading'),
    (25, 'To define constant expressions'),

    -- Question 26
    (26, 'int arr[3][4];'),
    (26, 'int arr(3,4);'),
    (26, 'int arr{3,4};'),
    (26, 'int arr[[3][4]];'),

    -- Question 27
    (27, 'public'),
    (27, 'private'),
    (27, 'protected'),
    (27, 'friend'),

    -- Question 28
    (28, 'Undefined behavior'),
    (28, 'Compilation error'),
    (28, 'Output: 55'),
    (28, 'Output: 10'),

    -- Question 29
    (29, 'Multiple Inheritance'),
    (29, 'Single Inheritance'),
    (29, 'Hybrid Inheritance'),
    (29, 'Virtual Inheritance'),

    -- Question 30
    (30, 'try { } catch(...) { }'),
    (30, 'if (error) { } else { }'),
    (30, 'for(auto it) { }'),
    (30, 'switch(exception) { }'),

    -- Question 31
    (31, 'ClassName(ClassName&&) noexcept'),
    (31, 'ClassName(const ClassName&)'),
    (31, 'ClassName()'),
    (31, 'void operator=(const ClassName&)'),

    -- Question 32
    (32, '#pragma once'),
    (32, '#include "header.h"'),
    (32, '#define HEADER_H'),
    (32, '#ifndef HEADER_H'),

    -- Question 33
    (33, 'lo'),
    (33, 'ell'),
    (33, 'No valid operation'),
    (33, 'Compilation error'),

    -- Question 34
    (34, 'Iterator'),
    (34, 'Pointer'),
    (34, 'Key-value pair'),
    (34, 'Reference'),

    -- Question 35
    (35, 'Prevents implicit conversions'),
    (35, 'Enables multiple constructors'),
    (35, 'Allows operator overloading'),
    (35, 'Facilitates inheritance'),

    -- Question 36
    (36, 'std::list'),
    (36, 'std::vector'),
    (36, 'std::deque'),
    (36, 'std::map'),

    -- Question 37
    (37, 'Automatically deduces the type of the variable'),
    (37, 'Defines a new data type'),
    (37, 'Creates a pointer'),
    (37, 'Allocates memory on the heap'),

    -- Question 38
    (38, 'A class with at least one pure virtual function'),
    (38, 'A class with only public members'),
    (38, 'A class that cannot be instantiated'),
    (38, 'A class with a virtual destructor'),

    -- Question 39
    (39, 'Destructors cannot be overloaded'),
    (39, 'Destructors must be virtual'),
    (39, 'Destructors are inherited'),
    (39, 'Destructors can return values'),

    -- Question 40
    (40, 'There is no difference'),
    (40, 'struct members are public by default, class members are private by default'),
    (40, 'struct cannot have member functions, class can'),
    (40, 'class supports inheritance, struct does not');

    -- Question 41
    (41, 'O(n log n)', 'O(n)', 'O(n²)', 'O(log n)'),
    
    -- Question 42
    (42, 'Queue', 'Stack', 'Priority Queue', 'Tree'),
    
    -- Question 43
    (43, 'Dynamic Programming', 'Divide and Conquer', 'Depth-First Search', 'Dijkstra’s Procedure'),
    
    -- Question 44
    (44, 'Dijkstra\'s Algorithm', 'Kruskal’s Algorithm', 'Prim’s Algorithm', 'Bellman-Ford Algorithm'),
    
    -- Question 45
    (45, 'Breaking the problem into smaller subproblems', 'Using recursion to solve subproblems independently', 'Iteratively solving subproblems', 'Storing the results of subproblems'),
    
    -- Question 46
    (46, 'Dijkstra’s Algorithm', 'Kruskal’s Algorithm', 'Prim’s Algorithm', 'Huffman’s Algorithm'),
    
    -- Question 47
    (47, 'O(n)', 'O(n log n)', 'O(n²)', 'O(log n)'),
    
    -- Question 48
    (48, 'Dijkstra’s Algorithm', 'Kruskal’s Algorithm', 'Prim’s Algorithm', 'Bellman-Ford Algorithm'),
    
    -- Question 49
    (49, 'To solve problems by breaking them down into simpler subproblems and storing their solutions', 'To traverse graphs efficiently', 'To sort data in linear time', 'To manage memory allocation'),
    
    -- Question 50
    (50, 'Merge Sort', 'Bubble Sort', 'Selection Sort', 'Insertion Sort'),
    
    -- Question 51
    (51, 'Ordering tasks based on dependencies', 'Sorting elements in ascending order', 'Searching for elements in a graph', 'Balancing binary trees'),
    
    -- Question 52
    (52, 'Knuth-Morris-Pratt Algorithm', 'Bubble Sort', 'QuickSort', 'Dijkstra’s Algorithm'),
    
    -- Question 53
    (53, 'BFS explores neighbors level by level, while DFS explores as far as possible along each branch', 'DFS explores neighbors level by level, while BFS explores as far as possible along each branch', 'BFS uses a stack, while DFS uses a queue', 'BFS and DFS are identical in approach'),
    
    -- Question 54
    (54, 'Bubble Sort', 'QuickSort', 'Merge Sort', 'Heap Sort'),
    
    -- Question 55
    (55, 'Nondeterministic Polynomial time', 'Non-deterministic Polynomial time', 'Nondeterministic Proportional time', 'Non-probabilistic Polynomial time'),
    
    -- Question 56
    (56, 'Greedy algorithm', 'Dynamic programming', 'Backtracking', 'Branch and bound'),
    
    -- Question 57
    (57, 'Finding shortest paths from a single source', 'Finding all-pairs shortest paths', 'Finding a minimum spanning tree', 'Sorting elements efficiently'),
    
    -- Question 58
    (58, 'Stack', 'Queue', 'Heap', 'Graph'),
    
    -- Question 59
    (59, 'O(1)', 'O(n)', 'O(n log n)', 'O(n²)'),
    
    -- Question 60
    (60, 'PageRank Algorithm', 'Dijkstra’s Algorithm', 'A* Search Algorithm', 'Kruskal’s Algorithm');

    -- Question61
    (61, 'Bit'),
    (61, 'Byte'),
    (61, 'Nibble'),
    (61, 'Word'),

    -- Question62
    (62, 'To represent the output of a logic circuit for all possible input combinations'),
    (62, 'To design sequential circuits'),
    (62, 'To store binary data'),
    (62, 'To perform arithmetic operations'),

    -- Question63
    (63, 'AND Gate'),
    (63, 'OR Gate'),
    (63, 'NOT Gate'),
    (63, 'NAND Gate'),

    -- Question64
    (64, '0'),
    (64, '1'),
    (64, 'Undefined'),
    (64, 'Depends on the inputs'),

    -- Question65
    (65, 'Combinational circuits have memory, sequential circuits do not'),
    (65, 'Sequential circuits have memory, combinational circuits do not'),
    (65, 'Both have memory'),
    (65, 'Neither have memory'),

    -- Question66
    (66, 'A basic memory element'),
    (66, 'A type of gate'),
    (66, 'A type of flip-flop'),
    (66, 'A logic circuit'),

    -- Question67
    (67, 'OR Gate'),
    (67, 'AND Gate'),
    (67, 'XOR Gate'),
    (67, 'NAND Gate'),

    -- Question68
    (68, 'Selects one of many inputs based on control signals'),
    (68, 'Amplifies the signal'),
    (68, 'Converts analog signals to digital'),
    (68, 'Stores data'),

    -- Question69
    (69, 'Transforms ANDs into ORs and vice versa'),
    (69, 'Simplifies complex logic expressions'),
    (69, 'Creates flip-flops'),
    (69, 'Implements arithmetic operations'),

    -- Question70
    (70, 'Time taken for a signal to propagate through a circuit'),
    (70, 'Time taken to reset a circuit'),
    (70, 'Time taken for a flip-flop to toggle'),
    (70, 'Time taken to power on a circuit'),

    -- Question71
    (71, 'Converts binary data into decimal'),
    (71, 'Converts encoded signals into readable data'),
    (71, 'Decodes binary inputs into active-high signals'),
    (71, 'Replicates binary data'),

    -- Question72
    (72, 'Counts in binary for a set number of states'),
    (72, 'Counts selectively based on inputs'),
    (72, 'Counts in hexadecimal'),
    (72, 'Counts analog signals'),

    -- Question73
    (73, '3'),
    (73, '2'),
    (73, '4'),
    (73, '1'),

    -- Question74
    (74, 'Converts multiple inputs into a binary code'),
    (74, 'Encodes binary inputs into multiple outputs'),
    (74, 'Replicates binary data'),
    (74, 'Converts decimal to binary'),

    -- Question75
    (75, 'Stores binary data'),
    (75, 'Performs arithmetic operations'),
    (75, 'Controls the data flow'),
    (75, 'Implements storage elements'),

    -- Question76
    (76, 'A basic storage device'),
    (76, 'A volatile memory element'),
    (76, 'A type of combinational circuit'),
    (76, 'A type of sequential circuit'),

    -- Question77
    (77, 'To prototype and test circuits without soldering'),
    (77, 'To store large amounts of data'),
    (77, 'To amplify signals'),
    (77, 'To convert analog to digital signals'),

    -- Question78
    (78, 'A device that can be programmed to perform specific logic functions'),
    (78, 'A device that stores data'),
    (78, 'A device that converts analog signals to digital'),
    (78, 'A device that measures electrical parameters'),

    -- Question79
    (79, 'NOR Gate'),
    (79, 'XNOR Gate'),
    (79, 'AND Gate'),
    (79, 'OR Gate'),

    -- Question80
    (80, 'Simplifies the design of combinational circuits'),
    (80, 'Used for designing sequential circuits'),
    (80, 'Optimizes sequential logic'),
    (80, 'Represents state diagrams');

    -- Question81
    (81, 'To perform arithmetic operations'),
    (81, 'To direct the operation of the processor'),
    (81, 'To store data temporarily'),
    (81, 'To manage input and output operations'),

    -- Question82
    (82, 'Cache memory'),
    (82, 'Main memory (RAM)'),
    (82, 'Secondary storage (SSD)'),
    (82, 'Tertiary storage (Tape)'),

    -- Question83
    (83, 'Arithmetic Logic Unit'),
    (83, 'Application Link Unit'),
    (83, 'Auxiliary Logic Unit'),
    (83, 'Arithmetic Link Updater'),

    -- Question84
    (84, 'ARM'),
    (84, 'MIPS'),
    (84, 'x86'),
    (84, 'SPARC'),

    -- Question85
    (85, 'A technique to increase CPU clock speed'),
    (85, 'Breaking down instructions into stages'),
    (85, 'Combining multiple instructions into one'),
    (85, 'Separating data and instructions'),

    -- Question86
    (86, 'Control Unit'),
    (86, 'Arithmetic Logic Unit'),
    (86, 'Register File'),
    (86, 'Memory Management Unit'),

    -- Question87
    (87, 'To increase the speed of data access'),
    (87, 'To store large amounts of data permanently'),
    (87, 'To execute arithmetic operations'),
    (87, 'To manage power supply'),

    -- Question88
    (88, 'Hard Disk Drive'),
    (88, 'RAM'),
    (88, 'Cache'),
    (88, 'Registers'),

    -- Question89
    (89, 'Instruction Set Architecture'),
    (89, 'Integration Services Architecture'),
    (89, 'Internal System Architecture'),
    (89, 'Interface Standard Architecture'),

    -- Question90
    (90, 'System Bus'),
    (90, 'Address Bus'),
    (90, 'Data Bus'),
    (90, 'Control Bus'),

    -- Question91
    (91, 'Higher clock speeds'),
    (91, 'Simpler instructions'),
    (91, 'More complex instructions'),
    (91, 'Larger cache memory'),

    -- Question92
    (92, 'Memory Controller'),
    (92, 'Power Supply Unit'),
    (92, 'Graphics Processing Unit'),
    (92, 'Sound Card'),

    -- Question93
    (93, 'A memory management technique that uses disk storage as additional RAM'),
    (93, 'A type of fast cache memory'),
    (93, 'A non-volatile storage for booting the OS'),
    (93, 'A graphics rendering process'),

    -- Question94
    (94, 'Superscalar execution'),
    (94, 'Multithreading'),
    (94, 'Vector processing'),
    (94, 'Speculative execution'),

    -- Question95
    (95, 'The speed at which the CPU can execute instructions'),
    (95, 'The rate at which data moves across the system bus'),
    (95, 'The frequency of the motherboard’s chipset'),
    (95, 'The voltage supplied to the CPU'),

    -- Question96
    (96, 'Solid State Drive'),
    (96, 'Random Access Memory'),
    (96, 'Cache Memory'),
    (96, 'Registers'),

    -- Question97
    (97, 'To transmit data between the CPU and peripheral devices'),
    (97, 'To regulate the power supply'),
    (97, 'To cool the CPU'),
    (97, 'To provide storage space'),

    -- Question98
    (98, 'ARM architecture'),
    (98, 'x86 architecture'),
    (98, 'MIPS architecture'),
    (98, 'PowerPC architecture'),

    -- Question99
    (99, 'Data Bus'),
    (99, 'Address Bus'),
    (99, 'Control Bus'),
    (99, 'Expansion Bus'),

    -- Question100
    (100, 'x86 Architecture'),
    (100, 'ARM Architecture'),
    (100, 'MIPS Architecture'),
    (100, 'Power Architecture');

    -- Question101
    (101, 'To provide user interface capabilities'),
    (101, 'To execute control tasks within the system'),
    (101, 'To store large amounts of data'),
    (101, 'To handle network communications'),
    
    -- Question102
    (102, 'HTTP'),
    (102, 'UART'),
    (102, 'FTP'),
    (102, 'SMTP'),
    
    -- Question103
    (103, 'Real-Time Operating System'),
    (103, 'Reliable Transfer of Services'),
    (103, 'Remote Terminal Operating System'),
    (103, 'Randomized Token Operating System'),
    
    -- Question104
    (104, 'To synchronize data storage'),
    (104, 'To handle asynchronous events promptly'),
    (104, 'To manage power distribution'),
    (104, 'To allocate memory for processes'),
    
    -- Question105
    (105, 'Python'),
    (105, 'C'),
    (105, 'JavaScript'),
    (105, 'Ruby'),
    
    -- Question106
    (106, 'To monitor system performance for logging'),
    (106, 'To reset the system in case of software malfunctions'),
    (106, 'To control peripheral devices'),
    (106, 'To allocate memory for processes'),
    
    -- Question107
    (107, 'RAM'),
    (107, 'ROM'),
    (107, 'Cache'),
    (107, 'Virtual Memory'),
    
    -- Question108
    (108, 'Data encryption'),
    (108, 'Motor speed control'),
    (108, 'Signal modulation for communication'),
    (108, 'Error detection'),
    
    -- Question109
    (109, 'Systems without an operating system'),
    (109, 'Systems with high-level languages'),
    (109, 'Systems using virtual machines'),
    (109, 'Systems with advanced graphical interfaces'),
    
    -- Question110
    (110, 'I2C'),
    (110, 'SPI'),
    (110, 'UART'),
    (110, 'GPIO'),
    
    -- Question111
    (111, 'Enhanced security features'),
    (111, 'Predictable task scheduling and real-time response'),
    (111, 'Increased memory capacity'),
    (111, 'Simplified user interface management'),
    
    -- Question112
    (112, 'Accelerometer'),
    (112, 'Gyroscope'),
    (112, 'Thermistor'),
    (112, 'Ultrasonic sensor'),
    
    -- Question113
    (113, 'To allow peripherals to access system memory without CPU intervention'),
    (113, 'To encrypt data in memory'),
    (113, 'To manage power states of the system'),
    (113, 'To prioritize task execution in the RTOS'),
    
    -- Question114
    (114, 'MCUs are used in server applications, while MPUs are for embedded systems.'),
    (114, 'MCUs integrate peripherals and memory on a single chip, MPUs require external components.'),
    (114, 'MPUs have built-in networking capabilities, MCUs do not.'),
    (114, 'There is no significant difference.'),
    
    -- Question115
    (115, 'Windows 10'),
    (115, 'Linux'),
    (115, 'FreeRTOS'),
    (115, 'macOS'),
    
    -- Question116
    (116, 'To provide data storage'),
    (116, 'To manage power supply'),
    (116, 'To enable general-purpose input and output operations'),
    (116, 'To handle audio processing'),
    
    -- Question117
    (117, 'Logic Analyzer'),
    (117, 'Text Editor'),
    (117, 'Web Browser'),
    (117, 'Spreadsheet Software'),
    
    -- Question118
    (118, 'Software permanently stored on hardware, controlling device functions'),
    (118, 'Hardware components of the system'),
    (118, 'User interface applications'),
    (118, 'Network protocols used by the device'),
    
    -- Question119
    (119, 'To provide end-users with device manuals'),
    (119, 'To offer hardware and software tools for developing embedded applications'),
    (119, 'To manage cloud services'),
    (119, 'To secure network connections'),
    
    -- Question120
    (120, 'Overclocking'),
    (120, 'Dynamic Voltage Scaling'),
    (120, 'High-frequency data processing'),
    (120, 'Continuous active state operation');

    -- Question121
    (121, 'Open/Closed Principle'),
    (121, 'Single Responsibility Principle'),
    (121, 'Liskov Substitution Principle'),
    (121, 'Interface Segregation Principle'),

    -- Question122
    (122, 'Factory Pattern'),
    (122, 'Singleton Pattern'),
    (122, 'Observer Pattern'),
    (122, 'Strategy Pattern'),

    -- Question123
    (123, 'MVC'),
    (123, 'MVVM'),
    (123, 'MVP'),
    (123, 'Layered Architecture'),

    -- Question124
    (124, 'Decorator Pattern'),
    (124, 'Adapter Pattern'),
    (124, 'Observer Pattern'),
    (124, 'Proxy Pattern'),

    -- Question125
    (125, 'To write code faster'),
    (125, 'To provide reusable solutions to common problems'),
    (125, 'To ensure code security'),
    (125, 'To optimize code performance'),

    -- Question126
    (126, 'Iterator Pattern'),
    (126, 'Composite Pattern'),
    (126, 'Facade Pattern'),
    (126, 'Bridge Pattern'),

    -- Question127
    (127, 'Presentation Layer'),
    (127, 'Data Access Layer'),
    (127, 'Business Logic Layer'),
    (127, 'Database Layer'),

    -- Question128
    (128, 'Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion'),
    (128, 'Secure, Open, Lightweight, Integrated, Dynamic'),
    (128, 'Simple, Object-Oriented, Layered, Integrated, Distributed'),
    (128, 'None of the above'),

    -- Question129
    (129, 'Decorator Pattern'),
    (129, 'Singleton Pattern'),
    (129, 'Factory Pattern'),
    (129, 'Builder Pattern'),

    -- Question130
    (130, 'To handle user authentication'),
    (130, 'To abstract the data layer, providing a collection-like interface'),
    (130, 'To manage application configuration'),
    (130, 'To implement caching mechanisms'),

    -- Question131
    (131, 'Microservices Architecture'),
    (131, 'Monolithic Architecture'),
    (131, 'Layered Architecture'),
    (131, 'Service-Oriented Architecture'),

    -- Question132
    (132, 'Improved application performance'),
    (132, 'Enhanced security'),
    (132, 'Increased testability and decoupling of components'),
    (132, 'Simplified database interactions'),

    -- Question133
    (133, 'Use Case Diagram'),
    (133, 'Sequence Diagram'),
    (133, 'Class Diagram'),
    (133, 'Activity Diagram'),

    -- Question134
    (134, 'To hide the complexities of a system and provide a simplified interface'),
    (134, 'To create a family of related objects'),
    (134, 'To allow for interchangeable algorithms'),
    (134, 'To define a one-to-many relationship'),

    -- Question135
    (135, 'Builder Pattern'),
    (135, 'Prototype Pattern'),
    (135, 'Adapter Pattern'),
    (135, 'Bridge Pattern'),

    -- Question136
    (136, 'The degree of interdependence between software modules'),
    (136, 'The size of the codebase'),
    (136, 'The performance of the application'),
    (136, 'The security level of the system'),

    -- Question137
    (137, 'A single, unified codebase'),
    (137, 'Decentralized data management'),
    (137, 'Independent deployment of small services'),
    (137, 'Monolithic deployment units'),

    -- Question138
    (138, 'Use Case Diagram'),
    (138, 'Sequence Diagram'),
    (138, 'Class Diagram'),
    (138, 'Activity Diagram'),

    -- Question139
    (139, 'To separate business logic from data access'),
    (139, 'To provide a clear separation between the UI and the business logic for better testability'),
    (139, 'To integrate multiple layers into a single entity'),
    (139, 'To manage database transactions efficiently'),

    -- Question140
    (140, 'Modules have multiple responsibilities'),
    (140, 'Modules have well-defined, related responsibilities'),
    (140, 'Modules are tightly coupled'),
    (140, 'Modules are dependent on each other');

    -- Question141
    (141, 'To validate individual components for correctness'),
    (141, 'To ensure the system meets user requirements'),
    (141, 'To find defects in the integrated system'),
    (141, 'To evaluate the system performance under load'),
    
    -- Question142
    (142, 'Integration Testing'),
    (142, 'Unit Testing'),
    (142, 'System Testing'),
    (142, 'Acceptance Testing'),
    
    -- Question143
    (143, 'System Integration Testing'),
    (143, 'Simple Integration Testing'),
    (143, 'Software Integration Testing'),
    (143, 'System Iterable Testing'),
    
    -- Question144
    (144, 'Validation Testing'),
    (144, 'Verification Testing'),
    (144, 'Performance Testing'),
    (144, 'Security Testing'),
    
    -- Question145
    (145, 'To ensure new changes have not adversely affected existing functionalities'),
    (145, 'To validate the user requirements'),
    (145, 'To improve software performance'),
    (145, 'To test the hardware compatibility'),
    
    -- Question146
    (146, 'Waterfall Model'),
    (146, 'Iterative Model'),
    (146, 'V-Model'),
    (146, 'Agile Model'),
    
    -- Question147
    (147, 'Reduces testing time and increases test coverage'),
    (147, 'Eliminates the need for manual testing'),
    (147, 'Improves test accuracy by removing human error'),
    (147, 'Makes the testing process more cost-effective'),
    
    -- Question148
    (148, 'Equivalence Partitioning'),
    (148, 'Boundary Value Analysis'),
    (148, 'Decision Table Testing'),
    (148, 'Statement Coverage'),
    
    -- Question149
    (149, 'Testing without any planning or documentation'),
    (149, 'Testing by preparing detailed test cases beforehand'),
    (149, 'Testing based on test charters and simultaneous learning'),
    (149, 'Testing focused solely on user interfaces'),
    
    -- Question150
    (150, 'Test Plan'),
    (150, 'Test Case'),
    (150, 'Test Scenario'),
    (150, 'Test Strategy'),
    
    -- Question151
    (151, 'Unit Testing'),
    (151, 'Integration Testing'),
    (151, 'System Testing'),
    (151, 'Acceptance Testing'),
    
    -- Question152
    (152, 'Usability Testing'),
    (152, 'Load Testing'),
    (152, 'Security Testing'),
    (152, 'Regression Testing'),
    
    -- Question153
    (153, 'A defect that is discovered by the testing team'),
    (153, 'A design flaw that may cause future errors'),
    (153, 'A requirement that is not implemented correctly'),
    (153, 'A flaw that causes software to malfunction'),
    
    -- Question154
    (154, 'System Testing'),
    (154, 'Integration Testing'),
    (154, 'Acceptance Testing'),
    (154, 'Unit Testing'),
    
    -- Question155
    (155, 'Testing conducted to determine whether the software satisfies the acceptance criteria'),
    (155, 'Testing performed to detect defects after integration'),
    (155, 'Performance tuning to improve scalability'),
    (155, 'Testing security features under attack'),
    
    -- Question156
    (156, 'JIRA'),
    (156, 'Selenium'),
    (156, 'Postman'),
    (156, 'Git'),
    
    -- Question157
    (157, 'Test-Driven Development'),
    (157, 'Time-Driven Development'),
    (157, 'Thread-Driven Development'),
    (157, 'Transaction-Driven Development'),
    
    -- Question158
    (158, 'Static Analysis'),
    (158, 'Defect Density Estimation'),
    (158, 'Load Testing'),
    (158, 'Usability Evaluation'),
    
    -- Question159
    (159, 'A testing technique that involves testing values at the edges of input domains'),
    (159, 'A technique to partition input data into equivalent blocks'),
    (159, 'A method to ensure policies are followed'),
    (159, 'A way to analyze the security of input fields'),
    
    -- Question160
    (160, 'Black Box Testing'),
    (160, 'White Box Testing'),
    (160, 'Grey Box Testing'),
    (160, 'Exploratory Testing');


    -- Question161
    (161, 'To define and control what is included in the project'),
    (161, 'To allocate the project budget effectively'),
    (161, 'To develop the project schedule'),
    (161, 'To manage project communications'),
    
    -- Question162
    (162, 'Project Scope Statement'),
    (162, 'Risk Management Plan'),
    (162, 'Stakeholder Register'),
    (162, 'Resource Allocation Matrix'),
    
    -- Question163
    (163, 'Waterfall'),
    (163, 'Agile'),
    (163, 'Critical Path Method'),
    (163, 'PERT'),
    
    -- Question164
    (164, 'Microsoft Project'),
    (164, 'JIRA'),
    (164, 'Slack'),
    (164, 'Trello'),
    
    -- Question165
    (165, 'The longest path of planned activities to the end of the project'),
    (165, 'The shortest path to complete the project'),
    (165, 'A path with the least number of tasks'),
    (165, 'A path that requires the most resources'),
    
    -- Question166
    (166, 'SWOT Analysis'),
    (166, 'Risk Register'),
    (166, 'Fishbone Diagram'),
    (166, 'Monte Carlo Simulation'),
    
    -- Question167
    (167, 'Work Breakdown Structure'),
    (167, 'Weighted Budget Sheet'),
    (167, 'Workflow Balancing System'),
    (167, 'Weekly Briefing Schedule'),
    
    -- Question168
    (168, 'Gantt Chart'),
    (168, 'Pie Chart'),
    (168, 'Flowchart'),
    (168, 'Mind Map'),
    
    -- Question169
    (169, 'Analyzing project stakeholders\' interests and influence'),
    (169, 'Assigning tasks to team members'),
    (169, 'Budgeting project expenses'),
    (169, 'Scheduling project meetings'),
    
    -- Question170
    (170, 'Resource Calendars'),
    (170, 'Resource Allocation Matrix'),
    (170, 'Resource Leveling'),
    (170, 'Resource Histograms'),
    
    -- Question171
    (171, 'To visualize project tasks and timelines'),
    (171, 'To allocate resources efficiently'),
    (171, 'To identify project risks'),
    (171, 'To manage project communications'),
    
    -- Question172
    (172, 'Scope Creep'),
    (172, 'Budget Overrun'),
    (172, 'Schedule Delay'),
    (172, 'Quality Degradation'),
    
    -- Question173
    (173, 'To measure project performance and progress'),
    (173, 'To allocate resources to tasks'),
    (173, 'To manage project risks'),
    (173, 'To communicate with stakeholders'),
    
    -- Question174
    (174, 'Scrum'),
    (174, 'Kanban'),
    (174, 'Extreme Programming'),
    (174, 'Waterfall'),
    
    -- Question175
    (175, 'Agile allows for iterative development and flexibility, while Waterfall is linear and rigid'),
    (175, 'Waterfall allows for iterative development and flexibility, while Agile is linear and rigid'),
    (175, 'Both Agile and Waterfall follow the same project phases'),
    (175, 'Agile is only suitable for software projects, while Waterfall can be used for any project'),
    
    -- Question176
    (176, 'Closing'),
    (176, 'Initiating'),
    (176, 'Executing'),
    (176, 'Planning'),
    
    -- Question177
    (177, 'Optimizing resource utilization by adjusting task allocations'),
    (177, 'Increasing project budget to meet deadlines'),
    (177, 'Reducing the scope of the project'),
    (177, 'Enhancing project quality through additional testing'),
    
    -- Question178
    (178, 'Project Charter'),
    (178, 'Project Scope Statement'),
    (178, 'Risk Management Plan'),
    (178, 'Communication Plan'),
    
    -- Question179
    (179, 'To formally authorize the project and provide the project manager with authority'),
    (179, 'To outline the project deliverables and requirements'),
    (179, 'To list all potential project risks'),
    (179, 'To manage project communications'),
    
    -- Question180
    (180, 'Brainstorming Sessions');
    (180, 'SWOT Analysis');
    (180, 'Delphi Technique');
    (180, 'Nominal Group Technique');

    -- Question181
    (181, 'V = IR'),
    (181, 'P = VI'),
    (181, 'E = mc^2'),
    (181, 'F = ma'),
    
    -- Question182
    (182, 'Farad'),
    (182, 'Ohm'),
    (182, 'Volt'),
    (182, 'Ampere'),
    
    -- Question183
    (183, 'Resistor'),
    (183, 'Capacitor'),
    (183, 'Inductor'),
    (183, 'Diode'),
    
    -- Question184
    (184, 'The sum of all voltages around a closed loop is zero'),
    (184, 'The total current entering a junction equals the total current leaving'),
    (184, 'Energy is neither created nor destroyed'),
    (184, 'Power is the product of voltage and current'),
    
    -- Question185
    (185, 'To increase voltage levels'),
    (185, 'To decrease current flow'),
    (185, 'To store electrical energy'),
    (185, 'To convert AC to DC'),
    
    -- Question186
    (186, 'Voltmeter'),
    (186, 'Ammeter'),
    (186, 'Ohmmeter'),
    (186, 'Wattmeter'),
    
    -- Question187
    (187, 'A circuit with only one path for current flow'),
    (187, 'A circuit with multiple paths for current flow'),
    (187, 'A circuit with no resistance'),
    (187, 'A circuit with alternating current'),
    
    -- Question188
    (188, 'A circuit with multiple branches allowing current to split'),
    (188, 'A circuit that operates on direct current'),
    (188, 'A circuit with a single loop'),
    (188, 'A circuit with varying resistance'),
    
    -- Question189
    (189, 'P = V + I'),
    (189, 'P = VI'),
    (189, 'P = V/I'),
    (189, 'P = I^2R'),
    
    -- Question190
    (190, 'Newton\'s Second Law'),
    (190, 'Ohm\'s Law'),
    (190, 'Faraday\'s Law'),
    (190, 'Kirchhoff\'s Current Law'),
    
    -- Question191
    (191, 'To store energy temporarily'),
    (191, 'To resist current flow'),
    (191, 'To amplify signals'),
    (191, 'To convert AC to DC'),
    
    -- Question192
    (192, 'Capacitor'),
    (192, 'Inductor'),
    (192, 'Resistor'),
    (192, 'Transistor'),
    
    -- Question193
    (193, 'Alternating Current'),
    (193, 'Direct Current'),
    (193, 'Both AC and DC'),
    (193, 'Neither AC nor DC'),
    
    -- Question194
    (194, 'A material that can conduct electricity under certain conditions'),
    (194, 'A material that cannot conduct electricity'),
    (194, 'A material that only conducts electricity'),
    (194, 'A material used for insulation'),
    
    -- Question195
    (195, 'To allow current to flow in one direction only'),
    (195, 'To increase the voltage in a circuit'),
    (195, 'To decrease the resistance in a circuit'),
    (195, 'To store electrical energy'),
    
    -- Question196
    (196, '50 Hz'),
    (196, '60 Hz'),
    (196, '70 Hz'),
    (196, '80 Hz'),
    
    -- Question197
    (197, 'To prevent electrical shock and equipment damage'),
    (197, 'To increase the current flow'),
    (197, 'To reduce power consumption'),
    (197, 'To enhance signal quality'),
    
    -- Question198
    (198, 'Voltmeter'),
    (198, 'Ammeter'),
    (198, 'Ohmmeter'),
    (198, 'Multimeter'),
    
    -- Question199
    (199, 'The property of a conductor by which a change in current flowing through it induces an electromotive force'),
    (199, 'The ability of a material to oppose the flow of electric current'),
    (199, 'The speed at which electrons flow through a conductor'),
    (199, 'The capacity of a material to hold an electric charge'),
    
    -- Question200
    (200, 'To store energy in a magnetic field'),
    (200, 'To convert electrical energy into mechanical energy'),
    (200, 'To reduce the voltage in a circuit'),
    (200, 'To amplify the current in a circuit');

    -- Question201
    (201, 'The electric field inside a conductor is zero.'),
    (201, 'A changing magnetic field induces an electric current in a closed loop.'),
    (201, 'The total charge in an isolated system remains constant.'),
    (201, 'Energy is neither created nor destroyed.'),
    
    -- Question202
    (202, 'The electric flux through a closed surface is proportional to the charge enclosed.'),
    (202, 'Magnetic fields do not have sources or sinks.'),
    (202, 'The magnetic flux through a closed surface is proportional to the current enclosed.'),
    (202, 'Electric fields interact only with charge densities.'),
    
    -- Question203
    (203, 'Weber'),
    (203, 'Tesla'),
    (203, 'Henry'),
    (203, 'Ampere'),
    
    -- Question204
    (204, 'It defines the relationship between electric field and electric potential.'),
    (204, 'It describes how capacitance affects current.'),
    (204, 'It states that the direction of induced current opposes the change in magnetic flux.'),
    (204, 'It relates the energy stored in magnetic fields to current.'),
    
    -- Question205
    (205, 'The total electric field is the sum of the individual fields.'),
    (205, 'Magnetism is caused only by permanent magnets.'),
    (205, 'Electric potential is always positive.'),
    (205, 'Electromagnetic waves do not interfere.'),
    
    -- Question206
    (206, 'Gauss\'s Law for electricity.'),
    (206, 'Gauss\'s Law for magnetism.'),
    (206, 'Faraday\'s Law of Induction.'),
    (206, 'Ampère\'s Law with Maxwell\'s addition.'),
    
    -- Question207
    (207, 'Converts mechanical energy to electrical energy.'),
    (207, 'Changes the voltage level of alternating current through electromagnetic induction.'),
    (207, 'Stores electrical energy in a magnetic field.'),
    (207, 'Rectifies alternating current to direct current.'),
    
    -- Question208
    (208, 'Current due to moving charges.'),
    (208, 'An effective current accounting for changing electric fields.'),
    (208, 'The current flowing through a conductor.'),
    (208, 'Current causing displacement of protons.'),
    
    -- Question209
    (209, 'The tendency of AC to flow near the surface of conductors.'),
    (209, 'The reduction of magnetic fields over distance.'),
    (209, 'The increase of resistance with temperature.'),
    (209, 'The generation of microwaves by electron movement.'),
    
    -- Question210
    (210, 'The time it takes for a wave to complete one cycle.'),
    (210, 'The distance between two consecutive wave crests.'),
    (210, 'The amplitude of the wave.'),
    (210, 'The frequency multiplied by speed.'),
    
    -- Question211
    (211, 'It measures the medium\'s ability to support electric field lines.'),
    (211, 'It quantifies the medium\'s magnetic properties.'),
    (211, 'It indicates the temperature dependency of the medium.'),
    (211, 'It defines the thermal conductivity.'),
    
    -- Question212
    (212, 'To oppose changes in current.'),
    (212, 'To store electrical energy temporarily.'),
    (212, 'To measure electric potential.'),
    (212, 'To increase current flow.'),
    
    -- Question213
    (213, 'The ability of a component to store magnetic energy.'),
    (213, 'The rate at which voltage changes in a circuit.'),
    (213, 'The resistance to the change in electric current in a circuit.'),
    (213, 'The charge accumulated on a component.'),
    
    -- Question214
    (214, 'Area divided by distance.'),
    (214, 'Distance divided by area.'),
    (214, 'Product of area and distance.'),
    (214, 'Sum of area and distance.'),
    
    -- Question215
    (215, '50 Hz'),
    (215, '60 Hz'),
    (215, '70 Hz'),
    (215, '80 Hz'),
    
    -- Question216
    (216, 'To prevent voltage spikes.'),
    (216, 'To provide a return path for current.'),
    (216, 'To protect against electrical shock and equipment damage.'),
    (216, 'To increase the efficiency of power distribution.'),
    
    -- Question217
    (217, 'Static fields do not change over time, dynamic fields do.'),
    (217, 'Static fields are produced by permanent magnets, dynamic by currents.'),
    (217, 'Static fields have higher intensity.'),
    (217, 'There is no difference.'),
    
    -- Question218
    (218, 'They are inversely proportional.'),
    (218, 'Electric field is the negative gradient of electric potential.'),
    (218, 'Electric potential is the derivative of electric field.'),
    (218, 'They are unrelated.'),
    
    -- Question219
    (219, 'To account for changing electric fields in Ampère\'s Law.'),
    (219, 'To define the displacement field.'),
    (219, 'To separate static and dynamic charges.'),
    (219, 'To enhance capacitance in a circuit.'),
    
    -- Question220
    (220, 'Through physical displacement of charges only.'),
    (220, 'Via self-sustaining oscillating electric and magnetic fields.'),
    (220, 'Through conduction and convection processes.'),
    (220, 'By gravitational interaction among particles.');

    -- Question221
    (221, 'To step up or step down voltage levels'),
    (221, 'To convert AC to DC'),
    (221, 'To store electrical energy'),
    (221, 'To measure electrical power'),
    
    -- Question222
    (222, 'Volt'),
    (222, 'Watt'),
    (222, 'Ampere'),
    (222, 'Ohm'),
    
    -- Question223
    (223, 'To increase the voltage in a circuit'),
    (223, 'To protect the circuit from overloads and short circuits'),
    (223, 'To store electrical energy'),
    (223, 'To convert AC to DC'),
    
    -- Question224
    (224, 'A generator converts mechanical energy to electrical energy, while a motor converts electrical energy to mechanical energy'),
    (224, 'A generator stores energy, while a motor releases energy'),
    (224, 'A generator operates on AC, while a motor operates on DC'),
    (224, 'A generator is used in power plants, while a motor is used in households'),
    
    -- Question225
    (225, 'Power that does no useful work but is necessary to maintain voltage levels'),
    (225, 'Power that is converted to heat in the circuit'),
    (225, 'Power that is stored in capacitors'),
    (225, 'Power that is used to light up bulbs'),
    
    -- Question226
    (226, 'To amplify signals'),
    (226, 'To protect circuits by opening or closing contacts in response to abnormal conditions'),
    (226, 'To store electrical energy'),
    (226, 'To convert AC to DC'),
    
    -- Question227
    (227, 'To store electrical energy'),
    (227, 'To transmit electrical power over long distances'),
    (227, 'To convert AC to DC'),
    (227, 'To measure electrical power'),
    
    -- Question228
    (228, 'The ratio of real power to apparent power'),
    (228, 'The ratio of apparent power to real power'),
    (228, 'The ratio of reactive power to real power'),
    (228, 'The ratio of real power to reactive power'),
    
    -- Question229
    (229, 'It indicates the efficiency of power usage over a period of time'),
    (229, 'It measures the total power consumed by a load'),
    (229, 'It represents the peak power demand of a load'),
    (229, 'It shows the power loss in a system'),
    
    -- Question230
    (230, 'To store electrical energy'),
    (230, 'To improve power factor and voltage regulation'),
    (230, 'To convert AC to DC'),
    (230, 'To measure electrical power'),
    
    -- Question231
    (231, 'Single-phase power is used for industrial applications, while three-phase power is used for residential applications'),
    (231, 'Single-phase power has one alternating voltage, while three-phase power has three alternating voltages'),
    (231, 'Single-phase power is more efficient than three-phase power'),
    (231, 'Single-phase power is used for high power applications, while three-phase power is used for low power applications'),
    
    -- Question232
    (232, 'To increase the voltage in a circuit'),
    (232, 'To provide a safe path for fault currents and prevent electrical shock'),
    (232, 'To store electrical energy'),
    (232, 'To convert AC to DC'),
    
    -- Question233
    (233, 'To convert AC to DC'),
    (233, 'To improve power factor'),
    (233, 'To regulate voltage levels'),
    (233, 'To provide reactive power support'),
    
    -- Question234
    (234, 'It reduces power losses and improves efficiency'),
    (234, 'It increases the current carrying capacity of transmission lines'),
    (234, 'It reduces the need for transformers'),
    (234, 'It eliminates the need for circuit breakers'),
    
    -- Question235
    (235, 'To convert AC to DC'),
    (235, 'To step up or step down voltage levels and distribute power'),
    (235, 'To store electrical energy'),
    (235, 'To measure electrical power'),
    
    -- Question236
    (236, 'AC transmission is more efficient than DC transmission'),
    (236, 'DC transmission is more efficient than AC transmission'),
    (236, 'AC transmission is used for short distances, while DC transmission is used for long distances'),
    (236, 'DC transmission is used for short distances, while AC transmission is used for long distances'),
    
    -- Question237
    (237, 'To convert AC to DC'),
    (237, 'To regulate voltage levels and maintain stability'),
    (237, 'To store electrical energy'),
    (237, 'To measure electrical power'),
    
    -- Question238
    (238, 'To analyze the flow of power in a system and ensure efficient operation'),
    (238, 'To measure electrical power'),
    (238, 'To store electrical energy'),
    (238, 'To convert AC to DC'),
    
    -- Question239
    (239, 'To store electrical energy'),
    (239, 'To protect equipment from voltage spikes and surges'),
    (239, 'To convert AC to DC'),
    (239, 'To measure electrical power'),
    
    -- Question240
    (240, 'It simplifies the analysis of power systems by normalizing values'),
    (240, 'It measures the efficiency of power systems'),
    (240, 'It represents the peak power demand of a load'),
    (240, 'It shows the power loss in a system');

    -- Question241
    (241, 'Energy cannot be created or destroyed, only transferred or converted'),
    (241, 'The entropy of an isolated system always increases'),
    (241, 'The total energy of an isolated system remains constant'),
    (241, 'Heat flows from a hotter to a cooler body'),
    
    -- Question242
    (242, 'Joule'),
    (242, 'Watt'),
    (242, 'Kelvin'),
    (242, 'Joule per Kelvin'),
    
    -- Question243
    (243, 'The total energy of a system'),
    (243, 'The heat content of a system at constant pressure'),
    (243, 'The work done by a system'),
    (243, 'The temperature of a system'),
    
    -- Question244
    (244, 'Energy cannot be created or destroyed, only transferred or converted'),
    (244, 'The entropy of an isolated system always increases'),
    (244, 'The total energy of an isolated system remains constant'),
    (244, 'Heat flows from a cooler to a hotter body'),
    
    -- Question245
    (245, 'A theoretical engine with maximum efficiency'),
    (245, 'An engine that operates on diesel fuel'),
    (245, 'An engine that converts heat into work'),
    (245, 'An engine used in refrigeration cycles'),
    
    -- Question246
    (246, 'The amount of heat required to raise the temperature of a unit mass by one degree Celsius'),
    (246, 'The amount of heat required to change the phase of a unit mass'),
    (246, 'The amount of work done by a system per unit mass'),
    (246, 'The amount of energy stored in a system'),
    
    -- Question247
    (247, 'A process that occurs at constant temperature'),
    (247, 'A process that occurs at constant pressure'),
    (247, 'A process that occurs at constant volume'),
    (247, 'A process that occurs without heat transfer'),
    
    -- Question248
    (248, 'The ratio of work output to heat input'),
    (248, 'The ratio of heat output to work input'),
    (248, 'The ratio of heat input to work output'),
    (248, 'The ratio of work input to heat output'),
    
    -- Question249
    (249, 'To transfer heat between two or more fluids'),
    (249, 'To store thermal energy'),
    (249, 'To convert heat into work'),
    (249, 'To measure temperature changes'),
    
    -- Question250
    (250, 'A system that exchanges energy but not matter with its surroundings'),
    (250, 'A system that exchanges matter but not energy with its surroundings'),
    (250, 'A system that exchanges both energy and matter with its surroundings'),
    (250, 'A system that does not exchange energy or matter with its surroundings'),
    
    -- Question251
    (251, 'Heat is a form of energy, while temperature is a measure of the average kinetic energy of particles'),
    (251, 'Heat is a measure of the average kinetic energy of particles, while temperature is a form of energy'),
    (251, 'Heat and temperature are the same'),
    (251, 'Heat is measured in degrees Celsius, while temperature is measured in Joules'),
    
    -- Question252
    (252, 'A process that can be reversed without leaving any trace on the surroundings'),
    (252, 'A process that occurs at constant pressure'),
    (252, 'A process that occurs at constant volume'),
    (252, 'A process that occurs without heat transfer'),
    
    -- Question253
    (253, 'The entropy of a perfect crystal approaches zero as the temperature approaches absolute zero'),
    (253, 'Energy cannot be created or destroyed, only transferred or converted'),
    (253, 'The entropy of an isolated system always increases'),
    (253, 'Heat flows from a hotter to a cooler body'),
    
    -- Question254
    (254, 'A device that transfers heat from a colder area to a hotter area'),
    (254, 'A device that converts heat into work'),
    (254, 'A device that measures temperature changes'),
    (254, 'A device that stores thermal energy'),
    
    -- Question255
    (255, 'To transfer heat from a low-temperature region to a high-temperature region'),
    (255, 'To convert heat into work'),
    (255, 'To measure temperature changes'),
    (255, 'To store thermal energy'),
    
    -- Question256
    (256, 'A region in space where mass and energy balances are applied'),
    (256, 'A system that exchanges energy but not matter with its surroundings'),
    (256, 'A system that exchanges matter but not energy with its surroundings'),
    (256, 'A system that does not exchange energy or matter with its surroundings'),
    
    -- Question257
    (257, 'Conduction is the transfer of heat through a solid, while convection is the transfer of heat through a fluid'),
    (257, 'Conduction is the transfer of heat through a fluid, while convection is the transfer of heat through a solid'),
    (257, 'Conduction and convection are the same'),
    (257, 'Conduction is the transfer of heat through radiation, while convection is the transfer of heat through a solid'),
    
    -- Question258
    (258, 'A process that follows the equation PV^n = constant'),
    (258, 'A process that occurs at constant temperature'),
    (258, 'A process that occurs at constant pressure'),
    (258, 'A process that occurs at constant volume'),
    
    -- Question259
    (259, 'To convert thermal energy into mechanical energy'),
    (259, 'To transfer heat between two or more fluids'),
    (259, 'To store thermal energy'),
    (259, 'To measure temperature changes'),
    
    -- Question260
    (260, 'A transition between different states of matter'),
    (260, 'A process that occurs at constant temperature'),
    (260, 'A process that occurs at constant pressure'),
    (260, 'A process that occurs at constant volume');

    -- Question261
    (261, 'The study of fluids and the forces on them'),
    (261, 'The study of solid mechanics'),
    (261, 'The study of thermodynamics'),
    (261, 'The study of heat transfer'),
    
    -- Question262
    (262, 'Laminar flow is smooth and orderly, while turbulent flow is chaotic'),
    (262, 'Laminar flow is chaotic, while turbulent flow is smooth and orderly'),
    (262, 'Laminar flow occurs at high Reynolds numbers, while turbulent flow occurs at low Reynolds numbers'),
    (262, 'There is no difference between laminar and turbulent flow'),
    
    -- Question263
    (263, 'A1V1 = A2V2'),
    (263, 'P1 + 0.5ρV1^2 + ρgh1 = P2 + 0.5ρV2^2 + ρgh2'),
    (263, 'F = ma'),
    (263, 'Q = mCΔT'),
    
    -- Question264
    (264, 'The pressure in a fluid decreases as the fluid\'s velocity increases'),
    (264, 'The pressure in a fluid increases as the fluid\'s velocity increases'),
    (264, 'The pressure in a fluid remains constant as the fluid\'s velocity increases'),
    (264, 'The pressure in a fluid is independent of the fluid\'s velocity'),
    
    -- Question265
    (265, 'Pascal'),
    (265, 'Newton-second per square meter'),
    (265, 'Joule'),
    (265, 'Watt'),
    
    -- Question266
    (266, 'A dimensionless number used to predict flow patterns in different fluid flow situations'),
    (266, 'A measure of the fluid\'s viscosity'),
    (266, 'A measure of the fluid\'s density'),
    (266, 'A measure of the fluid\'s temperature'),
    
    -- Question267
    (267, 'To measure fluid pressure'),
    (267, 'To measure fluid flow rate'),
    (267, 'To measure fluid temperature'),
    (267, 'To measure fluid density'),
    
    -- Question268
    (268, 'The ratio of the density of a fluid to the density of a reference substance'),
    (268, 'The ratio of the viscosity of a fluid to the viscosity of a reference substance'),
    (268, 'The ratio of the temperature of a fluid to the temperature of a reference substance'),
    (268, 'The ratio of the pressure of a fluid to the pressure of a reference substance'),
    
    -- Question269
    (269, 'To measure the flow rate of a fluid'),
    (269, 'To measure the pressure of a fluid'),
    (269, 'To measure the temperature of a fluid'),
    (269, 'To measure the density of a fluid'),
    
    -- Question270
    (270, 'Absolute pressure is measured relative to a perfect vacuum, while gauge pressure is measured relative to atmospheric pressure'),
    (270, 'Absolute pressure is measured relative to atmospheric pressure, while gauge pressure is measured relative to a perfect vacuum'),
    (270, 'Absolute pressure and gauge pressure are the same'),
    (270, 'Absolute pressure is always higher than gauge pressure'),
    
    -- Question271
    (271, 'A set of partial differential equations that describe the motion of viscous fluid substances'),
    (271, 'A set of equations that describe the motion of solid objects'),
    (271, 'A set of equations that describe the transfer of heat in fluids'),
    (271, 'A set of equations that describe the behavior of gases'),
    
    -- Question272
    (272, 'To convert hydraulic energy into mechanical energy'),
    (272, 'To convert mechanical energy into hydraulic energy'),
    (272, 'To measure the flow rate of a fluid'),
    (272, 'To measure the pressure of a fluid'),
    
    -- Question273
    (273, 'The volume of fluid that passes a point in a given period of time'),
    (273, 'The pressure of a fluid at a given point'),
    (273, 'The temperature of a fluid at a given point'),
    (273, 'The density of a fluid at a given point'),
    
    -- Question274
    (274, 'Pressure applied to a confined fluid is transmitted undiminished throughout the fluid'),
    (274, 'The buoyant force on an object is equal to the weight of the fluid displaced by the object'),
    (274, 'The pressure in a fluid decreases as the fluid\'s velocity increases'),
    (274, 'The volume of a fluid is conserved in a closed system'),
    
    -- Question275
    (275, 'To store hydraulic energy and release it when needed'),
    (275, 'To measure the flow rate of a fluid'),
    (275, 'To measure the pressure of a fluid'),
    (275, 'To convert hydraulic energy into mechanical energy'),
    
    -- Question276
    (276, 'The upward force exerted by a fluid on a submerged object'),
    (276, 'The pressure applied to a confined fluid'),
    (276, 'The volume of fluid that passes a point in a given period of time'),
    (276, 'The ratio of the density of a fluid to the density of a reference substance'),
    
    -- Question277
    (277, 'To increase the pressure of a fluid'),
    (277, 'To measure the flow rate of a fluid'),
    (277, 'To measure the pressure of a fluid'),
    (277, 'To convert hydraulic energy into mechanical energy'),
    
    -- Question278
    (278, 'A fluid can flow and deform continuously under an applied shear stress, while a solid cannot'),
    (278, 'A solid can flow and deform continuously under an applied shear stress, while a fluid cannot'),
    (278, 'A fluid has a fixed shape, while a solid does not'),
    (278, 'There is no difference between a fluid and a solid'),
    
    -- Question279
    (279, 'To measure the velocity of a fluid'),
    (279, 'To measure the pressure of a fluid'),
    (279, 'To measure the temperature of a fluid'),
    (279, 'To measure the density of a fluid'),
    
    -- Question280
    (280, 'A line that is tangent to the velocity vector of the flow at every point'),
    (280, 'A line that is perpendicular to the velocity vector of the flow at every point'),
    (280, 'A line that represents the pressure distribution in a fluid'),
    (280, 'A line that represents the temperature distribution in a fluid');

    -- Question281
    (281, 'The internal resistance of a material to deformation'),
    (281, 'The change in length per unit length'),
    (281, 'The force applied per unit area'),
    (281, 'The energy stored in a material'),
    
    -- Question282
    (282, 'Pascal'),
    (282, 'Newton'),
    (282, 'Joule'),
    (282, 'Watt'),
    
    -- Question283
    (283, 'The internal resistance of a material to deformation'),
    (283, 'The change in length per unit length'),
    (283, 'The force applied per unit area'),
    (283, 'The energy stored in a material'),
    
    -- Question284
    (284, 'Stress is directly proportional to strain within the elastic limit'),
    (284, 'Stress is inversely proportional to strain within the elastic limit'),
    (284, 'Stress is directly proportional to strain beyond the elastic limit'),
    (284, 'Stress is inversely proportional to strain beyond the elastic limit'),
    
    -- Question285
    (285, 'Elastic deformation is reversible, while plastic deformation is permanent'),
    (285, 'Plastic deformation is reversible, while elastic deformation is permanent'),
    (285, 'Both elastic and plastic deformation are reversible'),
    (285, 'Both elastic and plastic deformation are permanent'),
    
    -- Question286
    (286, 'The ratio of stress to strain in the elastic region'),
    (286, 'The ratio of strain to stress in the elastic region'),
    (286, 'The ratio of stress to strain in the plastic region'),
    (286, 'The ratio of strain to stress in the plastic region'),
    
    -- Question287
    (287, 'The internal resistance of a material to shear deformation'),
    (287, 'The change in length per unit length'),
    (287, 'The force applied per unit area'),
    (287, 'The energy stored in a material'),
    
    -- Question288
    (288, 'The ratio of lateral strain to axial strain'),
    (288, 'The ratio of axial strain to lateral strain'),
    (288, 'The ratio of stress to strain in the elastic region'),
    (288, 'The ratio of strain to stress in the elastic region'),
    
    -- Question289
    (289, 'To show the relationship between stress and strain for a material'),
    (289, 'To measure the hardness of a material'),
    (289, 'To determine the density of a material'),
    (289, 'To calculate the thermal conductivity of a material'),
    
    -- Question290
    (290, 'The stress at which a material begins to deform plastically'),
    (290, 'The maximum stress a material can withstand'),
    (290, 'The stress at which a material fractures'),
    (290, 'The stress at which a material returns to its original shape'),
    
    -- Question291
    (291, 'Brittle materials fracture without significant deformation, while ductile materials undergo significant deformation before fracturing'),
    (291, 'Ductile materials fracture without significant deformation, while brittle materials undergo significant deformation before fracturing'),
    (291, 'Both brittle and ductile materials fracture without significant deformation'),
    (291, 'Both brittle and ductile materials undergo significant deformation before fracturing'),
    
    -- Question292
    (292, 'The maximum stress a material can withstand before fracturing'),
    (292, 'The stress at which a material begins to deform plastically'),
    (292, 'The stress at which a material returns to its original shape'),
    (292, 'The stress at which a material fractures'),
    
    -- Question293
    (293, 'To ensure that structures and components can withstand applied loads without failure'),
    (293, 'To measure the hardness of a material'),
    (293, 'To determine the density of a material'),
    (293, 'To calculate the thermal conductivity of a material'),
    
    -- Question294
    (294, 'The weakening of a material due to repeated loading and unloading'),
    (294, 'The permanent deformation of a material under constant load'),
    (294, 'The resistance of a material to indentation'),
    (294, 'The ability of a material to absorb energy before fracturing'),
    
    -- Question295
    (295, 'Hardness is the resistance to indentation, while toughness is the ability to absorb energy before fracturing'),
    (295, 'Toughness is the resistance to indentation, while hardness is the ability to absorb energy before fracturing'),
    (295, 'Hardness and toughness are the same'),
    (295, 'Hardness is the resistance to deformation, while toughness is the resistance to fracture'),
    
    -- Question296
    (296, 'The permanent deformation of a material under constant load over time'),
    (296, 'The weakening of a material due to repeated loading and unloading'),
    (296, 'The resistance of a material to indentation'),
    (296, 'The ability of a material to absorb energy before fracturing'),
    
    -- Question297
    (297, 'To determine the shear strength of a material'),
    (297, 'To measure the hardness of a material'),
    (297, 'To determine the tensile strength of a material'),
    (297, 'To calculate the thermal conductivity of a material'),
    
    -- Question298
    (298, 'The internal moment that causes a beam to bend'),
    (298, 'The force applied per unit area'),
    (298, 'The change in length per unit length'),
    (298, 'The energy stored in a material'),
    
    -- Question299
    (299, 'A simply supported beam is supported at both ends, while a cantilever beam is fixed at one end and free at the other'),
    (299, 'A cantilever beam is supported at both ends, while a simply supported beam is fixed at one end and free at the other'),
    (299, 'Both simply supported and cantilever beams are supported at both ends'),
    (299, 'Both simply supported and cantilever beams are fixed at one end and free at the other'),
    
    -- Question300
    (300, 'To represent the state of stress at a point and visualize the relationships between normal and shear stresses'),
    (300, 'To measure the hardness of a material'),
    (300, 'To determine the density of a material'),
    (300, 'To calculate the thermal conductivity of a material');





-- Insert correct answers into Answer_Key
INSERT INTO Answer_Key (QuestionID, CorrectOptionID)
VALUES
    (1, 1), -- Correct option for Question 1
    (2, 2), -- Correct option for Question 2
    (3, 2), -- Correct option for Question 3
    (4, 4), -- Correct option for Question 4
    (5, 1); -- Correct option for Question 5
    (6, 1),  -- Correct option for Question 6
    (7, 3),  -- Correct option for Question 7
    (8, 1),  -- Correct option for Question 8
    (9, 4),  -- Correct option for Question 9
    (10, 1), -- Correct option for Question 10
    (11, 1), -- Correct option for Question 11
    (12, 1), -- Correct option for Question 12
    (13, 1), -- Correct option for Question 13
    (14, 1), -- Correct option for Question 14
    (15, 3), -- Correct option for Question 15
    (16, 1), -- Correct option for Question 16
    (17, 1), -- Correct option for Question 17
    (18, 1), -- Correct option for Question 18
    (19, 1), -- Correct option for Question 19
    (20, 1); -- Correct option for Question 20

    (21, 81),  -- Correct option for Question 21
    (22, 85),  -- Correct option for Question 22
    (23, 89),  -- Correct option for Question 23
    (24, 93),  -- Correct option for Question 24
    (25, 97),  -- Correct option for Question 25
    (26, 101), -- Correct option for Question 26
    (27, 107), -- Correct option for Question 27
    (28, 111), -- Correct option for Question 28
    (29, 115), -- Correct option for Question 29
    (30, 121), -- Correct option for Question 30
    (31, 125), -- Correct option for Question 31
    (32, 129), -- Correct option for Question 32
    (33, 133), -- Correct option for Question 33
    (34, 137), -- Correct option for Question 34
    (35, 141), -- Correct option for Question 35
    (36, 145), -- Correct option for Question 36
    (37, 149), -- Correct option for Question 37
    (38, 153), -- Correct option for Question 38
    (39, 157), -- Correct option for Question 39
    (40, 161); -- Correct option for Question 40
    (41, 161),  -- Correct option for Question 41
    (42, 165),  -- Correct option for Question 42
    (43, 169),  -- Correct option for Question 43
    (44, 173),  -- Correct option for Question 44
    (45, 177),  -- Correct option for Question 45
    (46, 181),  -- Correct option for Question 46
    (47, 185),  -- Correct option for Question 47
    (48, 189),  -- Correct option for Question 48
    (49, 193),  -- Correct option for Question 49
    (50, 197),  -- Correct option for Question 50
    (51, 201),  -- Correct option for Question 51
    (52, 205),  -- Correct option for Question 52
    (53, 209),  -- Correct option for Question 53
    (54, 213),  -- Correct option for Question 54
    (55, 217),  -- Correct option for Question 55
    (56, 221),  -- Correct option for Question 56
    (57, 225),  -- Correct option for Question 57
    (58, 229),  -- Correct option for Question 58
    (59, 233),  -- Correct option for Question 59
    (60, 237);  -- Correct option for Question 60
-------------------------------------------------------------

    (61, 1),  -- Correct option for Question61
    (62, 1),  -- Correct option for Question62
    (63, 1),  -- Correct option for Question63
    (64, 1),  -- Correct option for Question64
    (65, 2),  -- Correct option for Question65
    (66, 1),  -- Correct option for Question66
    (67, 2),  -- Correct option for Question67
    (68, 1),  -- Correct option for Question68
    (69, 1),  -- Correct option for Question69
    (70, 1),  -- Correct option for Question70
    (71, 3),  -- Correct option for Question71
    (72, 1),  -- Correct option for Question72
    (73, 1),  -- Correct option for Question73
    (74, 1),  -- Correct option for Question74
    (75, 1),  -- Correct option for Question75
    (76, 2),  -- Correct option for Question76
    (77, 1),  -- Correct option for Question77
    (78, 1),  -- Correct option for Question78
    (79, 1),  -- Correct option for Question79
    (80, 1);  -- Correct option for Question80

    (81, 2),  -- Correct option for Question81
    (82, 1),  -- Correct option for Question82
    (83, 1),  -- Correct option for Question83
    (84, 3),  -- Correct option for Question84
    (85, 2),  -- Correct option for Question85
    (86, 1),  -- Correct option for Question86
    (87, 1),  -- Correct option for Question87
    (88, 1),  -- Correct option for Question88
    (89, 1),  -- Correct option for Question89
    (90, 3),  -- Correct option for Question90
    (91, 2),  -- Correct option for Question91
    (92, 1),  -- Correct option for Question92
    (93, 1),  -- Correct option for Question93
    (94, 1),  -- Correct option for Question94
    (95, 1),  -- Correct option for Question95
    (96, 1),  -- Correct option for Question96
    (97, 1),  -- Correct option for Question97
    (98, 1),  -- Correct option for Question98
    (99, 1),  -- Correct option for Question99
    (100, 2); -- Correct option for Question100

    (101, 2),  -- Correct option for Question101
    (102, 2),  -- Correct option for Question102
    (103, 1),  -- Correct option for Question103
    (104, 2),  -- Correct option for Question104
    (105, 2),  -- Correct option for Question105
    (106, 2),  -- Correct option for Question106
    (107, 2),  -- Correct option for Question107
    (108, 2),  -- Correct option for Question108
    (109, 1),  -- Correct option for Question109
    (110, 2),  -- Correct option for Question110
    (111, 2),  -- Correct option for Question111
    (112, 3),  -- Correct option for Question112
    (113, 1),  -- Correct option for Question113
    (114, 2),  -- Correct option for Question114
    (115, 3),  -- Correct option for Question115
    (116, 3),  -- Correct option for Question116
    (117, 1),  -- Correct option for Question117
    (118, 1),  -- Correct option for Question118
    (119, 2),  -- Correct option for Question119
    (120, 2);  -- Correct option for Question120

    (121, 2),  -- Correct option for Question121
    (122, 2),  -- Correct option for Question122
    (123, 1),  -- Correct option for Question123
    (124, 3),  -- Correct option for Question124
    (125, 2),  -- Correct option for Question125
    (126, 1),  -- Correct option for Question126
    (127, 3),  -- Correct option for Question127
    (128, 1),  -- Correct option for Question128
    (129, 1),  -- Correct option for Question129
    (130, 2),  -- Correct option for Question130
    (131, 1),  -- Correct option for Question131
    (132, 3),  -- Correct option for Question132
    (133, 3),  -- Correct option for Question133
    (134, 1),  -- Correct option for Question134
    (135, 1),  -- Correct option for Question135
    (136, 1),  -- Correct option for Question136
    (137, 3),  -- Correct option for Question137
    (138, 3),  -- Correct option for Question138
    (139, 2),  -- Correct option for Question139
    (140, 2);  -- Correct option for Question140

    (141, 1),  -- Correct option for Question141
    (142, 2),  -- Correct option for Question142
    (143, 1),  -- Correct option for Question143
    (144, 2),  -- Correct option for Question144
    (145, 1),  -- Correct option for Question145
    (146, 3),  -- Correct option for Question146
    (147, 1),  -- Correct option for Question147
    (148, 4),  -- Correct option for Question148
    (149, 3),  -- Correct option for Question149
    (150, 1),  -- Correct option for Question150
    (151, 1),  -- Correct option for Question151
    (152, 1),  -- Correct option for Question152
    (153, 4),  -- Correct option for Question153
    (154, 1),  -- Correct option for Question154
    (155, 1),  -- Correct option for Question155
    (156, 1),  -- Correct option for Question156
    (157, 1),  -- Correct option for Question157
    (158, 2),  -- Correct option for Question158
    (159, 1),  -- Correct option for Question159
    (160, 1);  -- Correct option for Question160

    (161, 1),  -- Correct option for Question161
    (162, 1),  -- Correct option for Question162
    (163, 2),  -- Correct option for Question163
    (164, 1),  -- Correct option for Question164
    (165, 1),  -- Correct option for Question165
    (166, 2),  -- Correct option for Question166
    (167, 1),  -- Correct option for Question167
    (168, 1),  -- Correct option for Question168
    (169, 1),  -- Correct option for Question169
    (170, 3),  -- Correct option for Question170
    (171, 1),  -- Correct option for Question171
    (172, 1),  -- Correct option for Question172
    (173, 1),  -- Correct option for Question173
    (174, 1),  -- Correct option for Question174
    (175, 1),  -- Correct option for Question175
    (176, 1),  -- Correct option for Question176
    (177, 1),  -- Correct option for Question177
    (178, 1),  -- Correct option for Question178
    (179, 1),  -- Correct option for Question179
    (180, 1);  -- Correct option for Question180

    (181, 1),  -- Correct option for Question181
    (182, 2),  -- Correct option for Question182
    (183, 2),  -- Correct option for Question183
    (184, 1),  -- Correct option for Question184
    (185, 1),  -- Correct option for Question185
    (186, 2),  -- Correct option for Question186
    (187, 1),  -- Correct option for Question187
    (188, 1),  -- Correct option for Question188
    (189, 2),  -- Correct option for Question189
    (190, 2),  -- Correct option for Question190
    (191, 1),  -- Correct option for Question191
    (192, 3),  -- Correct option for Question192
    (193, 2),  -- Correct option for Question193
    (194, 1),  -- Correct option for Question194
    (195, 1),  -- Correct option for Question195
    (196, 2),  -- Correct option for Question196
    (197, 1),  -- Correct option for Question197
    (198, 4),  -- Correct option for Question198
    (199, 1),  -- Correct option for Question199
    (200, 1);  -- Correct option for Question200

    (201, 2),  -- Correct option for Question201
    (202, 1),  -- Correct option for Question202
    (203, 1),  -- Correct option for Question203
    (204, 3),  -- Correct option for Question204
    (205, 1),  -- Correct option for Question205
    (206, 4),  -- Correct option for Question206
    (207, 2),  -- Correct option for Question207
    (208, 2),  -- Correct option for Question208
    (209, 1),  -- Correct option for Question209
    (210, 2),  -- Correct option for Question210
    (211, 1),  -- Correct option for Question211
    (212, 2),  -- Correct option for Question212
    (213, 1),  -- Correct option for Question213
    (214, 1),  -- Correct option for Question214
    (215, 1),  -- Correct option for Question215
    (216, 3),  -- Correct option for Question216
    (217, 1),  -- Correct option for Question217
    (218, 2),  -- Correct option for Question218
    (219, 1),  -- Correct option for Question219
    (220, 2);  -- Correct option for Question220

    (221, 1),  -- Correct option for Question221
    (222, 2),  -- Correct option for Question222
    (223, 2),  -- Correct option for Question223
    (224, 1),  -- Correct option for Question224
    (225, 1),  -- Correct option for Question225
    (226, 2),  -- Correct option for Question226
    (227, 2),  -- Correct option for Question227
    (228, 1),  -- Correct option for Question228
    (229, 1),  -- Correct option for Question229
    (230, 2),  -- Correct option for Question230
    (231, 2),  -- Correct option for Question231
    (232, 2),  -- Correct option for Question232
    (233, 4),  -- Correct option for Question233
    (234, 1),  -- Correct option for Question234
    (235, 2),  -- Correct option for Question235
    (236, 3),  -- Correct option for Question236
    (237, 2),  -- Correct option for Question237
    (238, 1),  -- Correct option for Question238
    (239, 2),  -- Correct option for Question239
    (240, 1);  -- Correct option for Question240

    (241, 1),  -- Correct option for Question241
    (242, 4),  -- Correct option for Question242
    (243, 2),  -- Correct option for Question243
    (244, 2),  -- Correct option for Question244
    (245, 1),  -- Correct option for Question245
    (246, 1),  -- Correct option for Question246
    (247, 1),  -- Correct option for Question247
    (248, 1),  -- Correct option for Question248
    (249, 1),  -- Correct option for Question249
    (250, 1),  -- Correct option for Question250
    (251, 1),  -- Correct option for Question251
    (252, 1),  -- Correct option for Question252
    (253, 1),  -- Correct option for Question253
    (254, 1),  -- Correct option for Question254
    (255, 1),  -- Correct option for Question255
    (256, 1),  -- Correct option for Question256
    (257, 1),  -- Correct option for Question257
    (258, 1),  -- Correct option for Question258
    (259, 1),  -- Correct option for Question259
    (260, 1);  -- Correct option for Question260

    (261, 1),  -- Correct option for Question261
    (262, 1),  -- Correct option for Question262
    (263, 1),  -- Correct option for Question263
    (264, 1),  -- Correct option for Question264
    (265, 2),  -- Correct option for Question265
    (266, 1),  -- Correct option for Question266
    (267, 1),  -- Correct option for Question267
    (268, 1),  -- Correct option for Question268
    (269, 1),  -- Correct option for Question269
    (270, 1),  -- Correct option for Question270
    (271, 1),  -- Correct option for Question271
    (272, 2),  -- Correct option for Question272
    (273, 1),  -- Correct option for Question273
    (274, 1),  -- Correct option for Question274
    (275, 1),  -- Correct option for Question275
    (276, 1),  -- Correct option for Question276
    (277, 1),  -- Correct option for Question277
    (278, 1),  -- Correct option for Question278
    (279, 1),  -- Correct option for Question279
    (280, 1);  -- Correct option for Question280

    (281, 1),  -- Correct option for Question281
    (282, 1),  -- Correct option for Question282
    (283, 2),  -- Correct option for Question283
    (284, 1),  -- Correct option for Question284
    (285, 1),  -- Correct option for Question285
    (286, 1),  -- Correct option for Question286
    (287, 1),  -- Correct option for Question287
    (288, 1),  -- Correct option for Question288
    (289, 1),  -- Correct option for Question289
    (290, 1),  -- Correct option for Question290
    (291, 1),  -- Correct option for Question291
    (292, 1),  -- Correct option for Question292
    (293, 1),  -- Correct option for Question293
    (294, 1),  -- Correct option for Question294
    (295, 1),  -- Correct option for Question295
    (296, 1),  -- Correct option for Question296
    (297, 1),  -- Correct option for Question297
    (298, 1),  -- Correct option for Question298
    (299, 1),  -- Correct option for Question299
    (300, 1);  -- Correct option for Question300
    