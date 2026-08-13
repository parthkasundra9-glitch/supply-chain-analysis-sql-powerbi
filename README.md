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





