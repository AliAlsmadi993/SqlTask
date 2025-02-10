 CREATE DATABASE AymanforTecksolutions ;
 USE AymanforTecksolutions


CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY, 
    Name VARCHAR(100) NOT NULL 
);

CREATE TABLE TeacherDetails (
    DetailID INT PRIMARY KEY, -- Primary Key
    TeacherID INT UNIQUE, -- Foreign Key to Teachers
    Address VARCHAR(255) NOT NULL, 
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID) ON DELETE CASCADE -- One-to-One Relationship
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY, -- Primary Key
    CourseName VARCHAR(100) NOT NULL, -- Name of the Course
    TeacherID INT, -- Foreign Key to Teachers
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID) ON DELETE SET NULL -- One-to-Many Relationship
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY, -- Primary Key
    StudentNAME VARCHAR(100) NOT NULL -- Student's Name
);

--JUNCTION TABLE
CREATE TABLE StudentCourses (
    StudentID INT, -- Foreign Key to Students
    CourseID INT, -- Foreign Key to Courses
    PRIMARY KEY (StudentID, CourseID), -- Composite Primary Key
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE, -- Many-to-Many Relationship
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE -- Many-to-Many Relationship
);

--JUNCTION TABLE

CREATE TABLE TeacherStudent (
    TeacherID INT, -- Foreign Key to Teachers
    StudentID INT, -- Foreign Key to Students
    PRIMARY KEY (TeacherID, StudentID), -- Composite Primary Key
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID) ON DELETE CASCADE, -- Many-to-Many Relationship
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE -- Many-to-Many Relationship
);

INSERT INTO Teachers (TeacherID, Name)
VALUES
(1, 'Dr. Ali'),
(2, 'Ms. nader'),
(3, 'Mr. Ahmad'),
(4, 'Dr. maher'),
(5, 'Mr. Khaled');

INSERT INTO TeacherDetails (DetailID, TeacherID, Address)
VALUES
(1, 1, 'jordan'),
(2, 2, 'jordan'),
(3, 3, 'jordan'),
(4, 4, 'jordan'),
(5, 5, 'jordan');

INSERT INTO Students (StudentID, StudentNAME)
VALUES
(1, 'Ahmed'),
(2, 'Mohamed'),
(3, 'Ali'),
(4, 'Hassan'),
(5, 'Khaled');


INSERT INTO Courses (CourseID, CourseName, TeacherID)
VALUES
(1, 'Mathematics', 1),
(2, 'Physics', 2),
(3, 'Chemistry', 3),
(4, 'Biology', 4),
(5, 'Computer Science', 5);

INSERT INTO StudentCourses (StudentID, CourseID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 3);


INSERT INTO TeacherStudent (TeacherID, StudentID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 2),
(3, 5);
