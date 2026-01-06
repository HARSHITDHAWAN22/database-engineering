---

## Sharding / Partitioning

Sharding (also called partitioning) is the process of splitting data
across multiple nodes so that no single database handles all the load.

The main goal is to improve scalability and reduce per-node pressure.

---

## Range Sharding

In range sharding, data is divided based on key ranges.

Example:
- Shard 1 → user_id 1–1M
- Shard 2 → user_id 1M–2M

Advantages:
- Efficient range queries and scans
- Predictable data placement
- Easy to understand and debug

Problems:
- Uneven data distribution
- High risk of hotspots
- Requires careful range planning

When it works well:
- Time-based data
- Ordered keys
- Read-heavy analytical queries

*Range sharding is simple but dangerous if access patterns are uneven.

---

## Hash Sharding

In hash sharding, a hash function is applied to the shard key
to decide the target shard.

Example:
- shard_id = hash(user_id) % N

Advantages:
- Uniform data distribution
- Avoids most hotspots
- Easy to scale reads and writes

Problems:
- Range queries become expensive
- Difficult to rebalance when shard count changes
- Poor locality for related data

When it works well:
- High write throughput systems
- Random access patterns
- Large-scale user-facing workloads

*Hash sharding trades query flexibility for load balance.

---

## Hot Partitions

A hot partition occurs when one shard receives
disproportionately high traffic.

Common causes:
- Sequential keys (timestamps, auto-increment IDs)
- Popular users or records
- Skewed access patterns

Impact:
- One shard becomes CPU or I/O bound
- Overall system performance degrades
- Scaling other shards does not help

Mitigation strategies:
- Switch from range to hash sharding
- Add random prefixes or salting
- Split hot shards manually
- Cache hot data separately

*Hot partitions are usually caused by bad shard-key choices.

---

## Re-sharding

Re-sharding is the process of changing shard boundaries
or the number of shards as the system grows.

Why re-sharding is needed:
- Data size increases
- Load becomes uneven
- New nodes are added

Challenges:
- Moving large amounts of data
- Temporary performance degradation
- Coordinating reads and writes during migration

Common approaches:
- Online re-sharding with background data movement
- Consistent hashing to minimize data movement
- Dual writes during migration phase

Interview note:
Re-sharding is operationally hard and should be planned early.

---

## Key Takeaways (Sharding)

- Sharding enables horizontal scalability
- Range sharding favors query efficiency
- Hash sharding favors load balance
- Poor shard keys cause hot partitions
- Re-sharding is expensive but unavoidable

---

## 7 Database Scaling Strategies

1. Vertical Scaling (Scale Up)
2. Read Replication
3. Sharding (Horizontal Partitioning)
4. Caching
5. Asynchronous Processing
6. Query and Schema Optimization
7. Data Tiering and Archival
   
---

---

## Consistent Hashing

Consistent hashing is a technique used to distribute data across nodes
while minimizing data movement when nodes are added or removed.

---

## Why Consistent Hashing Exists

Traditional hash partitioning breaks when the number of nodes changes.
Most keys get remapped, causing massive data movement.

Consistent hashing solves this by limiting remapping
to only a small subset of keys.

---

## How It Works

- A logical hash ring is created
- Both nodes and keys are placed on the same ring using a hash function
- A key is assigned to the first node encountered while moving clockwise

---

## Virtual Nodes (VNodes)

- Each physical node is represented by multiple virtual nodes
- Improves load distribution
- Reduces imbalance when nodes join or leave

---

## Node Changes

Node addition:
- New node takes responsibility for a small portion of keys
- Most data remains on existing nodes

Node removal:
- Only keys owned by that node are reassigned
- No global reshuffling required

---

## Practical Benefits

- Minimal data movement
- Easy horizontal scaling
- Better fault isolation
- Widely used in distributed databases and caches

---

## Common Use Cases

- Distributed databases
- Key-value stores
- Distributed caching systems
- Load balancing

---

* Consistent hashing reduces rebalancing cost
* Virtual nodes are critical for even load
* Tradeoff: more complex routing logic


