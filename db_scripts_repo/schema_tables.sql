-- 1️⃣ Create a new schema
CREATE SCHEMA IF NOT EXISTS new_schema AUTHORIZATION postgres;

-- 2️⃣ Switch to the new schema
SET search_path TO new_schema;

-- 3️⃣ Create a sample table
CREATE TABLE IF NOT EXISTS employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4️⃣ Insert sample data
INSERT INTO employees (name, department, salary) VALUES
('Alice Johnson', 'HR', 60000),
('Bob Smith', 'IT', 75000),
('Charlie Davis', 'Finance', 70000);

-- 5️⃣ Verify inserted data
SELECT * FROM employees;
