/*
#1.INTRODUCTION
 Index-index is ordered representation of the indexed data.
  Indexing makes reading faster and writing fast.
## B-tree = Balanced Tree(Some features: leaf nodes at same level , leaf nodes connectedd as doubly linked list
   ROWID= Database internal identifier that identifies particular row in a table.(This is not your primary key).
   Why B- tree-
    Searching val;ue is very fast.
    It scales very well as logrithmic scalablity

# Access Types;(How ddatabase is going to access our data)
 ## 1. CONST/EQ_REF-Performs B-tree traversal to perform to find a single value.(basically a binary search)
                             Super fast but can only use when you guarnty uniqueness(There is only one unique result).

 ## 2. REF/RANGE -Performs B-tree traversal and they find a starting index to  and than start scanning from that starting index and stops if it does not find the value that does not meet the criteria.

## 3. Index - Full scan( Start from first node and do till last leaf node)
 ## 4.ALL - A full table scan . Loa every row and column of the table in memory than scan each and every(very bad).

indexing is a developer level concert not someone using queries on database .
indexes are made according to query and table. To design this you know how the database is fetched and used.
Indexes Are Selective: You don’t want an index on every column. While indexes speed up reads, they slow down writes because the index must be updated on inserts/updates/deletes. 
Medium

Query Optimization: Developers should use tools like EXPLAIN to see how queries use indexes (e.g., full table scan vs. index range scan). 
Medium

Common Pitfalls – Function Use: Applying functions (e.g., YEAR(date)) on indexed columns can disable index usage, because the function output might no longer be ordered. 
Medium

Index Bounds: Using range queries (e.g., BETWEEN) affects how far an index can be used, and the optimizer may choose table scans if the index isn’t helpful. 
Medium

Multi-Column Index Order Matters: In composite indexes, fields are ordered left-to-right; indexes are most effective when the query filters start with the leftmost indexed field


/* ============================================================================
   EXAMPLE: Index Exists but Query Is Still Slow (Function on Indexed Column)
   Source Context: Database Indexing Talk (Kai Sassnowski)
   ============================================================================

   PROBLEM STATEMENT:
   An index exists on a date column, but the query does not use the index
   and performs a full table scan, resulting in poor performance.

   ---------------------------------------------------------------------------
   TABLE (Conceptual):
   orders(id, order_date, amount)

   INDEX:
   An index is created on the order_date column.
   The database stores order_date values in sorted order using a B-tree.
   ---------------------------------------------------------------------------

   BAD QUERY:
   The query applies a function directly on the indexed column.

   WHERE YEAR(order_date) = 2023

   ---------------------------------------------------------------------------
   WHY THIS QUERY IS BAD:
   - B-tree indexes store raw column values, not computed values.
   - Applying YEAR(order_date) transforms the column value.
   - The database must evaluate YEAR(order_date) for every row.
   - Index ordering becomes unusable for filtering.
   - Result: FULL TABLE SCAN instead of INDEX SCAN.

   ---------------------------------------------------------------------------
   KEY INSIGHT:
   Index existence alone does NOT guarantee index usage.
   Query structure determines whether the optimizer can use the index.

   ---------------------------------------------------------------------------
   PERFORMANCE IMPACT:
   - Full table scan: O(n) time complexity.
   - Query becomes slower as table size grows.
   - Extremely dangerous on large production tables.

   ---------------------------------------------------------------------------
   GOOD QUERY:
   Rewrite the condition using range-based filtering.

   WHERE order_date >= '2023-01-01'
     AND order_date <  '2024-01-01'

   ---------------------------------------------------------------------------
   WHY THIS QUERY WORKS:
   - No function is applied to the indexed column.
   - Range conditions preserve index ordering.
   - Database performs an INDEX RANGE SCAN.
   - Only relevant rows are scanned.

   ---------------------------------------------------------------------------
   EXECUTION PLAN (Conceptual):
   Bad Query  -> Sequential Scan (Index Ignored)
   Good Query -> Index Range Scan (Index Used)

   ---------------------------------------------------------------------------
   GOLDEN RULE:
   Never apply functions on indexed columns in the WHERE clause.
   Always rewrite queries so that indexed columns remain unchanged.

   ---------------------------------------------------------------------------
   COMMON FUNCTIONS THAT BREAK INDEX USAGE:
   YEAR(), MONTH(), DATE(), LOWER(), UPPER(), CAST(), SUBSTRING(), TRIM()

   ---------------------------------------------------------------------------
   BEST PRACTICES:
   1. Index raw columns, not expressions.
   2. Avoid functions on indexed columns in WHERE.
   3. Use range predicates for date/time filtering.
   4. Transform constants, not columns.
   5. Always verify index usage using EXPLAIN / EXPLAIN ANALYZE.

   ---------------------------------------------------------------------------
   INTERVIEW ONE-LINER:
   Applying a function on an indexed column disables index usage
   and forces a full table scan.

   ---------------------------------------------------------------------------
   REAL-WORLD TAKEAWAY:
   This mistake is a very common cause of "index exists but query is slow"
   issues in real production systems.
============================================================================ */


*
================================================================================
 REFERENCES
================================================================================
- Kai Sassnowski – Indexing Talk:
- https://youtu.be/HubezKbFL7E?si=HJaLc32ay3nl5-f6
================================================================================
*/


                    













*/
