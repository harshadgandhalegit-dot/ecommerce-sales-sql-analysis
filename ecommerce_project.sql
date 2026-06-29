-- ============================================================
--  E-COMMERCE RETAIL DATABASE — Data Analyst Project
--  8 LPA GitHub Portfolio | MySQL Compatible
-- ============================================================

-- ============================================================
--  SCHEMA CREATION
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_retail;
USE ecommerce_retail;

-- 1. CUSTOMERS
CREATE TABLE customers (
    customer_id     INT PRIMARY KEY AUTO_INCREMENT,
    customer_name   VARCHAR(100) NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    phone           VARCHAR(15),
    city            VARCHAR(80),
    state           VARCHAR(80),
    pincode         VARCHAR(10),
    gender          ENUM('Male','Female','Other'),
    age             INT,
    registered_on   DATE,
    segment         ENUM('New','Regular','Premium') DEFAULT 'New'
);

-- 2. CATEGORIES
CREATE TABLE categories (
    category_id     INT PRIMARY KEY AUTO_INCREMENT,
    category_name   VARCHAR(100) NOT NULL,
    parent_category VARCHAR(100)
);

-- 3. PRODUCTS
CREATE TABLE products (
    product_id      INT PRIMARY KEY AUTO_INCREMENT,
    product_name    VARCHAR(200) NOT NULL,
    category_id     INT,
    brand           VARCHAR(100),
    cost_price      DECIMAL(10,2),
    selling_price   DECIMAL(10,2),
    stock_qty       INT DEFAULT 0,
    rating          DECIMAL(2,1),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. ORDERS
CREATE TABLE orders (
    order_id        INT PRIMARY KEY AUTO_INCREMENT,
    customer_id     INT,
    order_date      DATE NOT NULL,
    delivery_date   DATE,
    status          ENUM('Pending','Shipped','Delivered','Cancelled','Returned'),
    payment_method  ENUM('UPI','Credit Card','Debit Card','COD','Net Banking'),
    discount_pct    DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. ORDER ITEMS
CREATE TABLE order_items (
    item_id         INT PRIMARY KEY AUTO_INCREMENT,
    order_id        INT,
    product_id      INT,
    quantity        INT NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 6. RETURNS
CREATE TABLE returns (
    return_id       INT PRIMARY KEY AUTO_INCREMENT,
    order_id        INT,
    return_date     DATE,
    reason          VARCHAR(200),
    refund_amount   DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- ============================================================
--  SAMPLE DATA
-- ============================================================

INSERT INTO categories (category_name, parent_category) VALUES
('Mobile Phones',   'Electronics'),
('Laptops',         'Electronics'),
('Headphones',      'Electronics'),
('Kurtas',          'Clothing'),
('Sneakers',        'Footwear'),
('Kitchen Appliances', 'Home & Kitchen'),
('Books',           'Books & Stationery'),
('Skincare',        'Beauty & Health');

INSERT INTO customers (customer_name, email, phone, city, state, pincode, gender, age, registered_on, segment) VALUES
('Aarav Sharma',    'aarav.sharma@gmail.com',   '9823001111', 'Pune',      'Maharashtra', '411001', 'Male',   28, '2022-03-10', 'Premium'),
('Priya Mehta',     'priya.mehta@yahoo.com',    '9823002222', 'Mumbai',    'Maharashtra', '400001', 'Female', 34, '2021-07-15', 'Premium'),
('Rohit Verma',     'rohit.v@hotmail.com',      '9823003333', 'Delhi',     'Delhi',       '110001', 'Male',   25, '2023-01-20', 'Regular'),
('Sneha Patil',     'sneha.patil@gmail.com',    '9823004444', 'Nagpur',    'Maharashtra', '440001', 'Female', 30, '2022-11-05', 'Regular'),
('Kunal Joshi',     'kunal.j@gmail.com',        '9823005555', 'Bengaluru', 'Karnataka',   '560001', 'Male',   27, '2023-06-18', 'New'),
('Ananya Singh',    'ananya.s@rediffmail.com',  '9823006666', 'Hyderabad', 'Telangana',   '500001', 'Female', 22, '2023-08-01', 'New'),
('Vikram Nair',     'vikram.nair@gmail.com',    '9823007777', 'Chennai',   'Tamil Nadu',  '600001', 'Male',   40, '2020-05-12', 'Premium'),
('Divya Rao',       'divya.rao@outlook.com',    '9823008888', 'Kolkata',   'West Bengal', '700001', 'Female', 32, '2021-09-25', 'Regular'),
('Arjun Kulkarni',  'arjun.kul@gmail.com',      '9823009999', 'Pune',      'Maharashtra', '411002', 'Male',   29, '2022-04-07', 'Regular'),
('Meera Iyer',      'meera.iyer@gmail.com',     '9823010000', 'Bengaluru', 'Karnataka',   '560002', 'Female', 26, '2023-02-14', 'New');

INSERT INTO products (product_name, category_id, brand, cost_price, selling_price, stock_qty, rating) VALUES
('Samsung Galaxy S23',          1, 'Samsung',  55000, 72999,  80, 4.5),
('Apple iPhone 15',             1, 'Apple',    75000, 99999,  50, 4.8),
('Redmi Note 13 Pro',           1, 'Redmi',    18000, 24999, 200, 4.2),
('HP Pavilion 15 Laptop',       2, 'HP',       45000, 62999,  30, 4.3),
('Dell Inspiron 14',            2, 'Dell',     50000, 68000,  25, 4.4),
('Sony WH-1000XM5',             3, 'Sony',     18000, 29999,  60, 4.7),
('boAt Airdopes 141',           3, 'boAt',      1200,  1999, 300, 4.0),
('Manyavar Festive Kurta',      4, 'Manyavar',  1200,  1999, 150, 4.1),
('Puma Running Sneakers',       5, 'Puma',      3500,  5999, 120, 4.3),
('Prestige Induction Cooktop',  6, 'Prestige',  3200,  4999,  70, 4.2),
('Atomic Habits (Book)',        7, 'Clear',      200,   499, 500, 4.9),
('Mamaearth Vitamin C Serum',  8, 'Mamaearth',  350,   699, 200, 4.0);

INSERT INTO orders (customer_id, order_date, delivery_date, status, payment_method, discount_pct) VALUES
(1,  '2024-01-05', '2024-01-09', 'Delivered',  'UPI',         10.00),
(2,  '2024-01-12', '2024-01-17', 'Delivered',  'Credit Card',  5.00),
(3,  '2024-01-20', '2024-01-25', 'Delivered',  'COD',          0.00),
(4,  '2024-02-03', '2024-02-08', 'Delivered',  'Debit Card',   8.00),
(5,  '2024-02-14', NULL,         'Cancelled',  'UPI',          0.00),
(6,  '2024-02-20', '2024-02-26', 'Delivered',  'Net Banking',  0.00),
(7,  '2024-03-01', '2024-03-05', 'Returned',   'Credit Card', 15.00),
(8,  '2024-03-10', '2024-03-15', 'Delivered',  'UPI',          5.00),
(9,  '2024-03-22', '2024-03-27', 'Delivered',  'COD',          0.00),
(10, '2024-04-01', '2024-04-06', 'Delivered',  'UPI',          0.00),
(1,  '2024-04-15', '2024-04-20', 'Delivered',  'Credit Card', 12.00),
(2,  '2024-05-02', '2024-05-07', 'Delivered',  'UPI',          0.00),
(3,  '2024-05-18', NULL,         'Shipped',    'Debit Card',   5.00),
(7,  '2024-06-01', '2024-06-06', 'Delivered',  'Credit Card', 20.00),
(8,  '2024-06-15', '2024-06-20', 'Delivered',  'UPI',         10.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1,  2,  1, 99999),  -- iPhone 15
(1,  6,  1, 29999),  -- Sony Headphones
(2,  1,  1, 72999),  -- Samsung S23
(3,  3,  2, 24999),  -- Redmi Note 13 x2
(4,  8,  3,  1999),  -- Kurta x3
(5,  9,  1,  5999),  -- Puma Sneakers (cancelled)
(6,  11, 2,   499),  -- Atomic Habits x2
(7,  4,  1, 62999),  -- HP Laptop (returned)
(8,  7,  2,  1999),  -- boAt Airdopes x2
(9,  10, 1,  4999),  -- Prestige Induction
(10, 12, 2,   699),  -- Mamaearth Serum x2
(11, 5,  1, 68000),  -- Dell Laptop
(12, 6,  1, 29999),  -- Sony Headphones
(13, 3,  1, 24999),  -- Redmi Note
(14, 2,  1, 99999),  -- iPhone 15
(15, 9,  2,  5999);  -- Puma Sneakers x2

INSERT INTO returns (order_id, return_date, reason, refund_amount) VALUES
(7, '2024-03-08', 'Product damaged on arrival', 62999.00);


-- ============================================================
--  15 ANALYSIS QUERIES FOR YOUR GITHUB PROJECT
-- ============================================================

-- Q1: Total Revenue (only Delivered orders)
SELECT 
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - o.discount_pct/100)), 2) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered';

-- Q2: Monthly Revenue Trend
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id)          AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - o.discount_pct/100)), 2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

