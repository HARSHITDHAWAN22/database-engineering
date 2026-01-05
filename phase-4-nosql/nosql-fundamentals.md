# BASE Properties and CAP Theorem – Structured Notes

---

## BASE Properties

- **BA (Basically Available)**  
  The system must always be available, even if it means reduced consistency.

- **S (Soft State)**  
  The system can be in an intermediate or temporary state.

- **E (Eventually Consistent)**  
  The system becomes consistent after some time.

---

## CAP Theorem

- **C – Consistency**  
  All nodes return the same, latest data.

- **A – Availability**  
  Every request receives a response.

- **P – Partition Tolerance**  
  System continues to work even if network failures occur.

### Theorem Statement
Only **two out of the three** properties (C, A, P) can be guaranteed at the same time.

---

### CAP Combinations

1. **Consistency + Partition Tolerance (CP)**  
   - Availability is sacrificed to maintain consistency  
   - Example: Banking transaction servers

2. **Availability + Partition Tolerance (AP)**  
   - Consistency is compromised to maintain availability  
   - Example: Social media platforms

3. **Availability + Consistency (AC)**  
   - System is centralized  
   - Single database server  
   - Not partition tolerant

---

### Important Observation

- **Partition Tolerance (P) is the most important** in distributed systems  
- We compromise either **Consistency** or **Availability** based on use case

**Examples:**
- Compromise **Consistency**:
  - Video streaming platforms
  - Multiplayer games
  - Blogs
- Compromise **Availability**:
  - Stock trading platforms
  - Banking servers

---

## CAP Theorem – Practical Choice Between AP and CP

These notes explain how we **choose and implement AP or CP**
in real distributed systems using database choice and system design.

---

## Choosing and Implementing an AP System
(Availability + Partition Tolerance)

### 1. Database Type Used

AP systems are usually built using **distributed NoSQL databases**
that support eventual consistency and high availability.

Common choices:
- Cassandra
- DynamoDB
- Couchbase
- MongoDB (configured for relaxed consistency)

---

### 2. How AP Is Achieved (Implementation Steps)

1. Data is replicated across multiple nodes
2. Replication is asynchronous  
   - Writes do not wait for all replicas
3. Eventual consistency is followed  
   - Temporary inconsistency is allowed
4. Read requests are served from any available node
5. System continues operating during network failures
6. Stale data is allowed for a short time
7. Conflicts are resolved later using:
   - Timestamps
   - Last-write-wins strategy
8. Distributed transactions are avoided
9. Availability and responsiveness are prioritized over correctness

---

### 3. When AP Is the Right Choice

AP systems are chosen when:
- The system must always respond
- Minor delays in consistency are acceptable

Typical use cases:
- Social media feeds
- Likes and comments
- Notifications
- Analytics and logging systems

---

## Choosing and Implementing a CP System
(Consistency + Partition Tolerance)

### 1. Database Type Used

CP systems use databases that enforce **strong consistency**
and coordination between nodes.

Common choices:
- HBase
- Zookeeper
- MongoDB (strong consistency enabled)
- SQL databases with quorum-based replication

---

### 2. How CP Is Achieved (Implementation Steps)

1. Strong consistency is enforced
2. Replication is synchronous  
   - All required replicas must acknowledge writes
3. Quorum-based reads and writes are used
4. Reads from outdated replicas are rejected
5. Requests may block or fail during partitions
6. Stale data is never returned
7. Distributed locking is used when required
8. Transactions are enabled
9. Data correctness is prioritized over availability

---

### 3. When CP Is the Right Choice

CP systems are chosen when:
- Data accuracy is critical
- Incorrect data is unacceptable

Typical use cases:
- Banking systems
- Payment processing
- Order management
- Inventory systems

---

## Simple Decision Rule

- If the system must **always be available** → choose **AP**
- If the system must **always be correct** → choose **CP**

---
