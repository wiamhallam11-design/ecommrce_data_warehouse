/* =====================================================
   LAYER: BUSINESS ANALYSIS
   DESCRIPTION:
   KPI and revenue analysis queries
===================================================== */

-- Total revenue
select sum(order_total) as total_revenue
from fact_orders;

-- Revenue by year and month
select
    d.year,
    d.month,
    SUM(f.order_total) AS revenue
FROM fact_orders f
join dim_date d
on f.order_date = d.date_id
group by d.year, d.month
order by d.year, min(d.month);

-- Top 5 states by revenue
select 
    c.customer_state,
    sum(f.order_total) as revenue
from fact_orders f
join dim_customers c
on f.customer_id = c.customer_id
group by c.customer_state
order by revenue desc
limit 5;

-- Average order value
select avg(order_total) as avg_order_value
from fact_orders;

