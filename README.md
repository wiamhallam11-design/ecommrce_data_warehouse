E-Commerce Data Warehouse Project (MySQL)
Project Overview

This is my first Data Engineering project.

In this project, I built a simple Data Warehouse in MySQL using the Brazilian Olist E-Commerce dataset. The goal was to practice core Data Engineering concepts such as:

Loading raw data from CSV files

Cleaning and validating data

Creating relational tables with primary and foreign keys

Designing a dimensional model (star schema)

Writing analytical SQL queries

This project helped me understand how raw transactional data can be transformed into a structure suitable for reporting and analysis.

Dataset

This project uses the Brazilian Olist E-Commerce dataset from Kaggle:
Olist E-Commerce Dataset:https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

The dataset includes information about:

Customers

Orders

Order items

Products

Payments

Project Structure

The project is organized into multiple SQL scripts to simulate a simple ETL workflow:

01_create_database.sql – Create the database

02_create_raw_tables.sql – Define raw tables to load CSVs

03_load_raw_data.sql – Load raw CSV data into raw tables

04_data_quality_checks.sql – Perform validations on raw data

05_create_clean_tables.sql – Clean data and remove duplicates

06_create_dimensions.sql – Create dimension tables (dim_customers, dim_products, dim_sellers, dim_date)

07_create_fact_table.sql – Create fact tables (fact_orders, fact_order_items)

08_add_constraints.sql – Add primary and foreign key constraints

09_business_queries.sql – Write analytical queries

The scripts are designed to be executed in order.

Architecture

I used a layered approach:

1. Raw Layer

Loads the original CSV data into raw tables.

2. Clean Layer

Removes duplicates, handles null values, and creates structured relational tables.

3. Data Warehouse Layer

Implements a star schema with:

Fact Tables

fact_orders – one row per order

fact_order_items – one row per order item (links orders to products and sellers)

Dimension Tables

dim_customers

dim_products

dim_sellers

dim_date

This design allows analyses such as revenue by month, revenue by state, and average order value.

Data Quality Checks

Some of the validations implemented:

Checking for null values in critical columns

Detecting duplicate records

Validating foreign key relationships

Comparing order totals with payment totals

Checking delivery dates for logical consistency

Example Queries

Total Revenue

SELECT SUM(order_total) AS total_revenue
FROM fact_orders;

Monthly Revenue

SELECT d.year, d.month, SUM(f.order_total) AS revenue
FROM fact_orders f
JOIN dim_date d ON f.order_date = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

Top 5 States by Revenue

SELECT c.customer_state, SUM(f.order_total) AS revenue
FROM fact_orders f
JOIN dim_customers c ON f.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 5;

Average Order Value

SELECT AVG(order_total) AS avg_order_value
FROM fact_orders;
Tools Used

MySQL 8.0

MySQL Workbench

VS Code

Git & GitHub

What I Learned

Through this project, I learned:

The difference between raw, clean, and warehouse layers

How fact tables and dimension tables work

The importance of defining the correct data grain

How to use foreign key constraints

How to validate financial data using SQL

How to structure a SQL project in a clear, organized way

Future Improvements

Add indexing for performance

Automate the ETL process

Connect the warehouse to a BI tool

Deploy the database to the cloud

Explore handling multi-product orders in fact tables more efficiently

Author

This project was built as part of my learning journey into Data Engineering.
