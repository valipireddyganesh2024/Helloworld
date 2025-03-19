-- 1️⃣ Set schema for table creation
SET search_path TO company;

-- 2️⃣ Create "department_4" table
CREATE TABLE IF NOT EXISTS department_4 (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3️⃣ Create "ganesh" table (Employee Details)
CREATE TABLE IF NOT EXISTS ganesh (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT REFERENCES department_4(dept_id) ON DELETE SET NULL,
    salary DECIMAL(10,2),
    hired_date DATE DEFAULT CURRENT_DATE
);

-- 4️⃣ Create "reddy" table (Projects)
CREATE TABLE IF NOT EXISTS reddy (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(150) NOT NULL,
    start_date DATE DEFAULT CURRENT_DATE,
    end_date DATE
    dept_id INT REFERENCES department_4(dept_id) ON DELETE CASCADE
);

-- 5️⃣ Insert sample data into "department_4"
INSERT INTO department_4 (dept_name) VALUES 
('Human Resources'),
('IT'),
('Finance'),
('Marketing')
ON CONFLICT (dept_name) DO NOTHING;

-- 6️⃣ Insert sample data into "ganesh" (Employees)
INSERT INTO ganesh (emp_name, dept_id, salary) VALUES
('Alice Johnson', 1, 60000),
('Bob Smith', 2, 75000),
('Charlie Davis', 3, 70000),
('Diana Prince', 4, 80000)
ON CONFLICT DO NOTHING;

-- 7️⃣ Insert sample data into "reddy" (Projects)
INSERT INTO reddy (project_name, start_date, end_date, dept_id) VALUES
('Employee Benefits Upgrade', '2024-01-01', '2024-06-01', 1),
('Cybersecurity Enhancement', '2024-02-01', '2024-08-01', 2),
('Financial Audit System', '2024-03-01', '2024-09-01', 3),
('Marketing Campaign Q2', '2024-04-01', '2024-07-01', 4)
ON CONFLICT DO NOTHING;

-- 8️⃣ Verify data
SELECT * FROM ganesh;
SELECT * FROM department_4;
SELECT * FROM reddy;
