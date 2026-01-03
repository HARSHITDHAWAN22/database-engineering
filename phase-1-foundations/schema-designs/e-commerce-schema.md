# Database Schema – E-commerce Example (Phase 1)
##Example schema for practicfe and overview of design principles.

> This schema is part of my Phase 1 learning while understanding
> relational database fundamentals. The aim here is to practice
> schema design concepts like tables, keys, relationships, and
> constraints before moving to SQL and implementation details.
>
> This is a learning-focused design, not a production-ready system.

---

## Tables

### 1. Users
Stores basic information about users of the platform.

- user_id (Primary Key)
- name
- email
- created_at

Notes:
- user_id is used to uniquely identify each user
- email should be unique to avoid duplicate accounts

---

### 2. Products
Stores details of products available for purchase.

- product_id (Primary Key)
- name
- price
- category

Notes:
- product_id uniquely identifies a product
- price should always be greater than zero

---

### 3. Orders
Stores information about orders placed by users.

- order_id (Primary Key)
- user_id (Foreign Key → Users.user_id)
- order_date
- total_amount

Notes:
- A single user can place multiple orders
- user_id links each order to the user who placed it

---

### 4. Order_Items
Acts as a junction table between Orders and Products.

- order_item_id (Primary Key)
- order_id (Foreign Key → Orders.order_id)
- product_id (Foreign Key → Products.product_id)
- quantity
- price_at_purchase

Notes:
- Used to handle the many-to-many relationship between orders and products
- Stores the quantity and product price at the time of purchase

---

## Relationships

- Users → Orders  
  One user can place multiple orders (One-to-Many)

- Orders → Order_Items  
  One order can contain multiple items (One-to-Many)

- Products → Order_Items  
  A product can appear in multiple order items (One-to-Many)

Overall, Orders and Products have a **Many-to-Many** relationship,
which is handled using the Order_Items table.

---

## Design Principles Followed

- Every table has a clearly defined primary key
- Foreign keys are used to maintain data integrity
- Data redundancy is avoided
- The schema follows normalization up to 3NF
- The design is kept simple and easy to understand

---

## Purpose of This Schema

- To practice relational database design
- To understand how tables are connected using keys
- To build a strong foundation before writing SQL queries
- To prepare for real-world backend systems and ML data modeling

> This schema is intentionally kept simple and is meant purely
> for learning and building core database understanding.
