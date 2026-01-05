/* =============================================================================
   TOPIC: EXPLAIN / EXPLAIN ANALYZE (Query Performance Analysis)
   PURPOSE: Understand how the database actually executes a query
   =============================================================================

   WHAT EXPLAIN DOES:
   EXPLAIN shows the execution plan chosen by the database optimizer.
   It explains how data is accessed, whether indexes are used,
   and the order in which operations are performed.

   -----------------------------------------------------------------------------
   EXPLAIN vs EXPLAIN ANALYZE:
   - EXPLAIN: Displays the planned execution using cost estimates.
   - EXPLAIN ANALYZE: Executes the query and shows real execution time and rows.
   ANALYZE is more accurate but should be avoided on heavy production queries.

   -----------------------------------------------------------------------------
   WHY EXPLAIN IS IMPORTANT:
   Creating an index does not automatically make a query fast.
   EXPLAIN helps confirm whether the optimizer is actually using the index.

   -----------------------------------------------------------------------------
   MOST IMPORTANT THING TO CHECK FIRST:
   Scan Type (this matters more than any other field)

   - Index Scan / Index Range Scan  -> GOOD (efficient index usage)
   - Bitmap Index Scan              -> GOOD (used for larger result sets)
   - Seq Scan / Table Scan          -> BAD for large tables
   - Inddex seek                    -> GOOD(If condtion is known)

   -----------------------------------------------------------------------------
   HOW TO CONFIRM INDEX USAGE:
   - Look for the index name in the execution plan.
   - If no index appears, the optimizer is ignoring the index.

   -----------------------------------------------------------------------------
   COST FIELD (ESTIMATED WORK):
   cost = startup_cost .. total_cost
   These values help the optimizer compare multiple execution plans.
   Cost values are relative and should be compared within the same query.

   -----------------------------------------------------------------------------
   ROWS (ESTIMATION):
   Shows how many rows the optimizer expects to process.
   A large difference between estimated rows and actual rows
   usually indicates outdated statistics or poor selectivity.

   -----------------------------------------------------------------------------
   ACTUAL TIME (EXPLAIN ANALYZE):
   Displays real execution time for each step.
   This is the most reliable indicator of real query performance.

   -----------------------------------------------------------------------------
   COMMON REASONS INDEX IS NOT USED:
   - Functions applied on indexed columns (YEAR, LOWER, CAST, etc.)
   - Data type mismatch between column and condition
   - Low selectivity (too many rows match)
   - Wrong column order in composite indexes
   - Use of NOT IN, !=, or LIKE with a leading wildcard

   -----------------------------------------------------------------------------
   CLASSIC INDEXING MISTAKE:
   Modifying an indexed column in the WHERE clause
   breaks index ordering and forces a full table scan.

   -----------------------------------------------------------------------------
   PRACTICAL QUERY OPTIMIZATION FLOW:
   1. Write the query
   2. Run EXPLAIN
   3. Identify scan type
   4. Verify index usage
   5. Rewrite query or adjust indexes
   6. Re-run EXPLAIN
   7. Use EXPLAIN ANALYZE to validate improvement

   -----------------------------------------------------------------------------
   USING EXPLAIN WITH JOINS:
   - Check join strategy: Nested Loop, Hash Join, Merge Join
   - Ensure join columns are indexed
   - Nested loops without indexes can degrade performance badly

   -----------------------------------------------------------------------------
   RED FLAGS IN EXPLAIN OUTPUT:
   - Sequential scan on a large table
   - Extremely high total cost
   - Filters applied after scanning rows
   - Large gap between estimated and actual row counts

   -----------------------------------------------------------------------------
   CORE IDEA:
   EXPLAIN shows what the database WILL do,
   not what we EXPECT it to do.

   -----------------------------------------------------------------------------
   INTERVIEW ONE-LINER:
   EXPLAIN is used to analyze query execution plans
   and to check whether indexes are effectively used.

   -----------------------------------------------------------------------------
   FINAL TAKEAWAY:
   When a query is slow, always inspect EXPLAIN first
   before changing indexes or rewriting application logic.
============================================================================= 


   =============================================================================
   ADDITIONAL NOTES: EXECUTION PLAN (PRACTICAL UNDERSTANDING)
   =============================================================================

   QUERY ORDER VS EXECUTION ORDER:
   SQL is written in a fixed order, but the database executes it
   based on the optimizer’s plan. Execution plans show the real order
   in which scans, joins, and filters actually run.

   -----------------------------------------------------------------------------
   DEPENDENCE ON STATISTICS:
   Execution plans are created using table statistics.
   If statistics are outdated or inaccurate, the optimizer may choose
   a slow or inefficient plan.

   -----------------------------------------------------------------------------
   WHERE FILTER IS APPLIED MATTERS:
   Filters applied during index scan are efficient.
   Filters applied after rows are fetched indicate extra unnecessary work.

   -----------------------------------------------------------------------------
   SORT OPERATIONS IN PLANS:
   If ORDER BY cannot be satisfied using an index,
   the database performs an explicit sort step.
   Sorting large datasets is costly and clearly visible in plans.

   -----------------------------------------------------------------------------
   EFFECT OF LIMIT:
   LIMIT allows the database to stop scanning early.
   When combined with ORDER BY and proper indexing,
   it can significantly reduce query execution time.

   -----------------------------------------------------------------------------
   PARALLEL EXECUTION:
   Some execution plans show parallel scans or joins.
   This means the database is using multiple CPU cores
   to speed up query execution.

   -----------------------------------------------------------------------------
   WHY PLANS CHANGE OVER TIME:
   Execution plans are not fixed.
   They can change as data size grows, data distribution changes,
   or statistics are refreshed.

   -----------------------------------------------------------------------------
   OPTIMIZER OBJECTIVE:
   The optimizer does not try to make SQL “correct” —
   correctness is already guaranteed.
   Its only goal is to reduce total execution cost.

   -----------------------------------------------------------------------------
   PRACTICAL RULE OF THUMB:
   Never assume a query is optimized.
   Always compare execution plans before and after making changes.
  =============================================================================  */

