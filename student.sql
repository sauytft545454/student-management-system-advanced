-- Create Database
CREATE DATABASE student_management_advanced;
USE student_management_advanced;

-- Departments
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Students
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Instructors
CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Courses
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

-- Enrollments
CREATE TABLE enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Marks
CREATE TABLE marks (
    student_id INT,
    course_id INT,
    marks INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Attendance
CREATE TABLE attendance (
    student_id INT,
    course_id INT,
    attendance_percentage INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Sample Data
INSERT INTO departments VALUES (1,'CSE'),(2,'IT'),(3,'ECE');

INSERT INTO students VALUES
(1,'Rahul',20,1),
(2,'Ankit',21,2),
(3,'Priya',19,1);

INSERT INTO instructors VALUES
(1,'Dr Sharma',1),
(2,'Dr Mehta',2);

INSERT INTO courses VALUES
(101,'DBMS',4,1),
(102,'DSA',3,2);

INSERT INTO enrollments VALUES
(1,1,101),
(2,2,102),
(3,3,101);

INSERT INTO marks VALUES
(1,101,85),
(2,102,78),
(3,101,90);

INSERT INTO attendance VALUES
(1,101,80),
(2,102,75),
(3,101,90);

-- Queries
SELECT s.name, c.course_name, m.marks
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN courses c ON m.course_id = c.course_id;

SELECT s.name, a.attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
WHERE a.attendance_percentage < 80;

SELECT c.course_name, COUNT(*) AS total_students
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name;