-- Q3: Top 5 Best-Selling Products by Revenue
SELECT 
    p.product_name,
    SUM(oi.quantity)                                              AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)                    AS gross_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o   ON oi.order_id   = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.product_name
ORDER BY gross_revenue DESC
LIMIT 5;

-- Q4: Revenue by Category
SELECT 
    c.category_name,
    SUM(oi.quantity)                                              AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)                    AS revenue
FROM order_items oi
JOIN products  p ON oi.product_id  = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN orders    o ON oi.order_id    = o.order_id
WHERE o.status = 'Delivered'
GROUP BY c.category_name
ORDER BY revenue DESC;

-- Q5: Customer Segmentation by Spend
SELECT 
    cust.customer_name,
    cust.segment,
    cust.city,
    COUNT(DISTINCT o.order_id)                                          AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - o.discount_pct/100)), 2) AS total_spent
FROM customers cust
JOIN orders     o  ON cust.customer_id = o.customer_id
JOIN order_items oi ON o.order_id      = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY cust.customer_id, cust.customer_name, cust.segment, cust.city
ORDER BY total_spent DESC;

-- Q6: Payment Method Popularity
SELECT 
    payment_method,
    COUNT(*)                               AS order_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct_share
FROM orders
WHERE status != 'Cancelled'
GROUP BY payment_method
ORDER BY order_count DESC;

