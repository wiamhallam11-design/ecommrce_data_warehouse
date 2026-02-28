/* =====================================================
   LAYER: DATA QUALITY VALIDATION
   DESCRIPTION:
   This section validates raw data before transformation.
   Checks include:
   - Null values
   - Referential integrity
   - Duplicates
   - Invalid values
   - Business logic validation
===================================================== */

USE ecommerce_dw;

-- =====================================================
--CHECK FOR NULL PRIMARY KEYS
-- =====================================================

-- Check for NULL customer_id in customers_raw
SELECT *
FROM customers_raw
WHERE customer_id IS NULL;

-- Check for NULL order_id in orders_items_raw
SELECT *
FROM orders_items_raw
WHERE order_id IS NULL;

-- Check for NULL product_id in product_raw
SELECT *
FROM product_raw
WHERE product_id IS NULL;


-- =====================================================
--CHECK REFERENTIAL INTEGRITY
-- =====================================================

-- Orders that reference non-existing customers
SELECT *
FROM orders_raw o
LEFT JOIN customers_raw c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order items with invalid or missing products
SELECT *
FROM orders_items_raw o
LEFT JOIN product_raw p
ON o.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Orders without order items
SELECT *
FROM orders_raw o
LEFT JOIN orders_items_raw oi
ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

-- Orders without payments
SELECT *
FROM orders_raw o
LEFT JOIN payment_raw pa
ON o.order_id = pa.order_id
WHERE pa.order_id IS NULL;


-- =====================================================
--CHECK FOR INVALID NUMERIC VALUES
-- =====================================================

-- Check for zero or negative prices
SELECT *
FROM orders_items_raw
WHERE price <= 0;

-- Check for NULL payment values
SELECT *
FROM payment_raw
WHERE payment_value IS NULL;


-- =====================================================
-- CHECK BUSINESS LOGIC VALIDITY
-- =====================================================

-- Orders where delivery date is before purchase date
SELECT *
FROM orders_raw
WHERE order_purchase_timestamp > order_delivered_customer_date;

-- Delivered orders without delivered date (FIXED NULL CHECK)
SELECT COUNT(*)
FROM orders_raw
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NULL;


-- =====================================================
--CHECK FOR DUPLICATES
-- =====================================================

-- Customers with duplicate customer_id
SELECT customer_id, COUNT(*)
FROM customers_raw
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Compare total rows vs distinct customer_id
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS distinct_customer_ids
FROM customers_raw;

-- Compare total rows vs distinct customer_unique_id
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_unique_id) AS distinct_unique_ids
FROM customers_raw;

-- Count duplicate customer_id records
SELECT 
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_count
FROM customers_raw;


-- =====================================================
--  FINANCIAL CONSISTENCY CHECK
-- =====================================================
-- Compare total order items amount vs total payment

SELECT 
    CASE 
        WHEN ABS(oi.order_total - p.payment_total) <= 0.01 THEN 'MATCH'
        WHEN oi.order_total < p.payment_total THEN 'PAYMENT_HIGHER'
        WHEN oi.order_total > p.payment_total THEN 'ITEMS_HIGHER'
    END AS status,
    COUNT(*) AS orders_count
FROM
(
    SELECT order_id,
           SUM(price + freight_value) AS order_total
    FROM orders_items_raw
    GROUP BY order_id
) oi
JOIN
(
    SELECT order_id,
           SUM(payment_value) AS payment_total
    FROM payment_raw
    GROUP BY order_id
) p
ON oi.order_id = p.order_id
GROUP BY status;

