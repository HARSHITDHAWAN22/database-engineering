/* =============================================================================
   TOPIC: DATABASE RECOVERY (BASIC IDEA)
   =============================================================================

   WHAT IS RECOVERY:
   Database recovery is the process of bringing the database back
   to a consistent and correct state after a failure.

   -----------------------------------------------------------------------------
   WHY RECOVERY IS NEEDED:
   Failures can happen due to:
   - System crash
   - Power failure
   - Software error
   - Hardware failure

   Without recovery, data may become inconsistent or partially updated.

   -----------------------------------------------------------------------------
   MAIN GOAL OF RECOVERY:
   - Ensure committed transactions are not lost
   - Ensure incomplete transactions do not affect the database

   -----------------------------------------------------------------------------
   TYPES OF FAILURES:
   - Transaction failure: logical error or constraint violation
   - System failure: crash, power loss
   - Disk failure: data loss on storage device

   -----------------------------------------------------------------------------
   RECOVERY AND ACID:
   - Atomicity: incomplete transactions must be rolled back
   - Durability: committed transactions must survive failures

   -----------------------------------------------------------------------------
   BASIC RECOVERY IDEA:
   Database uses logs to track changes
   and uses them to restore consistency after a crash.
  ============================================================================= 


   ============================================================================
   TOPIC: WRITE-AHEAD LOGGING (WAL) / WRITE-AHEAD RECOVERY
   =============================================================================

   CORE CONCEPT:
   Write-Ahead Logging means:
   "Changes are written to the log before they are written to disk."

   -----------------------------------------------------------------------------
   SIMPLE RULE (VERY IMPORTANT):
   Log first, data later.

   -----------------------------------------------------------------------------
   WHY WAL IS USED:
   Disk writes are slow and unsafe during crashes.
   Logs provide a reliable way to recover changes.
   Point in time recovery possible.(Good for automation testing).

   -----------------------------------------------------------------------------
   HOW WAL WORKS (STEP BY STEP):
   1. Transaction modifies data in memory
   2. Change is written to the log file
   3. COMMIT record is written to the log
   4. Actual data pages are written to disk later

   -----------------------------------------------------------------------------
   WHAT HAPPENS DURING A CRASH:
   Database checks the log during recovery.

   - If COMMIT is present → transaction is REDONE
   - If COMMIT is missing → transaction is UNDONE

   -----------------------------------------------------------------------------
   REDO OPERATION:
   Applied to committed transactions.
   Ensures durability by reapplying changes from the log.

   -----------------------------------------------------------------------------
   UNDO OPERATION:
   Applied to uncommitted transactions.
   Ensures atomicity by rolling back partial changes.

   -----------------------------------------------------------------------------
   ROLE OF CHECKPOINTS:
   Checkpoints mark a safe position in the log.
   They reduce the amount of log that must be scanned during recovery.

   -----------------------------------------------------------------------------
   WHY LOGGING IS EFFICIENT:
   Log writes are sequential and fast.
   Data page writes are random and slower.

   -----------------------------------------------------------------------------
   RECOVERY PROCESS SUMMARY:
   1. Start from last checkpoint
   2. REDO all committed transactions
   3. UNDO all incomplete transactions
   4. Database reaches a consistent state

   -----------------------------------------------------------------------------
   FINAL TAKEAWAY:
   Write-Ahead Logging guarantees that
   committed data is never lost and
   incomplete transactions never corrupt the database.
   ============================================================================= 


   =============================================================================
   TOPIC: LOG FILE STRUCTURE (FOR RECOVERY & WAL)
   =============================================================================

   WHAT IS A LOG FILE:
   A log file is an append-only record that stores information
   about all changes made by transactions in the database.

   -----------------------------------------------------------------------------
   WHY LOG FILE STRUCTURE MATTERS:
   Recovery depends completely on the log.
   A well-structured log allows the database to REDO or UNDO changes correctly
   after a crash.

   -----------------------------------------------------------------------------
   BASIC LOG RECORD CONTENTS:
   Each log entry usually contains:
   - Transaction ID
   - Type of operation (UPDATE / COMMIT / ABORT)
   - Data item affected
   - Old value (before change)
   - New value (after change)

   -----------------------------------------------------------------------------
   COMMON TYPES OF LOG RECORDS:

   1. START RECORD:
      Indicates that a transaction has started.
      Used to track active transactions during recovery.

   2. UPDATE RECORD:
      Stores both old value and new value of data.
      Enables UNDO (using old value) and REDO (using new value).

   3. COMMIT RECORD:
      Marks successful completion of a transaction.
      Guarantees durability of the transaction.

   4. ABORT RECORD:
      Marks that a transaction has been rolled back.
      No REDO is needed for this transaction.

   -----------------------------------------------------------------------------
   WRITE-AHEAD RULE IN LOG STRUCTURE:
   Update log record must be written to disk
   BEFORE the corresponding data page is written to disk.

   -----------------------------------------------------------------------------
   REDO AND UNDO SUPPORT:
   - Old value  → used for UNDO
   - New value  → used for REDO
   Log structure must store both to support crash recovery.

   -----------------------------------------------------------------------------
   CHECKPOINT RECORD:
   A checkpoint log entry indicates a safe point.
   It reduces recovery time by limiting how far back the log is scanned.

   -----------------------------------------------------------------------------
   LOG SEQUENCE NUMBER (LSN):
   Each log record is assigned an increasing LSN.
   LSN helps maintain the correct order of operations during recovery.

   -----------------------------------------------------------------------------
   HOW LOG IS USED DURING RECOVERY:
   - Scan log from last checkpoint
   - Identify committed transactions → REDO
   - Identify incomplete transactions → UNDO

   -----------------------------------------------------------------------------
   IMPORTANT PRACTICAL NOTE:
   Log files are written sequentially, which makes logging fast.
   This is one major reason databases rely heavily on logging.

   -----------------------------------------------------------------------------
   FINAL TAKEAWAY:
   Log file structure is the backbone of database recovery.
   Without a properly designed log, WAL and recovery cannot work.
  ============================================================================= */