-- Q7: Cancellation & Return Rate
SELECT 
    status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS pct
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- Q8: Average Delivery Time (in days)
SELECT 
    ROUND(AVG(DATEDIFF(delivery_date, order_date)), 1) AS avg_delivery_days
FROM orders
WHERE status = 'Delivered' AND delivery_date IS NOT NULL;

-- Q9: City-wise Revenue
SELECT 
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - o.discount_pct/100)), 2) AS revenue
FROM customers c
JOIN orders      o  ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY c.city, c.state
ORDER BY revenue DESC;

-- Q10: Profit Margin by Product
SELECT 
    p.product_name,
    p.cost_price,
    p.selling_price,
    ROUND((p.selling_price - p.cost_price) * 100.0 / p.selling_price, 1) AS margin_pct
FROM products p
ORDER BY margin_pct DESC;

-- Q11: Repeat Customers (purchased more than once)
SELECT 
    cust.customer_name,
    cust.email,
    COUNT(DISTINCT o.order_id) AS purchase_count
FROM customers cust
JOIN orders o ON cust.customer_id = o.customer_id
WHERE o.status = 'Delivered'
GROUP BY cust.customer_id, cust.customer_name, cust.email
HAVING purchase_count > 1
ORDER BY purchase_count DESC;

-- Q12: Impact of Discounts on Order Volume
SELECT 
    CASE 
        WHEN discount_pct = 0          THEN 'No Discount'
        WHEN discount_pct BETWEEN 1 AND 10 THEN '1–10%'
        WHEN discount_pct BETWEEN 11 AND 20 THEN '11–20%'
        ELSE '20%+'
    END AS discount_bucket,
    COUNT(*) AS order_count,
    ROUND(AVG(discount_pct), 1) AS avg_discount
FROM orders
WHERE status = 'Delivered'
GROUP BY discount_bucket
ORDER BY avg_discount;

-- Q13: Weekend vs Weekday Orders
SELECT 
    CASE WHEN DAYOFWEEK(order_date) IN (1,7) THEN 'Weekend' ELSE 'Weekday' END AS day_type,
    COUNT(*) AS orders
FROM orders
GROUP BY day_type;

-- Q14: Gender-wise Purchase Preference by Category
SELECT 
    c.gender,
    cat.category_name,
    COUNT(DISTINCT o.order_id) AS orders
FROM customers c
JOIN orders       o  ON c.customer_id  = o.customer_id
JOIN order_items  oi ON o.order_id     = oi.order_id
JOIN products     p  ON oi.product_id  = p.product_id
JOIN categories  cat ON p.category_id  = cat.category_id
WHERE o.status = 'Delivered'
GROUP BY c.gender, cat.category_name
ORDER BY c.gender, orders DESC;

-- Q15: Low Stock Alert (stock < 50)
SELECT 
    p.product_name,
    c.category_name,
    p.stock_qty,
    p.selling_price
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE p.stock_qty < 50
ORDER BY p.stock_qty;

-- ============================================================
--  END OF FILE
-- ============================================================
