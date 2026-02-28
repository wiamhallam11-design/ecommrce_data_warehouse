/* =====================================================
   LAYER: RELATIONSHIPS
   DESCRIPTION:
   Adding foreign key constraints
===================================================== */
ALTER TABLE fact_orders
MODIFY COLUMN order_date DATE;
alter table fact_orders 
add constraint fk_date 
foreign key(order_date)
references dim_date(date_id) ;
alter table fact_orders 
add constraint fk_customer 
foreign key(customer_id)
references dim_customers(customer_id) ;
