/*
=========================================================
Retail Sales SQL Project
Phase 2 : Data Cleaning

Description:
This script performs data cleaning by
removing inconsistencies,
checking NULL values,
trimming spaces,
identifying duplicates,
and validating the dataset.
=========================================================
*/

use retail;

show tables;

select count(*) from dim_customer;
select count(*) from dim_employee;
select count(*) from dim_product;
select count(*) from dim_store;
select count(*) from dim_date;
select count(*) from fact_sales;

-- Step 1: Remove Leading and Trailing Spaces
update dim_customer
set
    first_name = trim(first_name),
    last_name = trim(last_name),
    email = trim(email),
    city = trim(city),
    state = trim(state);
    
update dim_employee
set
    employee_name = trim(employee_name),
    designation = trim(designation);
    
update dim_product
set
    product_name = trim(product_name),
    brand = trim(brand),
    category = trim(category);
    
update dim_store
set
    store_name = trim(store_name),
    city = trim(city),
    state = trim(state);
    
-- Step 2: Check and Standardize Text Values
-- Verify consistency in text fields such as gender, city, state, brand, and category.

select distinct gender
from dim_customer
order by gender;
-- Result: Gender values are already standardized (Male/Female).

select
    upper(city) as standardized_city,
    count(distinct city) as variations
from dim_customer
group by upper(city)
having count(distinct city) > 1;
-- Result: No inconsistent city names found. No standardization required.

select
    upper(state) as standardize_state,
    count(distinct state) as variation
from dim_customer
group by upper(state)
having count(distinct state) > 1;   
-- Result: No inconsistent state found. No standardization required.

select
    upper(brand) as standardized_brand,
    count(distinct brand) as variation
from dim_product
group by upper(brand)
having count(distinct brand) > 1;
-- Result: No inconsistent brand found. No standardization required.

select
    upper(category) as standardized_category,
    count(distinct category) as variation1
from dim_product
group by upper(category)
having count(distinct category) > 1;
-- Result: No inconsistent category found. No standardization required. 

select
    upper(city) as standardized_city,
    count(distinct city) as variations
from dim_store
group by upper(city)
having count(distinct city) > 1;
-- Result: No inconsistent city names found. No standardization required. 
    
select
    upper(state) as standardize_state,
    count(distinct state) as variation
from dim_store
group by upper(state)
having count(distinct state) > 1;  
-- Result: No inconsistent state found. No standardization required. 
   
-- Step 3: Checking NULL Values

select
    sum(customer_key IS NULL) as customer_key_nulls,
    sum(first_name IS NULL) as first_name_nulls,
    sum(last_name IS NULL) as last_name_nulls,
    sum(gender IS NULL) as gender_nulls,
    sum(city IS NULL) as city_nulls,
    sum(state IS NULL) as state_nulls,
	sum(email IS NULL) as email_nulls,
    sum(phone IS NULL) as phone_nulls 
from dim_customer; 
 -- Result: No NULL Value found 
 
    
select
    sum(date_key IS NULL) as date_key_nulls,
    sum(full_date IS NULL) as full_date_nulls
from dim_date; 
 -- Result: No NULL Value found
 
    
select
    sum(employee_key IS NULL) as employee_key_nulls,
    sum(employee_name IS NULL) as employee_name_nulls,
    sum(designation IS NULL) as designation_nulls,
    sum(store_key IS NULL) as store_key_nulls
from dim_employee;
-- Result: No NULL Value found


select
    sum(product_key IS NULL) as product_key_nulls,
    sum(product_name IS NULL) as product_name_nulls,
    sum(brand IS NULL) as brand_nulls,
    sum(category IS NULL) as category_nulls,
	sum(price IS NULL) as price_nulls
from dim_product; 
-- Result: No NULL Value found


select
    sum(store_key IS NULL) as store_key_nulls,
    sum(store_name IS NULL) as store_name_nulls,
    sum(city IS NULL) as city_nulls,
    sum(state IS NULL) as state_nulls
from dim_store; 
-- Result: No NULL Value found


select
    sum(sale_id IS NULL) as sale_id_nulls,
    sum(date_key IS NULL) as date_key_nulls,
    sum(customer_key IS NULL) as customer_key_nulls,
    sum(product_key IS NULL) as product_key_nulls,
    sum(store_key IS NULL) as store_key_nulls,
    sum(employee_key IS NULL) as employee_key_nulls,
	sum(quantity IS NULL) as quantity_nulls,
    sum(sales IS NULL) as sales_nulls 
from fact_sales; 
-- Result: No NULL Value found


-- Step 4: Check for Duplicate Records 
-- Ensure primary key columns contain unique values.

