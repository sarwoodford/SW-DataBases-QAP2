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