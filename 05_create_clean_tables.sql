/* =====================================================
   LAYER: CLEANED / TRANSFORMED DATA
   DESCRIPTION:
   Removes duplicates, fixes nulls, enforces constraints
===================================================== */

--create clean customers table
create table customers (
customer_id varchar(50) primary key ,
customer_unique_id varchar(50) not null,
customer_zip_code_prefix int,     
customer_city varchar(50),
customer_state varchar(50)
);

--insert distinct customers, ensuring no null customer_id
insert into customers (
customer_id  ,
customer_unique_id ,
customer_zip_code_prefix ,
customer_city ,
customer_state
)
select distinct*
from customers_raw
where customer_id is not null;

--create clean orders table with foreign key to customers
create table orders(
order_id varchar(50) primary key,
customer_id varchar(50) not null,
order_status varchar(50),
order_purchase_timestamp datetime,
order_approved_at datetime,
order_delivered_carrier_date datetime,
order_delivered_customer_date datetime,
order_estimated_delivery_date datetime,
foreign key (customer_id) references customers(customer_id)
);

--insert distinct orders, ensuring no null order_id or customer_id, and handling empty strings as nulls
INSERT INTO orders (
    order_id, customer_id, order_status, 
    order_purchase_timestamp, order_approved_at, 
    order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date
)
SELECT DISTINCT
    order_id,
    customer_id,
    order_status,
    CASE WHEN TRIM(order_purchase_timestamp) = '' THEN NULL ELSE order_purchase_timestamp END,
    CASE WHEN TRIM(order_approved_at) = '' THEN NULL ELSE order_approved_at END,
    CASE WHEN TRIM(order_delivered_carrier_date) = '' THEN NULL ELSE order_delivered_carrier_date END,
    CASE WHEN TRIM(order_delivered_customer_date) = '' THEN NULL ELSE order_delivered_customer_date END,
    CASE WHEN TRIM(order_estimated_delivery_date) = '' THEN NULL ELSE order_estimated_delivery_date END
FROM orders_raw
WHERE order_id IS NOT NULL AND customer_id IS NOT NULL;

--create clean payments table with composite primary key and foreign key to orders
CREATE TABLE payments (
    order_id VARCHAR(50) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10,2),
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

--insert distinct payments, ensuring no null order_id or payment_sequential, and handling zero payment_value as null
INSERT INTO payments
SELECT DISTINCT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    NULLIF(payment_value,0)
FROM payment_raw
WHERE order_id IS NOT NULL AND payment_sequential IS NOT NULL;
create table orders_items(
order_id varchar(50) not null ,
order_item_id int not null,
product_id varchar(50) not null,
seller_id varchar(50),
shipping_limit_date datetime,
price decimal(10,2),
freight_value decimal(10,2),
primary key (order_id,order_item_id)
);
INSERT INTO orders_items (
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
SELECT DISTINCT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    
    CASE 
        WHEN TRIM(shipping_limit_date) = '' THEN NULL
        ELSE shipping_limit_date
    END,
    
    NULLIF(price, 0),
    NULLIF(freight_value, 0)

FROM orders_items_raw
WHERE order_id IS NOT NULL
  AND order_item_id IS NOT NULL
  AND product_id IS NOT NULL;
CREATE TABLE products(
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

INSERT INTO products
SELECT DISTINCT
    product_id,
    product_category_name,
    NULLIF(product_name_lenght,0),
    NULLIF(product_description_lenght,0),
    NULLIF(product_photos_qty,0),
    NULLIF(product_weight_g,0),
    NULLIF(product_length_cm,0),
    NULLIF(product_height_cm,0),
    NULLIF(product_width_cm,0)
FROM product_raw
WHERE product_id IS NOT NULL;