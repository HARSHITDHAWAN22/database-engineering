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

# NoSQL Databases – Concepts, Modeling, and Real-World Usage

These notes focus on understanding NoSQL practically — why it exists, how it is modeled,
and where it fits (or does NOT fit) in real systems.

---

## Types of NoSQL Databases

### Key–Value Stores

**Core idea:**  
Data is stored as a simple **key → value** pair.

- Keys act as unique identifiers  
- Values are treated as opaque blobs by the database  
- Database does not understand the internal structure of the value  

**Key characteristics:**
- Extremely fast reads and writes
- Often implemented as **in-memory databases**
- Very limited querying capability

**TTL (Time-To-Live):**
- Keys can automatically expire after a given time
- Useful for temporary or short-lived data

**Common use cases:**
- Caching frequently accessed data
- Session storage (login sessions)
- Rate limiting (API counters)
- Temporary tokens (OTP, reset links)

**Mental model:**  
A distributed, extremely fast hash map.

---

### Document Databases

**Core idea:**  
Data is stored as **documents** (JSON / BSON).

Each document:
- Represents a complete entity
- Can contain nested structures
- Does not require a fixed schema

**Document model:**
- JSON-like format
- Fields can vary across documents
- Easy to evolve as requirements change

**Embedded vs referenced documents:**
- Embedded → related data stored together (faster reads)
- Referenced → data linked via IDs (more flexible, extra reads)

**Schema flexibility:**
- Fields can be added without migrations
- Application handles missing or extra fields

**Indexing in document databases:**
- Indexes can be created on document fields
- Improves read performance but slows writes

**Querying documents:**
- Filters on nested fields
- Sorting and projections supported

**Schema versioning:**
- Older documents may follow older formats
- Application logic manages compatibility

---

### Column-Family Stores

**Core idea:**  
Data is stored in **wide rows**, optimized for large-scale workloads.

**Wide-column model:**
- Rows can have a very large number of columns
- Columns are grouped into column families

**Partition key:**
- Controls how data is distributed across nodes
- Directly affects scalability and performance

**Clustering key:**
- Controls ordering of data within a partition
- Important for range queries

**Write-optimized storage:**
- Designed for heavy and continuous writes
- Sequential writes are preferred

**Consistency model:**
- Usually follows **eventual consistency**
- Optimized for availability and scale

**Common use cases:**
- Time-series data
- Logs and metrics
- Event and IoT data

---

### Graph Databases (Intro)

**Core idea:**  
Data is modeled as **nodes and edges**.

- Nodes represent entities
- Edges represent relationships
- Relationships are stored directly

**Traversals:**
- Efficient navigation across relationships
- Multi-hop queries are fast

**When graph databases are useful:**
- Social networks
- Recommendation systems
- Fraud detection
- Dependency analysis

**Why joins are expensive in SQL but cheap in graphs:**
- SQL computes joins at query time
- Graph DBs store relationships natively
- Traversals are pointer-based, not computation-heavy

---

## Data Modeling in NoSQL

**Query-driven schema design:**
- Schema is designed based on query patterns
- Queries come first, schema follows

**Denormalization strategies:**
- Duplicate data to avoid joins
- Trade storage for faster reads

**Read-heavy vs write-heavy workloads:**
- Read-heavy → optimize structure and indexing
- Write-heavy → minimize indexes and updates

**Designing for access patterns:**
- Each query should ideally hit one document or partition
- Multiple representations of the same data are acceptable

**Avoiding joins:**
- Joins are slow or unsupported
- Data is reshaped instead of joined

---

## Indexing in NoSQL

**Indexing vs SQL:**
- Indexes exist but behave differently
- Less automatic optimization compared to SQL planners

**Single-field indexes:**
- Index on one field
- Fast equality and range lookups

**Compound indexes:**
- Index on multiple fields
- Field order matters

**Index tradeoffs:**
- Faster reads
- Slower writes
- Extra storage usage

**Impact on writes:**
- Every write updates indexes
- Too many indexes degrade write performance

---

## Consistency Models

**Strong consistency:**
- Reads always return latest data
- Higher latency, lower availability

**Eventual consistency:**
- Data converges over time
- Better scalability and availability

**Read-your-writes consistency:**
- Client sees its own updates immediately
- Important for user-facing flows

**Tunable consistency (conceptual):**
- Client can choose consistency level
- Balance between correctness and speed

**Stale reads:**
- Reading outdated data
- Acceptable in feeds, analytics, and caches

---

## NoSQL in Real Systems

**Polyglot persistence:**
- Using multiple databases in one system
- Each database solves a specific problem

**Using multiple databases together:**
- SQL for transactions
- NoSQL for scale and flexibility

**Caching layer + primary database:**
- Cache reduces load on main DB
- Improves latency

**Event-driven architectures:**
- Data flows through events
- Systems react asynchronously

**Data replication concepts:**
- Multiple copies of data
- Improves availability and fault tolerance

---

## NoSQL Anti-Patterns

**Overusing NoSQL:**
- Not every problem needs NoSQL
- Simpler systems often work better with SQL

**Poor data modeling:**
- Treating NoSQL like relational databases
- Leads to inefficient queries

**Ignoring consistency requirements:**
- Assuming eventual consistency is always acceptable
- Can break business logic

**Using NoSQL where SQL is better:**
- Strong transactions
- Complex joins
- Analytical queries

**Misunderstanding CAP theorem:**
- CAP is about tradeoffs, not absolute choices
- Real systems balance consistency and availability

---

## Final Takeaway

NoSQL is not a replacement for SQL.  
It is a design decision based on scale, flexibility, and access patterns.  
Good systems choose databases based on requirements, not trends.

