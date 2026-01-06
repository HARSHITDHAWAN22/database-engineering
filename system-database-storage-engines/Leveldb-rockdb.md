# LevelDB & RocksDB — Embedded Key–Value Storage

These are **embedded key–value storage engines** used **inside applications** as a storage layer.  
They are **not full databases** — no SQL, no server, no query planner.

---

## LevelDB

### What LevelDB Is

LevelDB is a **simple and lightweight key–value store** built by Google.  
It is meant to be **linked directly into your app** and keep things fast and predictable.

- Stores data as `key → value`
- Library-based (runs inside the app)
- Written in **C++**
- Keys are kept **in sorted order**

---

### Read & Write Flow

**Write**
```
App → WAL → MemTable → Disk files
```

**Read**
```
Memory → Disk files
```

---

### Why People Use LevelDB

- Very fast writes
- Low memory usage
- Ordered scans are easy
- Simple behavior, easy to reason about

---

### Where It Falls Short

- Only one writer
- No replication or clustering
- Very few tuning options
- No transaction support

---

### Typical Uses

- Browser storage
- Mobile apps
- Local caches
- Embedded tools

---

## RocksDB

### What RocksDB Is

RocksDB is a **production-ready upgrade of LevelDB**, built by Facebook.  
It keeps the same basic idea but is designed for **heavy load and large data**.

- Backward compatible with LevelDB
- Built for SSDs
- Highly configurable
- Used in real production systems

---

### What RocksDB Improves

| Area | LevelDB | RocksDB |
|---|---|---|
| Writers | Single | Multiple |
| Configuration | Very limited | Extensive |
| Performance tuning | Minimal | Advanced |
| Transactions | No | Optional |
| Production use | Limited | High |

---

### Extra Features in RocksDB

- **Column Families**  
  Multiple logical key spaces with separate configs.

- **Bloom Filters**  
  Avoid unnecessary disk reads.

- **Background Threads**  
  Parallel file merging and cleanup.

- **Rate Limiting**  
  Keeps IO stable under heavy load.

---

### Where RocksDB Is Used

- Facebook systems
- Kafka state storage
- Distributed key–value stores
- Time-series and logging platforms

---

## LevelDB vs RocksDB (Quick View)

| Aspect | LevelDB | RocksDB |
|---|---|---|
| Design | Simple | Advanced |
| Control | Low | High |
| Scale | Small | Large |
| Best for | Learning, small apps | Production systems |

---

## Final Take

> **LevelDB is clean and minimal.  
> RocksDB is built to survive production traffic.**

---


