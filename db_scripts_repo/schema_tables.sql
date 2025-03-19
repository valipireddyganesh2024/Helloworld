-- 1️⃣ Ensure "company" schema exists
CREATE SCHEMA IF NOT EXISTS company;

-- 2️⃣ Create "flowers" table inside the "company" schema
CREATE TABLE IF NOT EXISTS company.flowers (
    id SERIAL PRIMARY KEY,
    flower_name VARCHAR(100) NOT NULL
);

-- 3️⃣ Insert two valid flower names (Success ✅)
INSERT INTO company.flowers (flower_name) VALUES
('Rose'),
('Lily');

-- 4️⃣ Insert two flowers with errors ❌
-- This will fail because we're trying to insert a number into a VARCHAR column
INSERT INTO company.flowers (flower_name) VALUES
(12345);  -- ❌ ERROR: wrong datatype

-- Another error: Trying to insert NULL into a NOT NULL column
INSERT INTO company.flowers (flower_name) VALUES
(NULL);  -- ❌ ERROR: column "flower_name" cannot be NULL

-- 5️⃣ Verify successful insertions
SELECT * FROM company.flowers;
