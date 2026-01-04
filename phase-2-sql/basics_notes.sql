/*
====================================================
 Phase 2 – SQL Basics
 Purpose:
   - Practice basic SQL queries
   - Understand syntax using comments
 Notes:
   - Comments are added only for understanding
   - Queries are written for learning purposes
====================================================
*/

-- -------------------------------------------------
-- 1. CREATE TABLE
-- Used to create a new table
-- -------------------------------------------------

CREATE TABLE customer (
    Cust_ID INT,
    name VARCHAR(100),
    sign VARCHAR(10)
);


-- -------------------------------------------------
-- 2. SELECT
-- Used to display or view data from a table
-- -------------------------------------------------

-- Select all columns
SELECT * FROM a;

-- Select specific columns
SELECT id, name FROM b;

-- Select distinct entries only
SELECT DISTINCT id, name FROM c;


-- -------------------------------------------------
-- 3. WHERE
-- Used to filter records based on conditions
-- -------------------------------------------------

-- Filter records by department
SELECT * FROM a
WHERE dept = 'CSE';

-- Filter records using multiple conditions
SELECT * FROM a
WHERE dept = 'CSE' AND iq >= 140;


-- -------------------------------------------------
-- 4. ORDER BY
-- Used to sort data in ascending or descending order
-- Default order is ascending
-- Priority is left-to-right
-- -------------------------------------------------

-- Order by multiple columns
SELECT * FROM a
ORDER BY id, name;

-- Order in descending order
SELECT * FROM a
ORDER BY id DESC;


-- -------------------------------------------------
-- 5. INSERT
-- Used to insert entries into a table
-- -------------------------------------------------

INSERT INTO customer (Cust_ID, name, sign)
VALUES
    (1, 'a', 'a1'),
    (2, 'b', 'b1'),
    (3, 'c', 'c1');


-- -------------------------------------------------
-- 6. UPDATE
-- Used to update existing values in a table
-- Always use WHERE to avoid updating all rows
-- -------------------------------------------------

UPDATE customer
SET Cust_ID = 4,
    name = 'd'
WHERE sign = 'a1';


-- -------------------------------------------------
-- 7. DELETE
-- Used to delete existing values from a table
-- -------------------------------------------------

DELETE FROM customer
WHERE Cust_ID = 4;


-- -------------------------------------------------
-- 8. ALTER TABLE
-- Used to add, drop, or modify columns
-- -------------------------------------------------

-- Add a new column
ALTER TABLE customer
ADD cust_rating INT;

-- Drop an existing column
ALTER TABLE customer
DROP sign;

-- Rename a column
ALTER TABLE customer
RENAME COLUMN Cust_ID TO cust_id;

-- Modify column datatype
ALTER TABLE customer
ALTER COLUMN cust_id TYPE INT;


-- -------------------------------------------------
-- 9. DROP TABLE
-- Used to delete the table completely
-- -------------------------------------------------

DROP TABLE customer;


-- -------------------------------------------------
-- 10. TRUNCATE TABLE
-- Used to delete all data but keep table structure
-- -------------------------------------------------

TRUNCATE TABLE customer;


-- -------------------------------------------------
-- 11. GROUP BY
-- Used to group rows that have the same values
-- Often used with aggregate functions
-- -------------------------------------------------

-- Count number of students in each department
SELECT dept, COUNT(*) AS student_count
FROM a
GROUP BY dept;

-- Average IQ per department
SELECT dept, AVG(iq) AS avg_iq
FROM a
GROUP BY dept;


-- -------------------------------------------------
-- 12. HAVING
-- Used to filter groups after GROUP BY
-- HAVING works on aggregated data
-- -------------------------------------------------

-- Departments having more than 5 students
SELECT dept, COUNT(*) AS student_count
FROM a
GROUP BY dept
HAVING COUNT(*) > 5;

-- Departments with average IQ greater than 120
SELECT dept, AVG(iq) AS avg_iq
FROM a
GROUP BY dept
HAVING AVG(iq) > 120;


-- -------------------------------------------------
-- 13. LIMIT
-- Used to restrict the number of rows returned
-- -------------------------------------------------

-- Fetch only first 5 records
SELECT *
FROM a
LIMIT 5;

-- Fetch top 3 highest IQ students
SELECT *
FROM a
ORDER BY iq DESC
LIMIT 3;


-- -------------------------------------------------
-- 14. OFFSET
-- Used to skip a given number of rows
-- Mostly used with LIMIT
-- -------------------------------------------------

-- Skip first 5 records and fetch next 5
SELECT *
FROM a
LIMIT 5 OFFSET 5;

-- Pagination example (page 2, page size = 3)
SELECT *
FROM a
ORDER BY Cust_ID
LIMIT 3 OFFSET 3;

