/*
=========================================================
Retail Sales SQL Project
Phase 1 : Database Setup

Description:
This script creates the retail database,
creates all dimension and fact tables,
imports CSV files,
and defines primary & foreign key constraints.
=========================================================
*/

-- Step 1: Create the Retail Database

create database retail;

-- Select the Retail Database

use retail;

-- Create Customer Dimension Table

create table dim_customer
(customer_key int,
first_name varchar(50),
last_name varchar(50),
gender    varchar(50),
city    varchar(50),
state    varchar(50),
email    varchar(50),
phone varchar(50)
);

select * from dim_customer;

-- =====================================================
-- Enable Local File Import
-- Required to import CSV files using LOAD DATA LOCAL INFILE.
-- =====================================================

show global variables;
set global local_infile= 1;

-- Import Customer Data from CSV
-- Update the file path below according to your system.

load data local infile "C:/path/to/dim_customer.csv"
into table dim_customer
fields terminated by ","
enclosed by '"'
lines terminated by "\n"
ignore 1 lines;

select * from dim_customer;

-- Create Employee Dimension Table

create table dim_employee(
employee_key int,
employee_name varchar(50),
designation varchar(50),
store_key int);

-- Import Employee Data from CSV
-- Update the file path below according to your system.

load data local infile "C:/path/to/dim_employee.csv"
into table dim_employee
fields terminated by ","
enclosed by '"'
lines terminated by "\n"
ignore 1 lines;

select * from dim_employee;

-- Create Product Dimension Table

create table dim_product
(product_key int,
product_name varchar(70),
brand varchar(50),
category varchar(50),
price decimal(10,2));

-- Import Product Data from CSV
-- Update the file path below according to your system.

load data local infile "C:/path/to/dim_product.csv"
into table dim_product
fields terminated by ","
enclosed by '"'
lines terminated by "\n"
ignore 1 lines;

select * from dim_product;

-- Create Store Dimension Table

create table dim_store
(store_key int,
store_name varchar (70),
city varchar (50),
state varchar(50));

-- Import Store Data from CSV
-- Update the file path below according to your system.

load data local infile "C:/path/to/dim_store.csv"
into table dim_store
fields terminated by ","
enclosed by '"'
lines terminated by "\n"
ignore 1 lines;

select * from dim_store;

-- Create Date Dimension Table

create table dim_date
(date_key int,
full_date date);

-- Import Date Data from CSV
-- Update the file path below according to your system.

load data local infile "C:/path/to/dim_date.csv"
into table dim_date
fields terminated by ","
enclosed by '"'
lines terminated by "\n"
ignore 1 lines;

select * from dim_date;

-- Create Sales Fact Table

create table fact_sales
(sale_id int,
date_key int,
customer_key int,
product_key int,
store_key int,
employee_key int,
quantity int,
sales decimal(10,2));

-- Import Sales Data from CSV
-- Update the file path below according to your system.

load data local infile "C:/path/to/fact_sales.csv"
into table fact_sales
fields terminated by ","
enclosed by '"'
lines terminated by "\n"
ignore 1 lines;

select * from fact_sales;