select customer_key, count(*) as duplicate_count
from dim_customer
group by customer_key
having count(*) > 1;
-- Result: No duplicate records found 
 

select date_key, count(*) as duplicate_count
from dim_date
group by date_key
having count(*) > 1;
-- Result: No duplicate records found


select employee_key, count(*) as duplicate_count
from dim_employee
group by employee_key
having count(*) > 1;
-- Result: No duplicate records found


select product_key, count(*) as duplicate_count
from dim_product
group by product_key
having count(*) > 1;
-- Result: No duplicate records found


select store_key, count(*) as duplicate_count
from dim_store
group by store_key
having count(*) > 1;
-- Result: No duplicate records found


select sale_id, count(*) as duplicate_count
from fact_sales
group by sale_id
having count(*) > 1;
-- Result: No duplicate records found


-- Step 5: Validate email addresses
-- Verify that customer email addresses follow a valid basic format.

select *
from dim_customer
where email not like '%_@_%._%';
-- Result: All email addresses have a valid basic format.  


-- Validate phone numbers 
-- Standardize and validate customer mobile numbers.

select * from dim_customer
where Trim(phone)='';

-- Remove '+91' Country Code from Phone Numbers

update dim_customer
set phone = right(phone,10)
where phone like '+91%';

-- Identify Invalid Phone Numbers

select *
from dim_customer
where length(phone) != 10
   or left(phone,1) not in ('6','7','8','9');
   
-- Replace Invalid Phone Numbers with 'N/A'

update dim_customer
set phone = 'N/A'
where length(phone) != 10
   or left(phone,1) not in ('6','7','8','9');
   
-- Verify Total Number of 'N/A' Phone Numbers

select
    phone,
    count(*) as total
from dim_customer
group by phone
order by total desc;

select * from dim_customer;
   
   
-- Validate Product Prices

select *
from dim_product
where price < 0;
-- Result: No negative product prices found

   
-- Validate Sales Quantity

select *
from fact_sales
where quantity < 0;
-- Result: No negative quantities found
   
   
-- Validate Sales Amount

select *
from fact_sales
where sales < 0;
-- Result: No negative sales values found


-- Step 6: Validate Foreign Key Relationships
-- Ensure that all foreign key values exist in their corresponding dimension tables.

-- Validate customer_key values in fact_sales.

select fs.*
from fact_sales fs
left join dim_customer dc
on fs.customer_key = dc.customer_key
where dc.customer_key is null;
-- Result: No invalid customer_key values found


-- Validate product_key values in fact_sales.

select fs.*
from fact_sales fs
left join dim_product dp
on fs.product_key = dp.product_key
where dp.product_key is null;
-- Result: No invalid product_key values found


-- Validate store_key values in fact_sales.

select fs.*
from fact_sales fs
left join dim_store ds
on fs.store_key = ds.store_key
where ds.store_key is null;
-- Result: No invalid store_key values found


-- Validate employee_key values in fact_sales.

select fs.*
from fact_sales fs
left join dim_employee de
on fs.employee_key = de.employee_key
where de.employee_key is null;
-- Result: No invalid employee_key values found


-- Validate date_key values in fact_sales.

select fs.*
from fact_sales fs
left join dim_date dd
on fs.date_key = dd.date_key
where dd.date_key is null;
-- Result: No invalid date_key values found


-- Validate store_key values in dim_employee.

select de.*
from dim_employee de
left join dim_store ds
on de.store_key = ds.store_key
where ds.store_key is null;
-- Result: No invalid store_key values found


-- =====================================================
-- Create Primary Key Constraints
-- =====================================================

alter table dim_customer
add primary key (customer_key);

alter table dim_employee
add primary key (employee_key);

alter table dim_product
add primary key (product_key);

alter table dim_store
add primary key (store_key);

alter table dim_date
add primary key (date_key);

alter table fact_sales
add primary key (sale_id);


-- =====================================================
-- Create Foreign Key Constraints
-- =====================================================

-- Create Foreign Key: dim_employee → dim_store

alter table dim_employee
add constraint fk_employee_store
foreign key (store_key)
references dim_store(store_key);

-- Create Foreign Key Constraints for fact_sales

alter table fact_sales
add constraint fk_sales_customer
foreign key (customer_key)
references dim_customer(customer_key);

alter table fact_sales
add constraint fk_sales_product
foreign key (product_key)
references dim_product(product_key);

alter table fact_sales
add constraint fk_sales_store
foreign key (store_key)
references dim_store(store_key);

alter table fact_sales
add constraint fk_sales_employee
foreign key (employee_key)
references dim_employee(employee_key);

alter table fact_sales
add constraint fk_sales_date
foreign key (date_key)
references dim_date(date_key);
