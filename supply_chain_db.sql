CREATE TABLE supply_chain_raw (
    type TEXT,
    days_for_shipping_real INT,
    days_for_shipment_scheduled INT,
    benefit_per_order NUMERIC(12,2),
    sales_per_customer NUMERIC(12,2),
    delivery_status TEXT,
    late_delivery_risk INT,

    category_id INT,
    category_name TEXT,

    customer_city TEXT,
    customer_country TEXT,
    customer_email TEXT,
    customer_fname TEXT,
    customer_id INT,
    customer_lname TEXT,
    customer_password TEXT,
    customer_segment TEXT,
    customer_state TEXT,
    customer_street TEXT,
    customer_zipcode TEXT,

    department_id INT,
    department_name TEXT,

    latitude NUMERIC(10,6),
    longitude NUMERIC(10,6),

    market TEXT,

    order_city TEXT,
    order_country TEXT,
    order_customer_id INT,
    order_date TEXT,
    order_id INT,

    order_item_cardprod_id INT,
    order_item_discount NUMERIC(12,2),
    order_item_discount_rate NUMERIC(10,4),
    order_item_id INT,
    order_item_product_price NUMERIC(12,2),
    order_item_profit_ratio NUMERIC(10,4),
    order_item_quantity INT,
    sales NUMERIC(12,2),
    order_item_total NUMERIC(12,2),
    order_profit_per_order NUMERIC(12,2),

    order_region TEXT,
    order_state TEXT,
    order_status TEXT,
    order_zipcode TEXT,

    product_card_id INT,
    product_category_id INT,
    product_description TEXT,
    product_image TEXT,
    product_name TEXT,
    product_price NUMERIC(12,2),
    product_status INT,

    shipping_date TEXT,
    shipping_mode TEXT
);

select count(*) from supply_chain_raw
SELECT *
FROM supply_chain_raw
LIMIT 5;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_fname VARCHAR(100),
    customer_lname VARCHAR(100),
    customer_email VARCHAR(255),
    customer_password TEXT,
    customer_segment VARCHAR(100),
    customer_city VARCHAR(100),
    customer_state VARCHAR(100),
    customer_country VARCHAR(100),
    customer_street TEXT,
    customer_zipcode VARCHAR(20),
    latitude NUMERIC(10,6),
    longitude NUMERIC(10,6)
);

INSERT INTO customers
SELECT DISTINCT
    customer_id,
    customer_fname,
    customer_lname,
    customer_email,
    customer_password,
    customer_segment,
    customer_city,
    customer_state,
    customer_country,
    customer_street,
    customer_zipcode,
    latitude,
    longitude
FROM supply_chain_raw;

select * from customers
limit 10;

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

INSERT INTO categories
SELECT DISTINCT
    category_id,
    category_name
FROM supply_chain_raw;

SELECT COUNT(*)
FROM categories;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments
SELECT DISTINCT
    department_id,
    department_name
FROM supply_chain_raw;

SELECT COUNT(*)
FROM departments;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name TEXT,
    product_price NUMERIC(10,2),
    product_status INT,
    product_category_id INT,
    product_image TEXT,
    product_description TEXT
);

INSERT INTO products
SELECT DISTINCT
    product_card_id,
    product_name,
    product_price,
    product_status,
    product_category_id,
    product_image,
    product_description
FROM supply_chain_raw;

SELECT COUNT(*)
FROM products;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP,
    order_status VARCHAR(50),
    order_city VARCHAR(100),
    order_state VARCHAR(100),
    order_country VARCHAR(100),
    order_region VARCHAR(100),
    market VARCHAR(100),
    order_zipcode VARCHAR(20),
    order_profit_per_order NUMERIC(12,2)
);

INSERT INTO orders
SELECT DISTINCT
    order_id,
    customer_id,
    TO_TIMESTAMP(order_date,'MM/DD/YYYY HH24:MI'),
    order_status,
    order_city,
    order_state,
    order_country,
    order_region,
    market,
    order_zipcode,
    order_profit_per_order
FROM supply_chain_raw;

SELECT COUNT(*)
FROM orders;

DROP TABLE orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP,
    order_status VARCHAR(50),
    order_city VARCHAR(100),
    order_state VARCHAR(100),
    order_country VARCHAR(100),
    order_region VARCHAR(100),
    market VARCHAR(100),
    order_zipcode VARCHAR(20)
);

INSERT INTO orders
SELECT DISTINCT ON (order_id)
    order_id,
    customer_id,
    TO_TIMESTAMP(order_date,'MM/DD/YYYY HH24:MI'),
    order_status,
    order_city,
    order_state,
    order_country,
    order_region,
    market,
    order_zipcode
