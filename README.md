# 🛍️ E-Commerce Database Project (SQL)

This project is a **MySQL-based database system** for an e-commerce platform.  
It demonstrates key SQL concepts such as database design, foreign keys, joins, aggregation, and sample analytical queries.

---

## 📘 Features
- Customers, Products, Orders, Categories, and Payments tables  
- Fully normalized relational design (3NF)
- Foreign key relationships
- Realistic sample data
- Example SQL queries for analytics

---

## 🗂️ Database Schema

**Tables:**
1. `customers` – customer info  
2. `categories` – product categories  
3. `products` – item details with category linkage  
4. `orders` – customer orders  
5. `order_details` – many-to-many relation between orders & products  
6. `payments` – order payment information

---

## 🧠 Example Queries

| Purpose | SQL Command |
|----------|--------------|
| List all products with category | `SELECT p.product_name, c.category_name FROM products p JOIN categories c ON p.category_id=c.category_id;` |
| Show pending orders | `SELECT * FROM orders WHERE status='Pending';` |
| Top 3 best-selling products | `SELECT p.product_name, SUM(od.quantity) AS total_sold FROM order_details od JOIN products p ON od.product_id=p.product_id GROUP BY p.product_name ORDER BY total_sold DESC LIMIT 3;` |
| Total sales per category | `SELECT c.category_name, SUM(od.price * od.quantity) AS total_sales FROM order_details od JOIN products p ON od.product_id=p.product_id JOIN categories c ON p.category_id=c.category_id GROUP BY c.category_name;` |

---

## ⚙️ How to Run

1. Open your MySQL terminal or phpMyAdmin.
2. Run the script:

```bash
mysql -u root -p < ecommerce_database.sql
