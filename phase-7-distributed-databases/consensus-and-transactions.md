---

## Consensus & Leader Election (Light)

Consensus and leader election are used to keep distributed systems
correct when nodes fail or networks partition.
These mechanisms are critical for databases, metadata services,
and coordination layers.

---

## Split Brain

Split brain happens when a distributed system
ends up with **more than one active leader**.

Why it occurs:
- Network partitions
- Unreliable failure detection
- Incorrect leader election

Why it is dangerous:
- Conflicting writes
- Data corruption
- Inconsistent system state

Real-world impact:
- Two primaries accepting writes
- Replicas diverging permanently

How systems prevent it:
- Majority-based decisions
- Quorum requirements
- Consensus protocols

*Split brain is worse than downtime because it breaks correctness.

---

## Leader Election

Leader election is the process of choosing **one node**
to act as the coordinator.

Why leaders are needed:
- Single point for writes
- Ordering of operations
- Metadata management

Common rules:
- Only one leader at a time
- Leader must be agreed upon by a majority
- Leader can change on failure

Failure handling:
- Detect leader failure
- Elect a new leader
- Resume operations safely

*Leader election simplifies coordination but must be fault-safe.

---

## Consensus (High-Level Idea)

Consensus ensures that **all healthy nodes agree**
on the same decision or state.

What consensus guarantees:
- Safety: no conflicting decisions
- Agreement: nodes converge to one value
- Fault tolerance: works despite failures

Used for:
- Leader election
- Log replication
- Configuration management

Interview takeaway:
Consensus is about correctness, not performance.

---

## Raft (Idea Only)

Raft is a consensus algorithm designed to be
**easy to understand and implement**.

Core ideas:
- Strong leader-based model
- Log replication via the leader
- Majority quorum for decisions

Why Raft is popular:
- Clear separation of roles
- Easier reasoning than Paxos
- Widely used in production systems

Interview takeaway:
Raft prioritizes simplicity and clarity.

---

## Paxos(Idea Only)

Paxos is a foundational consensus algorithm
focused on **provable correctness**.

Core ideas:
- Proposers, acceptors, learners
- Agreement through message rounds
- Works even with failures

Why Paxos is hard:
- Complex to understand
- Difficult to implement correctly

*Paxos is powerful but rarely implemented directly.

---

## Key Points
- Split brain leads to data corruption
- Leader election ensures a single decision maker
- Consensus prevents conflicting states
- Raft is practical and readable
- Paxos is theoretical and complex


---

## Distributed Transactions (Intro)

Distributed transactions try to provide ACID guarantees
when a transaction spans multiple nodes or databases.

In practice, this is hard and often avoided.

---

## Why ACID Is Hard in Distributed Systems

ACID works well on a single machine but breaks down in distributed setups.

Main reasons:
- Network communication is slow and unreliable
- Nodes can crash or become unreachable
- Locks must be held across machines
- Coordination increases latency

Key problem:
- Atomicity and consistency require global coordination
- Availability drops during failures or delays

*In distributed systems, coordination is the real cost of ACID.

---

## Two-Phase Commit (2PC)

Two-Phase Commit is a protocol to achieve atomic commits
across multiple nodes.

### Phase 1: Prepare
- Coordinator asks all participants if they can commit
- Participants lock resources and reply YES or NO

### Phase 2: Commit / Abort
- If all reply YES → coordinator sends COMMIT
- If any reply NO → coordinator sends ABORT

Guarantee:
- All nodes commit or all abort

---

## Problems with Two-Phase Commit

Major limitations:
- Blocking protocol (participants wait if coordinator fails)
- Locks are held for a long time
- High latency due to multiple network round trips
- Poor availability during failures

Failure scenario:
- Coordinator crashes after prepare
- Participants cannot decide on their own

Interview takeaway:
2PC guarantees atomicity but hurts availability.

---

## Why Modern Systems Avoid 2PC

Modern distributed systems prioritize availability and scalability.

Reasons 2PC is avoided:
- Does not tolerate coordinator failures well
- Scales poorly under high load
- Increases tail latency
- Causes system-wide stalls

Common alternatives:
- Eventual consistency
- Application-level compensation (Sagas)
- Per-shard or per-key transactions
- Consensus-based replication

*2PC is correct but impractical at scale.

---

## Key Takeaways

- ACID is expensive in distributed systems
- 2PC provides atomicity but blocks on failures
- Modern systems trade strong guarantees for availability
- Distributed transactions are minimized by design

