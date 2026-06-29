# E-Commerce Sales Analysis — SQL Project

![MySQL](https://img.shields.io/badge/MySQL-005C84?style=flat&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analysis-orange)
![Status](https://img.shields.io/badge/Status-Completed-green)

## Overview
MySQL-based analysis of an online retail dataset covering
customers, products, orders, and returns across 6 Indian cities.

## Tech Stack
- MySQL / MySQL Workbench
- SQL — Joins, Subqueries, Window Functions, Aggregations

## Database Schema
| Table | Description |
|---|---|
| `customers` | 10 customers across Pune, Mumbai, Delhi, Bengaluru |
| `products` | 12 Indian brand products (Apple, Samsung, boAt etc.) |
| `orders` | 15 orders with status & payment method |
| `order_items` | Product-level order details |
| `returns` | Return reasons & refund amounts |

## 15 Analysis Queries
| # | Query | Concept Used |
|---|---|---|
| Q1 | Total Revenue | SUM, WHERE |
| Q2 | Monthly Revenue Trend | GROUP BY, DATE_FORMAT |
| Q3 | Top 5 Best-Selling Products | ORDER BY, LIMIT |
| Q4 | Revenue by Category | JOIN, GROUP BY |
| Q5 | Customer Segmentation by Spend | JOIN, HAVING |
| Q6 | Payment Method Popularity | Window Function |
| Q7 | Cancellation & Return Rate | Subquery |
| Q8 | Average Delivery Time | DATEDIFF, AVG |
| Q9 | City-wise Revenue | Multi-table JOIN |
| Q10 | Profit Margin by Product | Arithmetic, ROUND |
| Q11 | Repeat Customers | HAVING COUNT > 1 |
| Q12 | Discount Impact on Sales | CASE WHEN |
| Q13 | Weekend vs Weekday Orders | DAYOFWEEK |
| Q14 | Gender-wise Category Preference | Multi JOIN |
| Q15 | Low Stock Alert | WHERE filter |

## Key Insights
- UPI is the most preferred payment method (40%+ orders)
- Electronics category drives highest revenue
- Premium customers contribute 60%+ of total sales
- Average delivery time: 5 days
- Discounts between 1–10% generate highest order volume

## How to Run
1. Install MySQL Workbench
2. Open `ecommerce_project.sql`
3. Run full file (Ctrl+Shift+Enter)
4. Execute individual queries for analysis
