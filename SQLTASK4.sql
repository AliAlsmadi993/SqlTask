-- إنشاء قاعدة البيانات
CREATE DATABASE SchoolManagement1;

-- استخدام قاعدة البيانات
USE SchoolManagement1;


-- جدول الطلاب
CREATE TABLE Students (
    student_id INT PRIMARY KEY, 
    name NVARCHAR(100) NOT NULL,  
    dob DATE NOT NULL,  
    address NVARCHAR(255) 
);

-- جدول معلومات العائلة (أقارب الطلاب)
CREATE TABLE family_info (
    relative_id INT PRIMARY KEY,  
    student_id INT,  
    father_name NVARCHAR(100) NOT NULL,  
    contact_number NVARCHAR(20) NOT NULL,  
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE
);

-- جدول الدورات (المواد الدراسية)
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,  
    name NVARCHAR(100) NOT NULL UNIQUE,  
    description NVARCHAR(500),  
    resource NVARCHAR(255)  
);

-- جدول الفصول الدراسية
CREATE TABLE Classes (
    class_id INT PRIMARY KEY,  
    class_code NVARCHAR(20) NOT NULL UNIQUE,  
    room_number NVARCHAR(10) NOT NULL,  
    schedule NVARCHAR(255)  
);

-- جدول الواجبات
CREATE TABLE Assignments (
    assignment_id INT PRIMARY KEY,  
    name NVARCHAR(100) NOT NULL,  
    description NVARCHAR(500),  
    due_date DATE NOT NULL,  
    state NVARCHAR(10) CHECK (state IN ('pass', 'failed'))  
);

-- جدول الحضور
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,  
    student_id INT,  
    attendance_date DATE NOT NULL,  
    absence_type NVARCHAR(20) CHECK (absence_type IN ('leaving', 'absence', 'late')),  
    reason NVARCHAR(255),  
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE
);

-- جدول تسجيل الطلاب في الدورات (يربط الطلاب بالدورات)
CREATE TABLE Enrollments (
    student_id INT,   -- معرف الطالب
    course_id INT,    -- معرف الدورة
    enrollment_date DATE DEFAULT GETDATE(),  -- تاريخ التسجيل في الدورة
    PRIMARY KEY (student_id, course_id),  -- مفتاح أساسي مركب لمنع التكرار
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,  -- ربط الطالب
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE  -- ربط الدورة
);

-- جدول تسجيل الطلاب في الفصول الدراسية (يربط الطلاب بالفصول)
CREATE TABLE StudentClasses (
    student_id INT,   -- معرف الطالب
    class_id INT,     -- معرف الفصل
    PRIMARY KEY (student_id, class_id),  -- مفتاح أساسي مركب لمنع التكرار
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,  -- ربط الطالب
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE  -- ربط الفصل
);

-- جدول تسليم الواجبات (يربط الطلاب بالواجبات)
CREATE TABLE Submissions (
    submission_id INT PRIMARY KEY,  -- معرف التسليم (مفتاح أساسي)
    student_id INT,  -- معرف الطالب الذي سلّم الواجب
    assignment_id INT,  -- معرف الواجب الذي تم تسليمه
    submission_date DATE NOT NULL,  -- تاريخ التسليم
    state NVARCHAR(10) CHECK (state IN ('pass', 'failed')),  -- حالة الواجب (ناجح أو راسب)
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,  -- ربط الطالب
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id) ON DELETE CASCADE  -- ربط الواجب
);

INSERT INTO Students (student_id, name, dob, address) VALUES
(1, 'Mohammed Ali', '2005-03-15', 'Cairo, Egypt'),
(2, 'Ahmed Hassan', '2006-05-22', 'Riyadh, Saudi Arabia'),
(3, 'Omar Mahmoud', '2004-09-10', 'Dubai, UAE' ),
(4, 'Khaled Ibrahim', '2007-01-05', 'Amman, Jordan'),
(5, 'Youssef Ahmed', '2003-12-30', 'Doha, Qatar');

INSERT INTO Courses (course_id, name, description, resource) VALUES
(1, 'Mathematics', 'Advanced math course covering algebra and calculus.', 'math_book.pdf'),
(2, 'Physics', 'Fundamentals of physics including mechanics and thermodynamics.', 'physics_notes.pdf'),
(3, 'Computer Science', 'Introduction to programming and algorithms.', 'cs_tutorial.pdf'),
(4, 'History', 'World history from ancient to modern times.', 'history_book.pdf'),
(5, 'English Literature', 'Study of classical and modern English literature.', 'literature_notes.pdf');