FROM supply_chain_raw
ORDER BY order_id;

SELECT COUNT(*)
FROM orders;

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price NUMERIC(10,2),
    discount NUMERIC(10,2),
    discount_rate NUMERIC(10,4),
    sales NUMERIC(12,2),
    total_amount NUMERIC(12,2),
    profit_ratio NUMERIC(10,4),
    benefit_per_order NUMERIC(12,2)
);

INSERT INTO order_items
SELECT DISTINCT
    order_item_id,
    order_id,
    product_card_id,
    order_item_quantity,
    order_item_product_price,
    order_item_discount,
    order_item_discount_rate,
    sales,
    order_item_total,
    order_item_profit_ratio,
    benefit_per_order
FROM supply_chain_raw;

SELECT COUNT(*)
FROM order_items;

CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,
    order_id INT,
    shipping_mode VARCHAR(50),
    shipping_date TIMESTAMP,
    delivery_status VARCHAR(100),
    days_for_shipping_real INT,
    days_for_shipment_scheduled INT,
    late_delivery_risk INT
);

INSERT INTO shipments(
    order_id,
    shipping_mode,
    shipping_date,
    delivery_status,
    days_for_shipping_real,
    days_for_shipment_scheduled,
    late_delivery_risk
)
SELECT DISTINCT
    order_id,
    shipping_mode,
    TO_TIMESTAMP(shipping_date,'DD-MM-YYYY HH24:MI'),
    delivery_status,
    days_for_shipping_real,
    days_for_shipment_scheduled,
    late_delivery_risk
