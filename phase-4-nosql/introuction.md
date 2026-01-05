# NoSQL & Big Data – Notes

---

## 1. What is NoSQL?

- Stands for **Not Only SQL**
- Not a relational database (does **not** use tables)
- A flexible database used for **big data** and **real-world applications**
- Supports multiple types of databases  
  **Examples:** MongoDB, Key-Value Stores

---

## 2. What is Big Data?

- Refers to **large datasets** where traditional storage and processing techniques are **inadequate**
- Commonly seen in:
  - Social Networks
  - Search Engines
- Main challenges:
  - Storage
  - Data capture
  - Analysis
  - Data transfer

---

## 3. Advantages of NoSQL over Relational Databases

- Handles **big data** efficiently
- Flexible **data models** (no strict predefined schema)
- Can handle **unstructured data**
- Cheaper to manage
- Supports **horizontal scaling (scale out)**

---

## 4. Advantages of RDBMS over NoSQL

- Better suited for **relational data**
- Supports **normalization**
  - Eliminates redundancy
  - Optimizes storage space
- Uses a well-known language: **SQL** (easy to learn)
- Ensures **data integrity**
- Fully **ACID compliant**

---

## 5. Types of NoSQL Databases

### a) Document Databases
- Store data in document format (JSON-like)
- Examples:
  - MongoDB
  - CouchDB

---

### b) Column Databases
- Data stored in columns instead of rows
- Good for **data analytics**
- Reduces disk loading complexity
- Example:
  - Apache Cassandra

---

### c) Key-Value Stores
- Data stored as key–value pairs
- Very fast
- Efficient for **simple data**
- Limited customization
- Examples:
  - Redis
  - Couchbase Server

---

### d) Cache Systems
- Used mainly for caching
- Extremely fast access
- Example:
  - Redis

---

### e) Graph Databases
- Used for relationship-heavy data
- Common use case: **social networks**
- Example:
  - Neo4j

---