INSERT INTO Classes (class_id, class_code, room_number, schedule) VALUES
(1, 'MATH101', 'A1', 'Monday & Wednesday - 10:00 AM'),
(2, 'PHY102', 'B2', 'Tuesday & Thursday - 12:00 PM'),
(3, 'CS103', 'C3', 'Monday & Friday - 09:00 AM'),
(4, 'HIS104', 'D4', 'Wednesday & Friday - 11:00 AM'),
(5, 'ENG105', 'E5', 'Tuesday & Thursday - 02:00 PM');

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-01-16'),
(3, 3, '2024-01-17'),
(4, 4, '2024-01-18'),
(5, 5, '2024-01-19');


INSERT INTO StudentClasses (student_id, class_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Assignments (assignment_id, name, description, due_date, state) VALUES
(1, 'Math Homework', 'Solve algebra problems.', '2024-02-10', 'pass'),
(2, 'Physics Lab Report', 'Analyze motion experiment.', '2024-02-12', 'failed'),
(3, 'CS Project', 'Create a basic Python program.', '2024-02-15', 'pass'),
(4, 'History Essay', 'Write an essay on World War II.', '2024-02-17', 'pass'),
(5, 'Literature Analysis', 'Analyze Shakespeare’s Hamlet.', '2024-02-20', 'failed');




INSERT INTO Submissions (submission_id, student_id, assignment_id, submission_date, state) VALUES
(1, 1, 1, '2024-02-08', 'pass'),
(2, 2, 2, '2024-02-11', 'failed'),
(3, 3, 3, '2024-02-14', 'pass'),
(4, 4, 4, '2024-02-16', 'pass'),
(5, 5, 5, '2024-02-19', 'failed');




INSERT INTO Attendance (attendance_id, student_id, attendance_date, absence_type, reason) VALUES
(1, 1, '2024-02-05', 'late', 'Traffic congestion'),
(2, 2, '2024-02-06', 'absence', 'Sick'),
(3, 3, '2024-02-07', 'leaving', 'Family emergency'),
(4, 4, '2024-02-08', 'absence', 'Personal issue'),
(5, 5, '2024-02-09', 'late', 'Missed bus');
INSERT INTO Attendance (attendance_id, student_id, attendance_date, absence_type, reason) VALUES
(6, 6, '2024-01-02', 'leaving', 'Family emergency');
INSERT INTO Attendance (attendance_id, student_id, attendance_date, absence_type, reason) VALUES
(7, 7, '2024-01-02', 'leaving', 'Family emergency'),
(8, 8, '2024-01-02', 'leaving', 'Family emergency');



--Q1
SELECT * FROM Students 
WHERE dob = '2005-03-15';


--Q2

SELECT * FROM Courses 
WHERE name = 'Mathematics';

--Q3
ALTER TABLE Students 
ADD email VARCHAR(100) ;
 

 --Q4
 INSERT INTO Students (student_id, name, dob, address, email) 
VALUES (6, 'Ibrahim ', '2006-07-21', 'Jeddah, Saudi Arabia', 'ibrahim.saeed@example.com');

--Q5

SELECT DISTINCT Students.* 
FROM Students
JOIN family_info ON Students.student_id = family_info.student_id;



SELECT * FROM Students;
SELECT * FROM family_info;


INSERT INTO family_info (relative_id, student_id, father_name, contact_number) VALUES
(1, 1, 'Ali Mohammed', '+201234567890'),
(2, 2, 'Hassan Ahmed', '+966512345678'),
(3, 3, 'Mahmoud Omar', '+971523456789'),
(4, 4, 'Ibrahim Khaled', '+962712345678'),
(5, 5, 'Ahmed Youssef', '+974312345678');

--Q6

SELECT Students.*
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id
WHERE Courses.name = 'Mathematics';


INSERT INTO Students (student_id, name, dob, address, email) VALUES
(7, 'Saad Nasser', '2006-08-12', 'Riyadh, Saudi Arabia', 'saad.nasser@example.com'),
(8, 'Hassan Tarek', '2005-11-23', 'Cairo, Egypt', 'hassan.tarek@example.com');

SELECT* FROM Enrollments;
SELECT* FROM Courses;

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(7, 1, '2025-02-12'),
(8, 1, '2025-02-12');

--Q7

SELECT Students.*
FROM Students
JOIN Submissions ON Students.student_id = Submissions.student_id
JOIN Assignments ON Submissions.assignment_id = Assignments.assignment_id
WHERE Assignments.name = 'Math Homework' 
AND Submissions.state = 'pass';

--Q8
SELECT Students.*
FROM Students
JOIN Attendance ON Students.student_id = Attendance.student_id
WHERE Attendance.absence_type = 'leaving'
AND Attendance.attendance_date BETWEEN '2024-01-01' AND '2024-01-05';
