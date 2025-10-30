-- =========================================================
-- E-COMMERCE DATABASE PROJECT
-- Author: Your Name
-- Description: SQL schema + sample data for an e-commerce system
-- =========================================================

-- STEP 1: Create the database
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- STEP 2: Create the tables

-- 1. Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Categories table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- 3. Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Order Details table (junction table for products in orders)
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 6. Payments table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2),
    payment_method ENUM('Credit Card','Debit Card','UPI','PayPal','Cash on Delivery'),
    status ENUM('Success','Pending','Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- STEP 3: Insert sample data

-- Insert categories
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Electronic gadgets and devices'),
('Clothing', 'Men and Women apparel'),
('Books', 'Educational and entertainment books'),
('Home Appliances', 'Appliances for home and kitchen');

-- Insert products
INSERT INTO products (product_name, description, price, stock, category_id) VALUES
('Smartphone', 'Android smartphone with 6GB RAM', 15999.00, 50, 1),
('Laptop', '15-inch laptop with Intel i5 processor', 55999.00, 30, 1),
('T-shirt', 'Cotton t-shirt', 499.00, 100, 2),
('Novel', 'Bestselling fiction novel', 299.00, 200, 3),
('Mixer Grinder', '750W powerful mixer grinder', 2499.00, 20, 4);

-- Insert customers
INSERT INTO customers (name, email, phone, address, city, country) VALUES
('Aakash Kumar', 'aakash@example.com', '9876543210', 'MG Road', 'Patna', 'India'),
('Riya Sharma', 'riya@example.com', '9988776655', 'Park Street', 'Kolkata', 'India'),
('Rahul Singh', 'rahul@example.com', '9123456789', 'Civil Lines', 'Delhi', 'India');

-- Insert orders
INSERT INTO orders (customer_id, status, total_amount) VALUES
(1, 'Pending', 15999.00),
(2, 'Delivered', 58998.00),
(3, 'Shipped', 2499.00);

-- Insert order details
INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 15999.00),
(2, 2, 1, 55999.00),
(2, 3, 6, 2999.00),
(3, 5, 1, 2499.00);

-- Insert payments
INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(1, 15999.00, 'UPI', 'Success'),
(2, 58998.00, 'Credit Card', 'Success'),
(3, 2499.00, 'Cash on Delivery', 'Pending');

-- STEP 4: Example queries

-- 1. View all products with their categories
SELECT p.product_name, c.category_name, p.price, p.stock
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- 2. View all orders and customer details
SELECT o.order_id, c.name AS customer_name, o.status, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 3. Total sales per category
SELECT c.category_name, SUM(od.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;

-- 4. Find all pending orders
SELECT * FROM orders WHERE status = 'Pending';

-- 5. Show top 3 selling products
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- =========================================================
-- END OF FILE
-- =========================================================
-- =========================================================
-- E-COMMERCE DATABASE PROJECT
-- Author: Your Name
-- Description: SQL schema + sample data for an e-commerce system
-- =========================================================

-- STEP 1: Create the database
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- STEP 2: Create the tables

-- 1. Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Categories table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- 3. Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Order Details table (junction table for products in orders)
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 6. Payments table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2),
    payment_method ENUM('Credit Card','Debit Card','UPI','PayPal','Cash on Delivery'),
    status ENUM('Success','Pending','Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- STEP 3: Insert sample data

-- Insert categories
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Electronic gadgets and devices'),
('Clothing', 'Men and Women apparel'),
('Books', 'Educational and entertainment books'),
('Home Appliances', 'Appliances for home and kitchen');

-- Insert products
INSERT INTO products (product_name, description, price, stock, category_id) VALUES
('Smartphone', 'Android smartphone with 6GB RAM', 15999.00, 50, 1),
('Laptop', '15-inch laptop with Intel i5 processor', 55999.00, 30, 1),
('T-shirt', 'Cotton t-shirt', 499.00, 100, 2),
('Novel', 'Bestselling fiction novel', 299.00, 200, 3),
('Mixer Grinder', '750W powerful mixer grinder', 2499.00, 20, 4);

-- Insert customers
INSERT INTO customers (name, email, phone, address, city, country) VALUES
('Aakash Kumar', 'aakash@example.com', '9876543210', 'MG Road', 'Patna', 'India'),
('Riya Sharma', 'riya@example.com', '9988776655', 'Park Street', 'Kolkata', 'India'),
('Rahul Singh', 'rahul@example.com', '9123456789', 'Civil Lines', 'Delhi', 'India');

-- Insert orders
INSERT INTO orders (customer_id, status, total_amount) VALUES
(1, 'Pending', 15999.00),
(2, 'Delivered', 58998.00),
(3, 'Shipped', 2499.00);

-- Insert order details
INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 15999.00),
(2, 2, 1, 55999.00),
(2, 3, 6, 2999.00),
(3, 5, 1, 2499.00);

-- Insert payments
INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(1, 15999.00, 'UPI', 'Success'),
(2, 58998.00, 'Credit Card', 'Success'),
(3, 2499.00, 'Cash on Delivery', 'Pending');

-- STEP 4: Example queries

-- 1. View all products with their categories
SELECT p.product_name, c.category_name, p.price, p.stock
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- 2. View all orders and customer details
SELECT o.order_id, c.name AS customer_name, o.status, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 3. Total sales per category
SELECT c.category_name, SUM(od.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;

-- 4. Find all pending orders
SELECT * FROM orders WHERE status = 'Pending';

-- 5. Show top 3 selling products
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- =========================================================
-- END OF FILE
-- =========================================================
