/*
====================================================
 Phase 3-database internals
 Purpose:
   - Unerstand the database internals.
   - Understand their implemantation
====================================================
*/

-- ========================================================================================================
-- ACID PROPERTIES:
--These are fundamental properties that each database and transaction should hold internally
-- ========================================================================================================

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.Atomicity
-- Either all or nothing.
-- If transaction fail at any point before complete execution(commit) than we rollback all the steps to transaction executed and can be restarted again .
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

START TRANSACTION;

UPDATE bank_accounts
SET balance = balance - 1000
WHERE account_id = 1;

UPDATE bank_accounts
SET balance = balance + 1000
WHERE account_id = 2;

COMMIT;

-- if failure at any point before commit
ROLLBACK;


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.Consistency
-- After a transaction is completly completed than sum of total money should remain same as before the transaction start.
-- Rules must not break.
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE bank_accounts
ADD CONSTRAINT balance_check CHECK (balance >= 0);

START TRANSACTION;

UPDATE bank_accounts
SET balance = balance - 10000
WHERE account_id = 1;

COMMIT;


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.Isolation
-- Multiple transactions are happening in parallel manner . Than we convert a parallel schdule in serial schedule.
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION;

UPDATE bank_accounts
SET balance = balance - 500
WHERE account_id = 1;

COMMIT;



-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4.Durablity
-- All the changes done in a database must be permanent.
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

START TRANSACTION;

UPDATE bank_accounts
SET balance = 8000
WHERE account_id = 1;

COMMIT;


-- -----------------------------------------------------------------
-- Schedule
-- Chronological execution order of multiple transaction.
-- 2 types of scheule :1.Serial , 2.parallel
-- ------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------------------------------------
-- 1.Serial : 1 transaction start when it will end than only other transaction will start.Example: ATM.
-- provides consistency but not so efficient.Poor throughput
-- ------------------------------------------------------------------------------------------------------------------------------


-- ----------------------------------------------------------------------------------------------------------------------------
-- 2.Parallel schedule : Multiple transaction and come and execute at the same time. Example :upi payments.
-- Good throughput but it also have some problems
-- Problems with concurrency : Dirty read, incorrect summary,Loss update ,unrepeatable,Phantom read.
-- -----------------------------------------------------------------------------------------------------------------------------


-- -----------------------------------------------------------------
-- Cascading Rollback & Recoverability
-- -----------------------------------------------------------------

-- Cascading Rollback:
-- Occurs when one transaction reads uncommitted data of another transaction.
-- If the first transaction fails, all dependent transactions must rollback.
-- This causes chain rollback of multiple transactions.
-- Cascading rollback is bad for performance and recovery.

-- Reason:
-- Dirty Read (reading uncommitted data)

-- -----------------------------------------------------------------

-- Cascadeless Schedule:
-- A schedule where transactions read only committed data.
-- Prevents cascading rollback completely.
-- Safer than cascading schedules.

-- Isolation Level:
-- Read Committed ensures cascadeless schedule.

-- -----------------------------------------------------------------
-- Recoverable Schedule:
-- A schedule is recoverable if a transaction commits
-- only after the transactions it depends on have committed.
-- Ensures database can recover correctly after failure.

-- Note:
-- Recoverable schedule may still allow dirty reads.
-- Cascadeless schedules are always recoverable.

-- -----------------------------------------------------------------
-- Comparison:
-- Cascading    -> Rollbacks propagate
-- Cascadeless  -> No uncommitted reads
-- Recoverable  -> Safe commit order
-- -----------------------------------------------------------------


-- -----------------------------------------------------------------
-- Conflict Serializability & Precedence Graph
-- -----------------------------------------------------------------

-- Conflict Serializability:
-- A schedule is conflict serializable if it can be converted
-- into a serial schedule by swapping non-conflicting operations.

-- Conflicting operations:
-- - Read–Write
-- - Write–Read
-- - Write–Write
-- (on the same data item and from different transactions)

-- Non-conflicting operations can be swapped safely.

-- -----------------------------------------------------------------

-- Precedence (Serialization) Graph:
-- Used to check conflict serializability of a schedule.

-- Graph Rules:
-- - Each node represents a transaction.
-- - Add an edge T1 -> T2 if:
--   T1 has a conflicting operation that occurs before T2.

-- Decision Rule:
-- - If the precedence graph has NO cycle → schedule is conflict serializable.
-- - If the precedence graph has a cycle → schedule is NOT conflict serializable.

-- -----------------------------------------------------------------
-- Key Point:
-- Conflict serializability focuses only on the order of conflicting operations.

-- -----------------------------------------------------------------------
-- A schedule is conflict serializable if its precedence graph is acyclic.
-- ------------------------------------------------------------------------


-- -----------------------------------------------------------------
-- LOCKS (Concurrency Control)
-- -----------------------------------------------------------------

-- Locks are used to control concurrent access to data
-- and to maintain isolation between transactions.

-- -----------------------------------------------------------------
-- Types of Locks
-- -----------------------------------------------------------------

-- 1. Shared Lock (S / Read Lock):
-- - Applied when a transaction reads data.
-- - Multiple transactions can hold shared locks at the same time.
-- - Prevents write operations on the locked data.

-- 2. Exclusive Lock (X / Write Lock):
-- - Applied when a transaction modifies data.
-- - Only one transaction can hold an exclusive lock.
-- - Blocks both reads and writes by other transactions.

-- -----------------------------------------------------------------
-- Locking Behavior
-- -----------------------------------------------------------------

-- Read operation   -> Shared Lock
-- Write operation  -> Exclusive Lock

-- Locks are released when:
-- - Transaction COMMITs
-- - Transaction ROLLBACKs

-- -----------------------------------------------------------------
-- Deadlock
-- -----------------------------------------------------------------

-- Deadlock occurs when:
-- - Transaction T1 holds a lock and waits for a lock held by T2
-- - Transaction T2 holds a lock and waits for a lock held by T1

-- Result:
-- - Both transactions wait forever

-- Handling:
-- - Database detects deadlock
-- - One transaction is aborted to break the cycle

-- -----------------------------------------------------------------
-- Locks and Isolation Levels
-- -----------------------------------------------------------------

-- Read Committed:
-- - Short-duration shared locks

-- Repeatable Read:
-- - Shared locks held till transaction ends

-- Serializable:
-- - Strict locking (serial execution behavior)

-- -----------------------------------------------------------------
-- Key Point:
-- Locks ensure isolation but can reduce concurrency
-- and may cause deadlocks.

-- -----------------------------------------------------------------
-- Interview One-Liner:
-- Locks control concurrent data access and enforce isolation,
-- while deadlocks occur due to cyclic lock dependencies.
-- -----------------------------------------------------------------




















