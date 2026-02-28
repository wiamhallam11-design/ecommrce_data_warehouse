/* =====================================================
   LAYER: FACT TABLE
   DESCRIPTION:
   Central table containing measurable business metrics
===================================================== */
CREATE TABLE fact_orders AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp AS order_date,
    o.order_status,
    SUM(oi.price) AS total_items_amount,
    SUM(oi.freight_value) AS total_freight,
    SUM(oi.price + oi.freight_value) AS order_total,
    COALESCE(p.total_payment, 0) AS total_payment
FROM orders o
JOIN orders_items oi ON o.order_id = oi.order_id
LEFT JOIN (
    SELECT order_id, SUM(payment_value) AS total_payment
    FROM payments
    GROUP BY order_id
) p ON o.order_id = p.order_id
GROUP BY 
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp,
    o.order_status;