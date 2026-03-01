/* =====================================================
   LAYER: RELATIONSHIPS
   DESCRIPTION:
   Adding foreign key constraints
===================================================== */

-- Add foreign key constraints to fact_orders
ALTER TABLE fact_orders
ADD CONSTRAINT fk_customer FOREIGN KEY(customer_id) 
REFERENCES dim_customers(customer_id);

ALTER TABLE fact_orders
ADD CONSTRAINT fk_date FOREIGN KEY(order_date)
REFERENCES dim_date(date_id);

-- Add foreign key constraints to fact_order_items
ALTER TABLE fact_order_items
ADD CONSTRAINT fkk_customer FOREIGN KEY (customer_id)
REFERENCES dim_customers(customer_id);

ALTER TABLE fact_order_items
ADD CONSTRAINT fkk_product FOREIGN KEY (product_id)
REFERENCES dim_products(product_id);

ALTER TABLE fact_order_items
ADD CONSTRAINT fk_seller FOREIGN KEY (seller_id)
REFERENCES dim_sellers(seller_id);

ALTER TABLE fact_order_items
ADD CONSTRAINT fkk_date FOREIGN KEY (order_date)
REFERENCES dim_date(date_id);
