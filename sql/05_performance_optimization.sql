/*
=========================================================
Retail Sales SQL Project
Phase 5 : Performance Optimization

Description:
This script improves SQL query performance by
creating indexes on frequently used columns and
analyzing query execution plans using EXPLAIN.
=========================================================
*/

use retail;

-- NOTE: Indexes are created on foreign key columns that are frequently used in JOIN conditions and filtering operations to improve query performance.

-- =====================================================
-- Index Creation
-- Create indexes on frequently used foreign key columns
-- to improve query filtering and JOIN performance.
-- =====================================================

-- Create Index on customer_key

create index idx_fact_customer
on fact_sales(customer_key);


-- Create Index on product_key

create index idx_fact_product
on fact_sales(product_key);


-- Create Index on store_key

create index idx_fact_store
on fact_sales(store_key);


-- Create Index on employee_key

create index idx_fact_employee
on fact_sales(employee_key);


-- Create Index on date_key

create index idx_fact_date
on fact_sales(date_key);

-- Verify That All Indexes Have Been Created Successfully

show indexes from fact_sales; 


-- =====================================================
-- Execution Plan Analysis
-- Analyze query execution plans using EXPLAIN
-- to evaluate index utilization and query performance.
-- =====================================================

-- Execution Plan 1:
-- Analyze Query Performance for Customer Sales.

explain
select
    customer_key,
    sum(sales) as total_sales
from fact_sales
where customer_key = 100
group by customer_key;


-- Execution Plan 2:
-- Analyze Customer Sales Summary Query.

explain
select
    c.customer_key,
    concat(c.first_name,' ',c.last_name) as customer_name,
    sum(f.sales) as total_sales
from fact_sales f
join dim_customer c
on f.customer_key = c.customer_key
group by
    c.customer_key,
    customer_name;
  
  
-- Execution Plan 3:
-- Analyze Product Sales Summary Query.

explain
select
    p.product_key,
    p.product_name,
    sum(f.sales) as total_sales
from fact_sales f
join dim_product p
on f.product_key = p.product_key
group by
    p.product_key,
    p.product_name;
    
    
-- Execution Plan 4:
-- Analyze Store Sales Summary Query.    
    
explain
select
    s.store_key,
    s.store_name,
    sum(f.sales) as total_sales
from fact_sales f
join dim_store s
on f.store_key = s.store_key
group by
    s.store_key,
    s.store_name;


-- Execution Plan 5:
-- Analyze Monthly Sales Aggregation Query.    
    
explain
select
    year(d.full_date) as year,
    month(d.full_date) as month,
    sum(f.sales) as total_sales
from fact_sales f
join dim_date d
on f.date_key = d.date_key
group by
    year(d.full_date),
    month(d.full_date);
    
    
-- =====================================================
-- Performance Optimization Observations
-- =====================================================

-- Indexes improve query performance by reducing unnecessary full table scans.
-- EXPLAIN was used to analyze query execution plans and verify effective index utilization.
-- Indexing foreign key columns significantly improves JOIN operations and filtering performance.

