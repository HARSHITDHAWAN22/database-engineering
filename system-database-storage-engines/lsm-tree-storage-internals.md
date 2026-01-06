==============================
Database Storage Internals (Core Concepts)
==============================

These concepts explain how traditional databases store and manage
records on disk. They form the foundation of row-based storage engines
used in many relational databases.

---


==============================
Slotted Pages
==============================

Slotted pages are a technique used by databases to manage records
**inside a single disk page**, especially when records are of
variable length.

They are commonly used in traditional row-based storage engines.

---

## What is a Slotted Page?

A slotted page divides a page into two logical parts:

- **Record area** → where actual records are stored
- **Slot directory** → a list of offsets pointing to records

Records grow from one end of the page,
while the slot directory grows from the other end.

---

## Why Slotted Pages Are Used

Slotted pages make in-page storage flexible because:
- Records can move without changing their identity
- Variable-length records are handled cleanly
- Deletions do not break page layout
- Updates only require changing slot offsets

---

## Key Idea

> The slot number stays the same even if the record moves.

This allows higher layers to reference records safely.

---

## Where Slotted Pages Are Common

- Row-based storage engines
- Heap file implementations
- Traditional RDBMS internals

They are less common in modern log-structured designs.

---

==============================
Record ID (RID)
==============================

A Record ID (RID) is how a database internally **refers to a record on disk**.
Instead of pointing directly to physical storage, the database uses RIDs
as stable references to locate records.

---

## What is a Record ID?

A Record ID usually consists of:
- **Page ID** → identifies the page
- **Slot ID** → identifies the slot inside that page

Conceptually:
(page_id, slot_id)

---

## Why Databases Need Record IDs

Databases use RIDs because:
- Records may move within a page
- Pages can be reorganized after updates or deletes
- Physical locations are not stable
- Indexes need reliable references

RIDs ensure references remain valid even when data shifts.

---

## Record ID and Slotted Pages (Connection)

- The slot directory points to the actual record
- The RID points to the slot, not the record bytes
- If a record moves, only the slot offset changes
- The RID remains unchanged

This separation keeps storage flexible and safe.

---

## Where Record IDs Are Used

- Index entries store RIDs
- Query execution uses RIDs to fetch rows
- Storage engines rely on RIDs as internal pointers

RIDs are internal details and usually hidden from users.

---


==============================
Log-Structured Merge Trees (LSM Trees)
==============================

LSM Trees are a storage design used by many modern databases to handle
**high write workloads efficiently**.  
Instead of updating data in place, writes are handled in an
append-only and sequential manner.

This design is common in write-heavy systems.

---

## Why LSM Trees Exist

Traditional storage engines slow down under heavy writes because:
- Updates cause random disk I/O
- Indexes need frequent modifications
- Write amplification becomes high

LSM Trees solve this by:
- Turning random writes into sequential writes
- Deferring expensive work to background processes

---

## Core Idea (Simple View)

> Writes are fast first, cleanup happens later.

Data is written quickly, and organization is handled asynchronously.

---

## Main Components of an LSM Tree

### MemTable
- In-memory, sorted structure
- All new writes go here first
- Very fast writes
- Flushed to disk when full

---

### SSTables (Sorted String Tables)
- Immutable files stored on disk
- Data is sorted by key
- Created when MemTable is flushed
- Never updated in place

---

### Compaction
- Background process
- Merges multiple SSTables
- Removes duplicates and old versions
- Keeps read performance reasonable

Compaction is essential but expensive.

---

## How Reads Work

- Check MemTable first
- Then check SSTables (newest to oldest)
- Bloom filters are often used to avoid unnecessary disk reads

Reads are slightly more complex than writes.

---

## Why LSM Trees Are Fast for Writes

- Sequential disk writes
- No in-place updates
- Minimal locking
- Batch flushing and merging

This makes them ideal for high-ingestion workloads.

---

## Trade-offs of LSM Trees

Advantages:
- Very high write throughput
- Scales well with write-heavy workloads
- Works well with SSDs

Limitations:
- Read amplification
- Write amplification due to compaction
- Background compaction can consume resources

LSM Trees favor write speed over read simplicity.

---

## Where LSM Trees Are Used

- NoSQL databases
- Key-value stores
- Time-series databases
- Streaming and logging systems

