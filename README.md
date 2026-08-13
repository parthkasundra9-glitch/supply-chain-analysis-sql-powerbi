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

![Supply Chain Dashboard](screenshots/supply_chain_dashboard.png)

### Power BI File

The Power BI dashboard file is available here:

[Download Power BI Dashboard](powerbi/Supply_Chain_Analysis.pbix)


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
            


