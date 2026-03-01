/* =====================================================
   LAYER: DIMENSIONS
   DESCRIPTION:
   Dimension tables for analytical reporting
===================================================== */

-- Create customers dimension table
CREATE dim_customers AS
SELECT DISTINCT * FROM customers;

-- Create products dimension table
CREATE TABLE dim_products AS
SELECT DISTINCT 
    product_id,
    product_category_name,
    product_name_length AS product_name_length,
    product_description_length AS product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM products;

-- Create sellers dimension table
CREATE TABLE dim_sellers AS
SELECT DISTINCT seller_id FROM orders_items WHERE seller_id IS NOT NULL;

-- Create date dimension table
CREATE TABLE dim_date AS
SELECT DISTINCT
    DATE(order_purchase_timestamp) AS date_id,
    YEAR(order_purchase_timestamp) AS year,
    MONTH(order_purchase_timestamp) AS month,
    DAY(order_purchase_timestamp) AS day,
    QUARTER(order_purchase_timestamp) AS quarter,
    WEEK(order_purchase_timestamp) AS week,
    WEEKDAY(order_purchase_timestamp)+1 AS weekday
FROM orders
WHERE order_purchase_timestamp IS NOT NULL;

-- Add customer_id as primary key to dim_customers
ALTER TABLE dim_customers
ADD PRIMARY KEY (customer_id);

-- Add product_id as primary key to dim_products
ALTER TABLE dim_products
ADD PRIMARY KEY (product_id);

-- Add seller_id as primary key to dim_sellers
ALTER TABLE dim_sellers
ADD PRIMARY KEY (seller_id);

-- Add date_id as primary key to dim_date
ALTER TABLE dim_date
ADD PRIMARY KEY (date_id);