FROM supply_chain_raw;




ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE products
ADD CONSTRAINT fk_products_category
FOREIGN KEY (product_category_id)
REFERENCES categories(category_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

SELECT COUNT(*) AS total,
COUNT(DISTINCT customer_id) AS unique_customers
FROM customers;

SELECT COUNT(*) AS total,
COUNT(DISTINCT product_id) AS unique_products
FROM products;

SELECT COUNT(*) AS total,
COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

SELECT COUNT(*) AS total,
COUNT(DISTINCT order_item_id) AS unique_order_items
FROM order_items;

ALTER TABLE products
ADD COLUMN department_id INT;

UPDATE products p
SET department_id = s.department_id
FROM supply_chain_raw s
WHERE p.product_id = s.product_card_id;

ALTER TABLE products
ADD CONSTRAINT fk_products_departments
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

-- Performance Optimization

CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_orderitems_product
ON order_items(product_id);

CREATE INDEX idx_orderitems_order
ON order_items(order_id);

CREATE INDEX idx_products_category
ON products(product_category_id);

CREATE INDEX idx_shipments_order
ON shipments(order_id);

-- Sales Analysis
-- 1.Total sales
SELECT
    ROUND(SUM(sales),2) AS total_sales
FROM order_items;

-- 2.Total orders
SELECT
    COUNT(*) AS total_orders
FROM orders;

-- 3.Total customers
SELECT
    COUNT(*) AS total_customers
FROM customers;

-- 4.Total products
SELECT
    COUNT(*) AS total_products
FROM products;

-- 5.AOV
SELECT
    ROUND(SUM(sales) / COUNT(DISTINCT order_id),2) AS average_order_value
FROM order_items;

-- 6.Top 10 customer by sales
SELECT
    c.customer_id,
    CONCAT(c.customer_fname,' ',c.customer_lname) AS customer_name,
    ROUND(SUM(oi.sales),2) AS total_sales
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- 7.Top 10 products
SELECT
    p.product_name,
    ROUND(SUM(oi.sales),2) AS total_sales
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY
    p.product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 8.Top categories by sales
SELECT
    c.category_name,
    ROUND(SUM(oi.sales),2) AS total_sales
FROM categories c
JOIN products p
ON c.category_id = p.product_category_id
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY
    c.category_name
ORDER BY total_sales DESC;

-- 9. Top customer segment
SELECT
customer_segment,
ROUND(SUM(oi.total_amount),2) AS sales
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_segment
ORDER BY sales DESC;

-- 10.customer by country
SELECT
customer_country,
COUNT(*) AS customers
FROM customers
GROUP BY customer_country
ORDER BY customers DESC;

-- Supply Chain Insights
-- 11.Late delivery
SELECT
ROUND(100.0*SUM(late_delivery_risk)/COUNT(*),2) AS late_delivery_percentage
FROM shipments;

-- 12.delivery status
SELECT
delivery_status,
COUNT(*) AS total_orders
FROM shipments
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- 13.Shipping mode performance
SELECT
shipping_mode,
ROUND(AVG(days_for_shipping_real),2) AS avg_delivery_days
FROM shipments
GROUP BY shipping_mode
ORDER BY avg_delivery_days;

-- 14.order status distribution
SELECT
order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- product analysis
-- 15. Top 10 product by quantity sold
select p.product_id, p.product_name, sum(oi.quantity) as sold_quantity
from products p
join order_items oi
on p.product_id= oi.product_id
group by p.product_id, p.product_name
order by sold_quantity desc
limit 10;

-- 16.Lowest selling product
select p.product_id, p.product_name, sum(oi.quantity) as l_quantity
from products p
join order_items oi
on p.product_id= oi.product_id
group by p.product_id, p.product_name
order by l_quantity asc
limit 10;

-- 17.Most profitable product
select p.product_id, p.product_name, sum(oi.benefit_per_order) as profitable_product
from products p
join order_items oi
on p.product_id= oi.product_id
group by p.product_id, p.product_name
order by profitable_product desc
limit 10;

-- 18.category wise revnue
select c.category_id,c.category_name, sum(oi.total_amount) as revune
from categories c
join products p
on c.category_id= p.product_category_id
join order_items oi
on p.product_id= oi.product_id
group by c.category_id, c.category_name
order by revune desc

-- 19.department wise profit
SELECT d.department_name, SUM(oi.benefit_per_order) AS total_profit
FROM departments d
JOIN products p
ON d.department_id = p.department_id
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY d.department_name
ORDER BY total_profit DESC;

-- 20.Avg product price by category
SELECT  c.category_name, AVG(p.product_price) AS avg_product_price
FROM categories c
JOIN products p
ON c.category_id = p.product_category_id
GROUP BY c.category_name
ORDER BY avg_product_price DESC;

-- 21.Number of product in each category
select c.category_name, count(*) as total_product
from categories c
join products p
on c.category_id=p.product_category_id
group by c.category_name
order by total_product desc

-- 22.Number of Products in Each Department
select d.department_name, COUNT(*) AS total_products
from departments d
join products p
ON d.department_id = p.department_id
group BY d.department_name
ORDER BY total_products DESC;

-- 23.Which Customer Segment Generates Highest Profit?
select c.customer_segment, sum(oi.benefit_per_order) as total_profit
from customers c
join orders o
on c.customer_id= o.customer_id
join order_items oi
on oi.order_id= o.order_id
group by c.customer_segment
order by total_profit desc

-- 24.Top 10 Cities by Revenue
select c.customer_city, sum(oi.total_amount) as revenue
from customers c
join orders o
on c.customer_id=o.customer_id
join order_items oi
on o.order_id=oi.order_id
group by c.customer_city
order by revenue desc
limit 10;

-- 25.Revenue by Shipping Mode
SELECT  s.shipping_mode, ROUND(SUM(oi.total_amount),2) AS revenue
FROM shipments s
JOIN order_items oi
ON s.order_id = oi.order_id
GROUP BY s.shipping_mode
ORDER BY revenue DESC;

-- 26.Average Delivery Days by Region
select o.order_region, avg(days_for_shipping_real) as avg_delivery_day
from orders o
join shipments s
on o.order_id = s.order_id
group by o.order_region
order by avg_delivery_day desc

-- 27.Discount Impact on Revenue
select 
      case
	      when discount=0 then 'no discount'
		  else 'discount applied'
	  end as discount_status,
	  sum(total_amount) as revenue
from order_items
group by discount_status;

-- Advanced Business Analysis
-- 28.Average Profit Per Order
SELECT
    ROUND(AVG(profit_per_order), 2) AS average_profit_per_order
FROM (
    SELECT
        order_id,
        SUM(benefit_per_order) AS profit_per_order
    FROM order_items
    GROUP BY order_id
) t;

-- 29.Top 10 Highest Profit Orders
select order_id, sum(benefit_per_order)as profit_order
from order_items 
group by order_id
order by profit_order desc
limit 10;

-- 30.Average Discount Given
SELECT
    ROUND(AVG(discount),2) AS average_discount
FROM order_items;

-- 31.Revenue Lost Due to Discount
SELECT
    ROUND(SUM(discount),2) AS total_discount_given
FROM order_items;

-- 32.Orders with Highest Discount
SELECT order_id, ROUND(SUM(discount),2) AS total_discount
FROM order_items
GROUP BY order_id
ORDER BY total_discount DESC
LIMIT 10;

-- 33.Average Quantity per Order
SELECT
    ROUND(AVG(order_quantity),2) AS avg_quantity_per_order
FROM
(
    SELECT
        order_id,
        SUM(quantity) AS order_quantity
    FROM order_items
    GROUP BY order_id
) t;

-- 34.Products Never Discounted
select DISTINCT p.product_name
from products p
join order_items oi
on p.product_id=oi.product_id
where oi.discount =0;

-- 35.Orders with More Than 5 Products
select order_id, sum(quantity) as total_p
from order_items
group by order_id
having sum(quantity) > 5
order by total_p desc

-- 36.Average Product Profit
select p.product_name, round(avg(oi.benefit_per_order),2) as avg_order
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.product_name
order by avg_order desc

-- 37.Customer Segment Contribution (%)
select c.customer_segment, round(sum(oi.total_amount)*100/(select sum(total_amount)
from order_items),2) as revenue_p
from customers c
join orders o
on c.customer_id=o.customer_id
join order_items oi
on o.order_id=oi.order_id
group by c.customer_segment
order by revenue_p desc

-- 38.Department Contribution (%)
SELECT d.department_name, SUM(oi.total_amount) * 100 /
(SELECT SUM(total_amount) FROM order_items) AS revenue_percentage
FROM departments d
JOIN products p
ON d.department_id = p.department_id
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY d.department_name
ORDER BY revenue_percentage DESC;

-- Advance query
-- 39.Top 3 Products in Each Category (ROW_NUMBER)
With product_sales as(
    SELECT
        c.category_name,
        p.product_name,
        ROUND(SUM(oi.total_amount),2) AS revenue
FROM categories c
JOIN products p
ON c.category_id = p.product_category_id
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY c.category_name, p.product_name
)
select * from(
              select *,
			  row_number() over(partition by category_name order by revenue desc)
			  as rn
			  from product_sales
			  )t
			  where rn<=3;
			  
)

