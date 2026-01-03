# Phase 1 – Relational Database Foundations (Learning Notes)

> These notes are written as part of my learning process to understand
> how relational databases work from the basics before moving to SQL,
> ML pipelines, and system-level databases.

---

## Why Databases Exist

Before databases, data was stored in files.  
This approach breaks down very quickly because:

- Same data gets stored multiple times (redundancy)
- Data becomes inconsistent across files
- Multiple users cannot safely access data at the same time
- No proper security mechanism
- No reliable way to recover data after a crash

A **DBMS** solves these issues by:
- Organizing data in a structured way
- Enforcing rules on data using constraints
- Handling concurrent access
- Supporting transactions
- Providing backup and recovery mechanisms

---

## Database vs DBMS vs RDBMS

- **Database**  
  A collection of related data.

- **DBMS (Database Management System)**  
  Software used to store, manage, and retrieve data from a database.

- **RDBMS (Relational DBMS)**  
  A DBMS that follows the relational model using tables, keys, and constraints.

Examples:
- PostgreSQL, MySQL → RDBMS  
- MongoDB → NoSQL DBMS

---

## Relational Model

The relational model organizes data in the form of tables.

Basic terminology:
- **Relation** → Table  
- **Tuple** → Row  
- **Attribute** → Column  
- **Domain** → Allowed values for a column  
- **Degree** → Number of columns  
- **Cardinality** → Number of rows  

The relational model helps in:
- Maintaining data consistency
- Defining a clear structure (schema)
- Querying data easily using SQL

This structure is especially important when data is later used for analytics or ML.

---

## Keys in DBMS

Keys uniquely identify data and maintain relationships.

- **Primary Key**
  - Uniquely identifies each record
  - Cannot be NULL

- **Candidate Key**
  - Possible choices for primary key

- **Composite Key**
  - Combination of multiple columns acting as a key

- **Foreign Key**
  - References a primary key from another table
  - Ensures referential integrity

Foreign keys exist mainly to **maintain correct data**, not just to perform joins.

---

## Relationships Between Tables

Tables are connected using relationships:

- One-to-One  
- One-to-Many  
- Many-to-Many  

A many-to-many relationship is always resolved using a **junction table**.

Example:
- Students ↔ Courses  
- Enrollment table connects them

This concept later maps directly to graph-like data structures.

---

## Constraints

Constraints prevent invalid data from entering the database.

- **NOT NULL** → No missing values
- **UNIQUE** → No duplicates
- **CHECK** → Custom validation rules
- **FOREIGN KEY** → Maintains relationships between tables

Good constraints reduce bugs and prevent bad data from affecting downstream systems like ML models.

---

## What is SQL?

- SQL is a **declarative language**
- It is used to interact with relational databases
- We specify *what* data we want, not *how* to retrieve it

SQL is a query language, not a programming language.

---

## Key Takeaways

- Databases are systems, not just tables
- Good schema design is more important than complex queries
- Constraints protect data quality
- Clean and structured data is critical for ML and analytics pipelines

> This phase focuses only on building a strong foundation before moving
> to SQL queries and real-world database usage.
