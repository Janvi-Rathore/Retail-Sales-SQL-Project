# Retail Sales Database Data Dictionary

## Database Overview

The Retail Sales Database is designed using a star schema consisting of one fact table and five dimension tables. The fact table stores sales transactions, while the dimension tables contain descriptive information about customers, products, stores, employees, and dates. This structure supports efficient querying, reporting, and business analysis.

---

# Database Schema

| Table Name | Description |
|------------|-------------|
| dim_customer | Stores customer information. |
| dim_product | Stores product details. |
| dim_store | Stores store information. |
| dim_employee | Stores employee details. |
| dim_date | Stores calendar date information. |
| fact_sales | Stores sales transaction records. |

---

# Table Details

## dim_customer

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| customer_key | INT | Unique identifier for each customer. |
| first_name | VARCHAR(50) | Customer's first name. |
| last_name | VARCHAR(50) | Customer's last name. |
| gender | VARCHAR(50) | Customer gender. |
| city | VARCHAR(50) | Customer city. |
| state | VARCHAR(50) | Customer state. |
| email | VARCHAR(50) | Customer email address. |
| phone | VARCHAR(50) | Customer contact number. |

---

## dim_product

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| product_key | INT | Unique identifier for each product. |
| product_name | VARCHAR(70) | Name of the product. |
| brand | VARCHAR(50) | Product brand. |
| category | VARCHAR(50) | Product category. |
| price | DECIMAL(10,2) | Selling price of the product. |

---

## dim_store

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| store_key | INT | Unique identifier for each store. |
| store_name | VARCHAR(70) | Name of the store. |
| city | VARCHAR(50) | Store city. |
| state | VARCHAR(50) | Store state. |

---

## dim_employee

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| employee_key | INT | Unique identifier for each employee. |
| employee_name | VARCHAR(50) | Employee name. |
| designation | VARCHAR(50) | Employee job designation. |
| store_key | INT | References the store where the employee works. |

---

## dim_date

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| date_key | INT | Unique identifier for each date. |
| full_date | DATE | Calendar date. |

---

## fact_sales

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| sale_id | INT | Unique identifier for each sales transaction. |
| date_key | INT | References the transaction date. |
| customer_key | INT | References the customer who made the purchase. |
| product_key | INT | References the product sold. |
| store_key | INT | References the store where the sale occurred. |
| employee_key | INT | References the employee who handled the sale. |
| quantity | INT | Number of product units sold. |
| sales | DECIMAL(10,2) | Total sales amount of the transaction. |

---

# Table Relationships

| Parent Table | Child Table | Foreign Key |
|--------------|-------------|-------------|
| dim_customer | fact_sales | customer_key |
| dim_product | fact_sales | product_key |
| dim_store | fact_sales | store_key |
| dim_employee | fact_sales | employee_key |
| dim_date | fact_sales | date_key |
| dim_store | dim_employee | store_key |

---

# Notes

- The database follows a star schema data model.
- Each dimension table contains descriptive information related to a specific business entity.
- The `fact_sales` table stores transactional sales data and connects all dimension tables through foreign keys.
- Primary keys uniquely identify each record in their respective tables.
- Foreign keys maintain referential integrity between related tables.
- The database is optimized for retail sales analysis, reporting, and business intelligence.