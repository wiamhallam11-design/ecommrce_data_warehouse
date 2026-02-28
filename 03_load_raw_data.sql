/* =====================================================
   LAYER: RAW / DATA INGESTION
   DESCRIPTION:
   Loads CSV files into staging tables
===================================================== */

-- Load orders dataset
LOAD DATA INFILE 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE orders_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
order_id,
customer_id,
order_status,
@order_purchase_timestamp,
@order_approved_at,
@order_delivered_carrier_date,
@order_delivered_customer_date,
@order_estimated_delivery_date
)
SET
order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
order_approved_at = NULLIF(@order_approved_at, ''),
order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');

--load customers dataset
load data INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
into table customers_raw
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
IGNORE 1 ROWS;
select *from customers_raw;
select count(*) from customers_raw;

--load order items dataset
load data INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
into table orders_items_raw
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

--load payments dataset
load data infile 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv'
into table payment_raw
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

--load products dataset
load data infile 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
into table product_raw
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(
product_id,
product_category_name,
@product_name_lenght,
@product_description_lenght ,
@product_photos_qty ,
@product_weight_g ,
@product_length_cm ,
@product_height_cm ,
@product_width_cm 
)
set 
product_name_lenght=nullif(@product_name_lenght,''),
product_description_lenght=nullif(@product_description_lenght,''),
product_photos_qty=nullif(@product_photos_qty ,''),
product_weight_g =nullif(@product_weight_g,''),
product_length_cm =nullif(@product_length_cm,''),
product_height_cm=nullif(@product_height_cm,''),
product_width_cm =nullif(@product_width_cm,'');