-- 40.Customer Ranking by Revenue (RANK)
select c.customer_id, c.customer_fname,c.customer_lname,sum(oi.total_amount) as revenue, 
rank() over(order by sum(oi.total_amount) desc) as ranking
from customers c
join orders o
on c.customer_id=o.customer_id
join order_items oi
on o.order_id = oi.order_id
group by c.customer_id, c.customer_fname, c.customer_lname;


-- 41.Product Ranking (DENSE_RANK)
select p.product_name, sum(oi.total_amount) as revenue,
dense_rank() over(order by sum(total_amount) desc) as ranking
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.product_name

-- 42.Previous Order amount (LAG)
select order_id,total_amount,
lag(total_amount) over(order by order_id) as previous_o_amount
from order_items;

-- 43.Next Order amount (LEAD)
select order_id, total_amount,
lead(total_amount) over(order by order_id) as next_o_amount
from order_items

-- 44.Running revenue(Cumulative)
SELECT order_id, total_amount,
SUM(total_amount) OVER( ORDER BY order_id) AS running_revenue
FROM order_items;

-- 45.Average Revenue by Category
select c.category_name, round(avg(oi.total_amount),2)as avg_revenue
from categories c
join products p
on c.category_id=p.product_category_id
join order_items oi
on p.product_id=oi.product_id
group by c.category_name
order by avg_revenue desc;

-- 46.Monthly Sales Trend
select
     DATE_TRUNC('month',o.order_date) as month,
     round(sum(oi.sales),2) as revenue 
from orders o
join order_items oi
on o.order_id=oi.order_id
group by month
order by month;

-- 47.Quarterly Revenue
SELECT
    DATE_TRUNC('quarter', o.order_date) AS quarter,
    ROUND(SUM(oi.total_amount),2) AS revenue
from orders o
join order_items oi
on o.order_id = oi.order_id
group BY quarter
order BY quarter;

-- 48.Yearly revenue
SELECT
    EXTRACT(YEAR FROM o.order_date) AS year,
    ROUND(SUM(oi.total_amount),2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY year
ORDER BY year;

-- 49.Highest Revenue Market
SELECT
    o.market,
    ROUND(SUM(oi.total_amount),2) AS revenue,
    ROUND(
        SUM(oi.total_amount) * 100.0 /
        (SELECT SUM(total_amount) FROM order_items),
        2
    ) AS contribution_percentage
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.market
ORDER BY revenue DESC;

-- 50.Average Delivery Delay by Shipping Mode
SELECT
    shipping_mode,
    ROUND(AVG(days_for_shipping_real),2) AS avg_actual_days,
    ROUND(AVG(days_for_shipment_scheduled),2) AS avg_scheduled_days,
    ROUND(
        AVG(days_for_shipping_real - days_for_shipment_scheduled),
        2
    ) AS avg_delay_days
FROM shipments
GROUP BY shipping_mode
ORDER BY avg_delay_days;

