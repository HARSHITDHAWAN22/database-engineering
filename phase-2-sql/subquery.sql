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


-- --------------------------------------------------------------------------------------
-- Subquery 1
-- example- salary of people having salary greater than average salary 
-- We can use it in : Select, From, Where, Having, SQL query, insert, update, delete
-- ---------------------------------------------------------------------------------------

SELECT salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);


-- --------------------------------------------------------------------------
-- In SQL we have 3 types of subquery
-- 1. Scalar subquery
-- 2. Multiple row subquery
-- 3. Correlated subquery
-- --------------------------------------------------------------------------


-- --------------------------------------------------------------------------
-- 1. Scalar Subquery
-- Return one record (1 row and 1 column)
-- --------------------------------------------------------------------------

SELECT salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);


-- --------------------------------------------------------------------------
-- 2. Multiple row Subquery (it also has 2 types) 
-- 2.1 Returns multiple rows and multiple columns
-- 2.2 Returns multiple rows and single column
-- --------------------------------------------------------------------------

-- 2.1 Returns multiple rows and multiple columns
SELECT dept_name, MAX(salary)
FROM employee
GROUP BY dept_name;


-- 2.2 Returns multiple rows and single column
SELECT dept_name
FROM employee
WHERE dept_name NOT IN (
    SELECT DISTINCT dept_name
    FROM employee
);


-- ----------------------------------------------------------------------------------------------------------------
-- 3. Correlated subquery
-- Subquery that is related to the outer query
-- Use joins if possible because correlated subqueries are relatively expensive
-- ----------------------------------------------------------------------------------------------------------------

SELECT name
FROM employee e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employee e2
    WHERE e1.dept_name = e2.dept_name
);


-- another example
SELECT *
FROM employee e
WHERE NOT EXISTS (
    SELECT 1
    FROM employee d
    WHERE d.dept_name = e.dept_name
);


-- --------------------------------------------------------------------------
-- Subquery inside subquery
-- --------------------------------------------------------------------------

SELECT *
FROM (
    SELECT store_name, SUM(price) AS total_sales
    FROM sales
    GROUP BY store_name
) sales
JOIN (
    SELECT AVG(total_sales) AS avg_total_sales
    FROM (
        SELECT SUM(price) AS total_sales
        FROM sales
        GROUP BY store_name
    ) x
) avg_sales
ON sales.total_sales > avg_sales.avg_total_sales;


-- --------------------------------------------------------------------------
-- When using the same subquery multiple times, use it with WITH (CTE)
-- --------------------------------------------------------------------------

WITH sales_cte AS (
    SELECT store_name, SUM(price) AS total_sales
    FROM sales
    GROUP BY store_name
)
SELECT *
FROM sales_cte
JOIN (
    SELECT AVG(total_sales) AS avg_total_sales
    FROM sales_cte
) avg_sales
ON sales_cte.total_sales > avg_sales.avg_total_sales;


-- --------------------------------------------------------------------------
-- RECURSIVE CTE
-- Used for hierarchical / tree-like data
-- Example: Employee → Manager hierarchy
-- --------------------------------------------------------------------------

WITH RECURSIVE employee_hierarchy AS (
    -- Anchor query (top-level manager)
    SELECT emp_id, name, manager_id
    FROM employee
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive query
    SELECT e.emp_id, e.name, e.manager_id
    FROM employee e
    INNER JOIN employee_hierarchy eh
    ON e.manager_id = eh.emp_id
)
SELECT *
FROM employee_hierarchy;


-- --------------------------------------------------------------------------
-- Another Recursive CTE Example
-- Example: Parent → Child relationship
-- --------------------------------------------------------------------------

WITH RECURSIVE family_tree AS (
    SELECT child_id, name, parent_id
    FROM family
    WHERE parent_id IS NULL

    UNION ALL

    SELECT f.child_id, f.name, f.parent_id
    FROM family f
    JOIN family_tree ft
    ON f.parent_id = ft.child_id
)
SELECT *
FROM family_tree;


-- --------------------------------------------------------------------------
-- TEMPORARY TABLE
-- Used to store intermediate results temporarily
-- Exists only for the current session
-- --------------------------------------------------------------------------

CREATE TEMPORARY TABLE temp_sales AS
SELECT store_name, SUM(price) AS total_sales
FROM sales
GROUP BY store_name;


-- --------------------------------------------------------------------------
-- Query using TEMPORARY TABLE
-- --------------------------------------------------------------------------

SELECT *
FROM temp_sales
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM temp_sales
);


-- --------------------------------------------------------------------------
-- Drop TEMPORARY TABLE (optional, auto-dropped at session end)
-- --------------------------------------------------------------------------

DROP TEMPORARY TABLE temp_sales;
