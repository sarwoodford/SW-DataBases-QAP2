-- CREATE TABLES

CREATE TABLE students(
id SERIAL PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
enrollment_date Date
);

CREATE TABLE professors (
id SERIAL PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
department VARCHAR(50)
);

CREATE TABLE courses(
id SERIAL PRIMARY KEY,
course_name VARCHAR(100),
course_description TEXT,
professors_id INT REFERENCES professors(id)
);

CREATE TABLE enrollments(
student_id INT REFERENCES students(id),
course_id INT REFERENCES courses(id),
enrollment_date DATE,
PRIMARY KEY(student_id, course_id)
);

-- INSERT DATA INTO TABLES

INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('John', 'Doe', 'jdoe@example.com', '2024-01-02'),
('Jane', 'Smith', 'jsmith@example.com', '2024-01-03'),
('Dave', 'Byrne', 'dbyrne@example.com', '2023-09-02'),
('Michelle', 'Johnson', 'mjohnson@example.com', '2023-09-03'),
('Jen', 'Fewer', 'jfewer@example.com', '2023-09-04');

INSERT INTO professors (first_name, last_name, department) VALUES
('Michael', 'Johnson', 'Physics'),
('Emily', 'Brown', 'English'),
('Tim', 'Smith', 'Math'),
('Lisa', 'McDonald', 'Chemistry');

INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'Introduction to Physics', 1),
('English 201', 'Second Level English', 2),
('Math 109', 'Introduction to Algebra', 3);

INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-01'),
(2, 1, '2024-01-02'),
(3, 2, '2024-01-03'),
(5, 2, '2023-09-01'),
(5, 1, '2023-09-03'),
(4, 3, '2023-09-04');

-- CREATE FULL_NAME FOR STUDENT BY CONCANTONATION OF ALL STUDENTS IN PHYSICS 101

SELECT CONCAT(students.first_name, ' ', students.last_name) AS full_name
FROM students
JOIN enrollments ON students.id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.id
WHERE courses.course_name = 'Physics 101';