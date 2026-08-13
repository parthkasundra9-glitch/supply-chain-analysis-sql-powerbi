# Supply Chain Analysis | PostgreSQL & Power BI

## 📊 Project Overview

This project analyzes supply chain and e-commerce data to identify key business trends related to sales, customers, products, profitability, order performance, and delivery operations.

The project uses **PostgreSQL** for data cleaning, database design, SQL analysis, and business insights, and **Power BI** for interactive dashboard development and data visualization.

---

## 🎯 Business Objective

The main objective of this project is to analyze supply chain performance and answer important business questions such as:

- How much total revenue and profit is generated?
- Which products and categories generate the highest revenue?
- Which customers contribute the most revenue?
- Which customer segment performs best?
- Which markets and departments generate the most revenue?
- Which shipping modes have better delivery performance?
- What percentage of orders are at risk of late delivery?
- How does revenue change over time?
- Which products and categories have the highest sales volume?
- How do discounts affect revenue?
- Which regions and cities generate the highest revenue?

---

## 🛠️ Tools & Technologies

- PostgreSQL
- SQL
- Power BI
- Power Query
- DAX
- GitHub

---

## 🗄️ Database Design

The raw supply chain dataset was initially loaded into a staging table and then transformed into a relational database structure.

### Main Tables

- `customers`
- `categories`
- `departments`
- `products`
- `orders`
- `order_items`
- `shipments`


---

## 📊 Power BI Dashboard

An interactive Power BI dashboard was developed to monitor key supply chain and business performance metrics.

### Key KPIs

- Total Sales
- Total Profit
- Average Order Value (AOV)
- Total Orders
- Total Customers
- Total Products
- Products Sold

### Dashboard Analysis

The dashboard provides insights into:

- Sales trends over time
- Revenue by category
- Revenue by department
- Revenue by market
- Order status distribution
- Revenue by customer segment
- Top 10 products by sales
- Top 10 customers by revenue
- Shipping mode performance
- Delivery performance
- Customer and market analysis

### Interactive Filters

The dashboard includes slicers for:

- Category
- Market
- Customer Segment
- Shipping Mode
- Year and Month

### Dashboard Preview

![Supply Chain Dashboard](Screenshot%202026-08-14%20010657.png)

### Power BI File

The Power BI dashboard file is available here:

[Download Power BI Dashboard](./Supply%20Chain%20Dashboard.pbix)

---

## 🔎 SQL Analysis

The project includes SQL analysis covering:

- Sales and revenue performance
- Profitability analysis
- Average Order Value (AOV)
- Top customers by revenue
- Top products by sales and quantity
- Category-wise and department-wise revenue
- Customer segment performance
- Market and regional analysis
- Shipping mode performance
- Delivery delay analysis
- Order status distribution
- Discount impact on revenue
- Monthly, quarterly, and yearly sales trends
- Customer and product ranking using window functions
- Top products within each category
- Running revenue analysis
- Revenue contribution by customer segment and department

Advanced SQL techniques used include:

- JOINs
- GROUP BY
- HAVING
- Subqueries
- CASE statements
- Common Table Expressions (CTEs)
- Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()
- DATE_TRUNC()
- Aggregate Functions


---

## 💡 Business Insights

The analysis helps identify:

- Overall sales, profit, orders, customers, and product performance.
- Top-performing products and categories based on revenue and sales volume.
- High-value customers contributing significantly to overall revenue.
- Customer segments with higher revenue and profitability contribution.
- Markets, regions, cities, and departments with stronger revenue performance.
- Shipping modes with better average delivery performance.
- Orders and shipments with higher late-delivery risk.
- Revenue trends across months, quarters, and years.
- Products with high sales volume and products with lower sales performance.
- The impact of discounts on revenue generation.
- Revenue contribution across customer segments and departments.


---

## 🔄 Project Workflow

1. Loaded the raw supply chain dataset into PostgreSQL.
2. Created a staging table for raw data.
3. Transformed the raw dataset into normalized relational tables.
4. Created primary key and foreign key relationships.
5. Performed data validation and quality checks.
6. Created indexes for frequently used columns.
7. Performed SQL-based business analysis.
8. Connected the PostgreSQL database with Power BI.
9. Built DAX measures for KPI calculations.
10. Created an interactive Power BI dashboard.
11. Added slicers for dynamic business analysis.

---

## 📁 Repository Structure

```text
supply-chain-analysis-sql-powerbi/
│
├── supply_chain_db.sql
├── Supply Chain Dashboard.pbix
├── Screenshot 2026-08-14 010657.png
└── README.md


### Database Structure

```text
customers
    │
    └── orders
           │
           └── order_items
                  │
                  └── products
                         │
                         ├── categories
                         │
                         └── departments

orders
    │
    └── shipments
            


