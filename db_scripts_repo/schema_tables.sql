-- 1️⃣ Create the new schema
CREATE SCHEMA IF NOT EXISTS company AUTHORIZATION postgres;

-- 2️⃣ Set the search path to the new schema
SET search_path TO company;

-- 3️⃣ Create the "departments" table
CREATE TABLE IF NOT EXISTS departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

-- 4️⃣ Insert sample data into "departments"
INSERT INTO departments (dept_name) VALUES 
('Human Resources'),
('IT'),
('Finance'),
('Marketing');

-- 5️⃣ Create the "employees" table
CREATE TABLE IF NOT EXISTS employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT REFERENCES departments(dept_id),
    salary DECIMAL(10,2),
    hired_date DATE DEFAULT CURRENT_DATE
);

-- 6️⃣ Insert sample data into "employees"
INSERT INTO employees (emp_name, dept_id, salary) VALUES
('Alice Johnson', 1, 60000),
('Bob Smith', 2, 75000),
('Charlie Davis', 3, 70000),
('Diana Prince', 4, 80000);

-- 7️⃣ Verify inserted data
SELECT * FROM employees;
SELECT * FROM departments;
