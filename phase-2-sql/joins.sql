/*
====================================================
 Phase 2- joins
  joins- Joins are used to join multiple tables together when we need to fetch details from multiple tables together in single query.There are several different types of joins.
 Purpose - Practice different types of joins SQL queries.
         - Understand syntax using comments
 Notes:
   - Comments are added only for understanding
   - Queries are written for learning purposes
====================================================
*/

-- -------------------------------------------------------------------
-- 1.Inner JOIN/JOIN
-- Fetch the records that both the table(tables joined) have.
-- -------------------------------------------------------------------

Select e.emp_name, d.dept_name 
from employee e inner join department d on e.id= d.de_id ;


-- -------------------------------------------------------------------------------------------------------
-- 2.Left JOIN
-- Fetch the records for all the records in 1st table and may or may not be present in other table.
-- First it does inner JOIN than checks the left table if any of the record left out than it fetches them.
-- --------------------------------------------------------------------------------------------------------

Select e.emp_name , d.dept_name
from employee e left join department d on e.id= d.de_id;


-- -------------------------------------------------------------------------------------------------------
-- 3.Right JOIN
-- Fetch the records for all the records in right table and may or may not be present in other table.
-- First it does inner JOIN than checks the right table if any of the record left out than it fetches them.
-- --------------------------------------------------------------------------------------------------------

Select e.emp_name , d.dept_name
from employee e right Join department d on e.id= d.de_id;


-- -------------------------------------------------------------------------------------------------------
-- Combining multiple tables and multiple joins(Example query)
-- -------------------------------------------------------------------------------------------------------

Select e.emp_name , d.dept_name , m.manager_name
from employee e inner join department d on e.id=d.de_id
left join manager m on e.id=m.m_id ;


-- -------------------------------------------------------------------------------------------------------
-- 4.Full JOIN
-- Fetch the union of records from both the table on some condition.
-- -------------------------------------------------------------------------------------------------------

Select e.emp_name , d.dept_name
from employee e
FULL JOIN department d on e.id=d.de_id;


-- -------------------------------------------------------------------------------------------------------
-- 5.Cross JOIN
-- Fecth all the records to left table matching by all the records of right table
-- (if left table has n records and right table has m records than output is n*m records)(Used when there is no condition to join the tables.)
-- -------------------------------------------------------------------------------------------------------

Select e.emp_name , c.company_name, c.company_location
from employee e
cross join company c ;


-- -----------------------------------------------------------------------------------------------------------------
-- 6.Natural JOIN
-- Fetch all the recods like inner join but condtion on which join should happen will be decided by sql it self
-- This is generally done by same column names and thats why we don't use it in general cases.
-- -----------------------------------------------------------------------------------------------------------------

Select e.emp_name,d.dept_name
from employee e
natural join department d ;


-- -----------------------------------------------------------------------------------------------------------------
-- 7.Self JOIN
-- To join the table from itself (It has tricky join conditions).
-- Also can apply any kind of above join to self.
-- -----------------------------------------------------------------------------------------------------------------

Select child.name as child_name ,
parent.name as parent_name
from family as child 
join family as parent on child.parent_id = parent.child_id ;











