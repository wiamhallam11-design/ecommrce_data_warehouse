/* =====================================================
   LAYER: DIMENSIONS
   DESCRIPTION:
   Dimension tables for analytical reporting
===================================================== */

--create dimension tables for customers
CREATE TABLE dim_customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(50)
);

--insert distinct customers into dimension table
INSERT INTO dim_customers (customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM customers;

--create dimension table for products
CREATE TABLE dim_products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

--insert distinct products into dimension table
INSERT INTO dim_products
SELECT DISTINCT
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM products;

--create dimension table for sellers
CREATE TABLE dim_sellers (
seller_id varchar(50) primary key
);
insert into dim_sellers
select distinct seller_id
from orders_items
where seller_id is not null;
create table dim_date (
date_id date primary key ,
year int,
month int ,
day int,
quarter int ,
week int ,
weekday int 
);

--insert distinct dates into dimension table
insert into dim_date(
date_id, year, month,day,quarter,week,weekday)
select distinct
date(order_purchase_timestamp) as date_id,
year(order_purchase_timestamp),
month(order_purchase_timestamp),
day(order_purchase_timestamp),
quarter(order_purchase_timestamp),
week(order_purchase_timestamp),
weekday(order_purchase_timestamp)+1
from orders
where order_purchase_timestamp is not null;