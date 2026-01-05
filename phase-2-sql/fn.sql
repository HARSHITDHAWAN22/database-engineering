/*
========================================================================================================
 Phase 2 – SQL Basics
 Purpose:
   - Practice basic SQL queries
   - Understand syntax using comments
 Notes:
   - Comments are added only for understanding
   - Queries are written for learning purposes
   - Tables/schemas used are private(queries only for undderstanding).
========================================================================================================
*/

-- -----------------------------------------------------------------------------------------------------------------------
-- Window Functions
-- Window functions perform calculations across a set of rows related to the current row, without collapsing rows.
-- -----------------------------------------------------------------------------------------------------------------------

-- Example
Select e.*,
max(salary) over(partition by  dept_name)
from employee e ;

-- ---------------------------
-- 1.row_number
-- fetch row number(no duplicates).
-- ---------------------------
Select e.*,
row_number() over(partition by dept_name order by salary desc) as rn
from employee e;

--Example = to fetch first to employees from each department
Select * from (
  Select e.*,
row_number() over(partition by dept_name order by salary desc) as rn
from employee e) x
where x.rn<3 ;


-- ------------------------------
-- 2.Rank
-- Fetch rank(allow gaps, can have duplicates)
-- ------------------------------

--Example= To fetch top 3 highest salary in each department ;
Select e.* from(
    select e.* ,
   rank() over(partition by dept_name order by salary desc)as rnk
  from employee e ) x
    where x.rnk<4 ;


-- -----------------------------------------------
-- 3.Dense_rank
-- Fetch rank(but no gaps,can have duplicates)
-- -----------------------------------------------

--Example -To fetch top 3 salaried employees 
 select e.* ,
   dense_rank() over(partition by dept_name order by salary desc)as dense_rnk
  from employee e ;


-- ---------------------------------------------------------------------------------------------------------------------------
-- 4.Lag()
-- To fetch previous record in the table or we can mention how much row prior and also set default value for null entries.
-- Can be used to make comparisons.
-- ---------------------------------------------------------------------------------------------------------------------------

--Example -To fetch 2 prior salary
Select e.*,
lag(salary ,2,0) over(partition by dept_name order by emp_id) as prev_emp_sal
from employee e;


-- ---------------------------------------------------------------------------------------------------------------------------
-- 4.Lead()
-- To fetch next record in the table or we can mention how much rows ahead and also set default value for null entries.
-- Can be used to make comparisons.
-- ---------------------------------------------------------------------------------------------------------------------------

--Example -To fetch 2 ahead emp_id salary
Select e.*,
lead(salary ,2,0) over(partition by dept_name order by emp_id) as post_emp_sal
from employee e;

-- -----------------------------
-- On another table proucts
-- ----------------------------
-- ---------------------------------------------------------------------------------------------------------------------------
-- 5.First_value()
-- Fetch the value of first product in each partition
-- ---------------------------------------------------------------------------------------------------------------------------

--Example - fetch  first product of each category
Select e.*,
First_value(product_name) over(partition by product_category order by price desc) as fp
from proucts e;


-- ---------------------------------------------------------------------------------------------------------------------------
-- 5.Last_value()
-- Fetch the value of first product in each partition(Also need to define frame clause)( unbounded preceding and current row- this is default  no need to write this).
-- Without proper frame clause, it may return the current row value instead of the true last value.
-- Frame Clause: Defines the range of rows considered for a window function calculation.
-- ROWS behavior:
-- ROWS treats duplicate ORDER BY values as separate rows.
-- RANGE behavior:
-- RANGE groups all rows having the same ORDER BY value together.
-- ---------------------------------------------------------------------------------------------------------------------------

--Example - fetch last product of each category
Select e.*,
last_value(product_name) over(partition by product_category order by desc range between ROWS unbounded preceding and current row following ) as fp
from product e;










