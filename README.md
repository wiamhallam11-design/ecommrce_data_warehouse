# E-Commerce Data Warehouse Project (MySQL)

## Project Overview

This project builds a complete Data Warehouse using MySQL based on the Brazilian Olist E-Commerce dataset.

The goal of this project is to simulate a real-world Data Engineering workflow including:

- Raw data ingestion
- Data validation & quality checks
- Data cleaning & transformation
- Star schema modeling
- Analytical querying

This project demonstrates foundational Data Engineering concepts using SQL.

---

## Dataset

This project uses the **Brazilian Olist E-Commerce dataset** from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).  
The dataset contains raw information about customers, orders, products, and payments.


---

## Architecture

The project follows a layered architecture:

1️ **Raw Layer**  
Stores original data loaded directly from CSV files.

2️ **Staging / Clean Layer**  
Removes duplicates, handles nulls, enforces constraints.

3️ **Data Warehouse Layer**  
Implements a Star Schema with:

- Fact table: `fact_orders`
- Dimension tables:
  - `dim_customers`
  - `dim_products`
  - `dim_sellers`
  - `dim_date`

---

## Database Schema

### Fact Table

`fact_orders`

- order_id
- customer_id
- order_date
- order_status
- total_items_amount
- total_freight
- order_total
- total_payment

### Dimension Tables

- dim_customers
- dim_products
- dim_sellers
- dim_date

---

## Data Quality Checks Implemented

✔ Null value detection  
✔ Duplicate detection  
✔ Referential integrity validation  
✔ Business logic validation (delivery date checks)  
✔ Financial reconciliation (order_total vs payment_total)

---

## Getting Started

### Prerequisites
- Install **Git**  
- Install a **SQL database** (MySQL, PostgreSQL, or similar)  
- Optional: VS Code with SQL extensions  

### Steps to Run
1. Clone this repository:

```bash
git clone https://github.com/wiamhallam11-design/ecommrce_data_warehouse.git

Open your SQL client or VS Code terminal.

Run the SQL scripts in order:

create_tables.sql – creates the schema and tables

load_data.sql – loads the sample dataset

queries.sql – example analytics queries

Inspect the results in your database.

Example Business Queries

Total revenue

SELECT SUM(order_total) AS total_revenue
FROM fact_orders;

Monthly revenue trend

SELECT MONTH(order_date) AS month, SUM(order_total) AS monthly_revenue
FROM fact_orders
GROUP BY month
ORDER BY month;

Revenue by customer state

Average order value

Tools Used

MySQL 8.0

MySQL Workbench

VS Code

Git & GitHub

Key Learnings

Data modeling (Star Schema)

Fact vs Dimension design

Aggregation logic

Foreign key constraints

Data cleaning techniques

Financial consistency validation

Real-world ETL simulation

Future Improvements

Add indexing for performance

Implement stored procedures

Automate ETL workflow

Connect to BI tool (Power BI / Tableau)

Deploy to cloud database

Author

Built as a personal Data Engineering learning project.