Common systems built on LSM Trees include modern distributed databases.

---

==============================
Bloom Filters
==============================

A Bloom Filter is a **probabilistic data structure** used to quickly check
whether an element **might exist** or **definitely does not exist** in a set.

It is designed to be **very fast** and **memory efficient**.

---

## What Problem Bloom Filters Solve

Checking disk or large data structures repeatedly is expensive.
Bloom filters help by answering a simple question first:

> “Is it even worth looking further?”

If the Bloom filter says **no**, the system can safely skip the lookup.

---

## How Bloom Filters Work (High Level)

- Uses a fixed-size bit array
- Uses multiple hash functions
- Each element sets multiple bits in the array

When checking an element:
- If any required bit is missing → element is **definitely not present**
- If all bits are present → element **may be present**

There are **no false negatives**, but **false positives are possible**.

---


## Why Bloom Filters Are Fast

Bloom filters are fast because:
- Only hash computations are needed
- No disk access required
- Constant-time checks
- Very small memory footprint

They act as a lightweight gate before expensive operations.

---

## Trade-offs

Advantages:
- Extremely memory efficient
- Very fast membership checks
- Simple to implement

Limitations:
- False positives are possible
- Elements cannot be removed easily (basic version)
- Does not store actual data

Bloom filters trade accuracy for speed and space.

---

## Where Bloom Filters Are Used

- LSM Trees (to avoid unnecessary SSTable reads)
- Key-value stores
- Databases and storage engines
- Caches and distributed systems
- Networking and security systems

They are especially useful when **reads are expensive**.

---

## Bloom Filters in LSM Trees (Connection)

In LSM Trees:
- Each SSTable has a Bloom filter
- Before reading from disk, the filter is checked
- If the filter says “not present”, disk read is skipped
- This significantly improves read performance

---

## Key Idea to Remember

> Bloom filters help avoid work, not do the work.

They optimize systems by preventing unnecessary lookups.

---


### Compaction Strategies

Different systems use different compaction strategies depending on
their read/write trade-offs.

---

#### Size-Tiered Compaction

In size-tiered compaction:
- SSTables of similar size are merged together
- Compaction happens less frequently
- Larger files are created over time

Why it’s used:
- High write throughput
- Lower compaction overhead
- Simple design

Trade-offs:
- More overlapping SSTables
- Higher read amplification
- Reads may touch many files

Best suited for:
- Write-heavy workloads
- Log and event ingestion systems

---

#### Leveled Compaction

In leveled compaction:
- Data is organized into fixed-size levels
- Each level has non-overlapping key ranges
- Compaction happens more frequently but in smaller steps
- -default 10X multipler of size at each level.

---

Why it’s used:
- Predictable read performance(best for read heavy)
- Fewer SSTables to check during reads
- Better read latency

Trade-offs:
- Higher write amplification
- More background compaction work
- Slightly lower write throughput

Best suited for:
- Read-heavy or read-sensitive workloads
- Systems needing stable latency

---

### Key Difference to Remember

> Size-tiered compaction favors write speed,  
> Leveled compaction favors read efficiency.


---

==============================
Time-Window (Time-Based) Compaction
==============================

Time-window compaction is a compaction strategy where data is grouped
and compacted **based on time ranges**, not just file size or levels.

It is commonly used in **time-series and event-based systems**.

---

## Core Idea

> Data is compacted within fixed time windows.

Each window represents a time range such as:
- 1 hour
- 1 day
- 1 week

Data from different windows is **not mixed**.

---

## How It Works

- Incoming data is written to files for the current time window
- Once a window is closed, compaction happens only inside that window
- Older windows are usually read-only
- Very old windows may be deleted based on retention rules

---

## Why Time-Window Compaction Is Used

This approach works well because:
- Time-series data is naturally time-ordered
- Old data rarely changes
- Compaction work stays limited to recent data
- Predictable and controlled compaction cost

---

## Advantages

- Efficient for append-only workloads
- Low write amplification
- Easy data retention and deletion
- Stable performance over time

---

## Limitations

- Not suitable for random updates
- Queries across many windows may touch multiple files
- Less flexible than key-based compaction

---

## Where It Is Commonly Used

- Time-series databases
- Metrics and monitoring systems
- Logging platforms
- Event ingestion pipelines

---








