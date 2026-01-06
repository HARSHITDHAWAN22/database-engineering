# Distributed Databases – Practical Notes

These notes focus on how distributed databases behave in real systems
and how these topics are usually discussed in interviews.

---

## Single Machine Limits

A single database server cannot scale forever.
No matter how powerful the hardware is, it eventually hits hard limits.

Main bottlenecks:
- CPU becomes saturated due to query execution, joins, and background work
- Memory fills up, causing frequent disk access
- Disk I/O slows down due to random reads and writes
- Network bandwidth limits the number of concurrent requests

Common real-world symptoms:
- p99 latency starts increasing sharply
- Write throughput stops improving
- Cache hit ratio drops
- Adding indexes makes writes noticeably slower

*Vertical scaling only delays the problem, it does not solve it.

---

## Horizontal Scaling

Horizontal scaling means adding more machines instead of upgrading one.

### Sharding (Data Partitioning)
- Data is split across multiple nodes
- Each node owns and manages only a portion of the data

Partitioning strategies:
- Hash partitioning: good load distribution, poor range queries
- Range partitioning: efficient scans, risk of hotspots
- Consistent hashing: easier resharding when nodes change

### Replication
- Same data is stored on multiple nodes
- Improves read scalability and availability

Replication models:
- Leader–Follower
- Multi-Leader
- Leaderless (Dynamo-style)

Practical issues:
- Cross-shard queries are expensive
- Rebalancing data causes temporary latency spikes
- Operational complexity increases as nodes grow


*Sharding helps with scale, replication helps with availability.

---

## Fault Tolerance

Failures are expected in distributed databases, not exceptional.

Typical failures:
- Node crashes
- Disk failures
- Network partitions
- Nodes becoming slow but not fully down

How databases handle failures:
- Replication with automatic failover
- Consensus protocols like Raft or Paxos
- Write-Ahead Logging for crash recovery

Real challenges:
- Split-brain situations
- Serving stale reads
- Delays during leader election


*Fault tolerance is about correctness under failure, not just uptime.

---

## Practical Design Decisions

When sharding makes sense:
- Dataset no longer fits on a single node
- Write throughput has reached a ceiling
- Hot partitions start appearing

When sharding is a bad idea:
- Dataset is small
- Queries rely heavily on joins
- System is still in early development

CAP in practice:
- Partition tolerance is unavoidable
- Systems choose between consistency and availability per operation

---



## Replication (Leader–Follower)

Leader–Follower replication is the most common replication model used
in distributed databases and production systems.

---

## Primary–Replica Model

- One node acts as the **Primary (Leader)**
- All writes go to the primary
- Changes are replicated to one or more replicas
- Replicas stay read-only

Why this model is used:
- Simple consistency model
- Clear write ownership
- Easier conflict handling compared to multi-leader

Practical downside:
- Primary can become a bottleneck for writes
- Primary failure impacts the whole system until failover

*Leader–Follower is chosen for simplicity and correctness, not maximum write throughput.

---

## Read Replicas

Read replicas are follower nodes used mainly to scale reads.

How they are used:
- Writes → primary
- Reads → replicas
- Load balancer routes read queries to replicas

Benefits:
- Read traffic is distributed
- Primary stays focused on writes
- Useful for analytics and reporting queries

Limitations:
- Reads may be stale
- Replicas cannot handle writes
- Not suitable for strongly consistent reads

*Read replicas improve scalability but weaken read consistency.

---

## Replication Lag

Replication lag is the delay between a write on the primary
and its visibility on replicas.

Why lag happens:
- Network delay
- High write throughput
- Slow disks on replicas
- Replica falling behind due to load

Problems caused by lag:
- Stale reads
- Read-after-write inconsistency
- User-visible data mismatch

Common mitigations:
- Read from primary for critical reads
- Synchronous replication for important data
- Monitoring replica lag metrics

*Replication lag is expected; systems are designed to tolerate it.

---

## Failover

Failover is the process of promoting a replica to primary
when the current primary fails.

Failover steps (simplified):
1. Detect primary failure
2. Stop writes to old primary
3. Promote a replica to new primary
4. Redirect traffic

Challenges during failover:
- Brief unavailability
- Risk of data loss (if replication was async)
- Split-brain if detection is incorrect

Common solutions:
- Consensus-based leader election (Raft)
- Fencing tokens
- Automated failover tools


*Failover trades short downtime for long-term availability.

---

## Real World Examples:
-MySQL → Primary–Replica replication
-MongoDB → Replica Sets
-Apache Kafka → Log-based replication
-Amazon DynamoDB → Multi-region replication

