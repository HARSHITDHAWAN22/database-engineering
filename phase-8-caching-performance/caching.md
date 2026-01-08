---

## Why Caching Exists 

Caching exists because databases are not designed
to handle extremely high request rates with low latency.

As systems grow, hitting the database for every request
becomes slow and expensive.

---

## Why Databases Alone Are Not Enough

Databases focus on:
- Correctness
- Durability
- Strong consistency

At scale, this causes problems:
- Disk and network I/O increase latency
- Query execution consumes CPU
- Locks and coordination slow things down
- Scaling databases is costly and complex

Caching reduces repeated database access
by serving frequent reads from faster storage.

---

## Latency vs Throughput

Latency:
- How long one request takes

Throughput:
- How many requests are handled per second

Important idea:
- Databases optimize correctness, not speed
- Caches optimize speed and volume

*Caching improves both latency and throughput while protecting the database.

---

## Read-Heavy Workloads

Caching works best when:
- Reads are much more frequent than writes
- Same data is requested again and again

Typical examples:
- User profile data
- Product details
- Configuration and metadata


*The more repeated reads you have, the more caching helps.

---

## Cache vs Database Responsibilities

Cache:
- Very fast access
- Temporary storage
- Can serve slightly stale data

Database:
- Source of truth
- Strong consistency
- Durable and reliable

*Cache is for performance, database is for correctness.

---

## Cache Types & Patterns

---

## Cache-Aside (Lazy Loading)

How it works:
- Application checks cache first
- On a miss, data is fetched from DB and added to cache

Why it is popular:
- Simple to implement
- Cache stores only hot data

Problems:
- First request is always slow
- Cache can serve stale data if not handled carefully

---

## Read-Through Cache

How it works:
- Application always reads from cache
- Cache itself fetches data from DB on a miss

Why it helps:
- Cleaner application code
- Cache logic is centralized

Problems:
- Cache layer becomes more complex
- Cache failures directly affect reads

---

## Write-Through Cache

How it works:
- Writes go to cache and database together

Why it is safe:
- Cache and DB stay in sync
- Reads are always consistent

Problems:
- Higher write latency
- Extra write cost on cache

---

## Write-Back (Write-Behind) Cache

How it works:
- Writes go to cache first
- Database update happens asynchronously

Why it is fast:
- Very low write latency
- High write throughput

Problems:
- Risk of data loss
- Harder failure handling

*Write-back favors performance over durability.

---

## STEP 8.3 — Cache Eviction Policies

Caches have limited memory.
Eviction decides what data to remove when space runs out.

---

## LRU (Least Recently Used)

Idea:
- Remove data that has not been accessed recently

Why it works:
- Recent access often means future access

Limit:
- One recent access does not always mean important data

---

## LFU (Least Frequently Used)

Idea:
- Remove data with the lowest access count

Why it works:
- Keeps frequently used keys

Limit:
- Old popular keys may stay even if no longer useful

---

## FIFO (First In First Out)

Idea:
- Remove data in insertion order

Why it exists:
- Simple and predictable

Limit:
- Ignores how data is actually used

---

## TTL (Time To Live)

Idea:
- Data expires after a fixed time

Why it helps:
- Prevents stale data
- Easy to reason about

Limit:
- Useful data may expire early

---

## Why Eviction Matters

Without eviction:
- Cache fills up
- Hot data gets pushed out
- Cache becomes ineffective

A good eviction policy is critical for cache performance.

---

## Key Points

- Caching exists to reduce DB load and latency
- Cache patterns control consistency behavior
- Eviction decides cache quality
- Poor caching decisions can hurt system performance
