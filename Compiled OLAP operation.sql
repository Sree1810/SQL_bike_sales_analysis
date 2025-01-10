-- ============================================================================

-- Create Database
CREATE DATABASE bike_sales;

-- Use Database
USE bike_sales;

-- ============================================================================

-- Create Table for the Dataset
CREATE TABLE bike_sales (
    Date DATE,
    Day INT,
    Month VARCHAR(20),
    Year INT,
    Customer_Age INT,
    Age_Group VARCHAR(50),
    Customer_Gender CHAR(1),
    Country VARCHAR(50),
    State VARCHAR(50),
    Product_Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product VARCHAR(100),
    Order_Quantity INT,
    Unit_Cost DECIMAL(10, 2),
    Unit_Price DECIMAL(10, 2),
    Profit DECIMAL(10, 2),
    Cost DECIMAL(10, 2),
    Revenue DECIMAL(10, 2)
);

-- Import the CSV file to insert the data into the table.
-- ============================================================================

-- To See NULL values in the dataset 
select * from bike_sales
where id IS NULL or date IS NULL or day IS NULL or month IS NULL 
or year IS NULL or customer_age IS NULL or age_group IS NULL
or customer_gender IS NULL or country IS NULL or state IS NULL
or product_category IS NULL or sub_category IS NULL or product IS NULL
or order_quantity IS NULL or unit_cost IS NULL or unit_price IS NULL
or profit IS NULL or cost IS NULL or revenue IS NULL;
-- ============================================================================

-- To delete NULL values in the dataset 
DELETE FROM bike_sales
where id IS NULL or date IS NULL or day IS NULL 
or month IS NULL or year IS NULL or customer_age IS NULL
or age_group IS NULL or customer_gender IS NULL
or country IS NULL or state IS NULL or product_category IS NULL
or sub_category IS NULL or product IS NULL or order_quantity IS NULL
or unit_cost IS NULL or unit_price IS NULL or profit IS NULL
or cost IS NULL or revenue IS NULL;

-- ============================================================================

-- To verify the data types of the dataset
DESCRIBE bike_sales;

-- ============================================================================

-- check whitespaces in the column

SELECT * FROM bike_sales
WHERE product_category LIKE ' %' OR product_category LIKE '% ' OR
age_group LIKE ' %' OR age_group LIKE '% ' OR
country LIKE ' %' OR country LIKE '% ' OR
state LIKE ' %' OR state LIKE '% ' OR
sub_category LIKE ' %' OR sub_category LIKE '% ' OR
product LIKE ' %' OR product LIKE '% ';

-- ============================================================================

-- remove the white spaces
UPDATE bike_sales
SET product_category = TRIM(product_category);

-- ============================================================================


-- 1. Create a summary table for total sales, profit, and revenue by year, country, and product category
-- CREATE TABLE bike_sales_summary_1 AS
SELECT 
    year,
    country,
    product_category,
    SUM(order_quantity) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(revenue) AS total_revenue
FROM 
    bike_sales
GROUP BY 
    year, country, product_category
order by year;
-- ============================================================================


-- 2. Slice: Extract sales data for the year 2015
CREATE TABLE bike_sales_2015_1 AS
SELECT * FROM bike_sales WHERE year = 2015
order by date;

-- ============================================================================


-- 3. Dice: Break down sales data by age group and customer gender for Canada
CREATE TABLE bike_sales_canada_dice_1 AS
SELECT 
    age_group,
    customer_gender,
    SUM(order_quantity) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(revenue) AS total_revenue
FROM 
    bike_sales
WHERE 
    country = 'Canada'
GROUP BY 
    age_group, customer_gender
order by total_sales desc, age_group;

-- ============================================================================

-- 4. Roll-up: Aggregate data from month to year level for total revenue
CREATE TABLE bike_sales_yearly_revenue_1 AS
SELECT 
    year,
    SUM(revenue) AS total_revenue
FROM 
    bike_sales
GROUP BY 
    year
order by total_revenue desc;

-- ============================================================================

/* 5. Drill-down: Analyze total sales by product sub-category 
within the 'Accessories' category */
CREATE TABLE bike_sales_accessories_drilldown_1 AS
SELECT 
    sub_category,
    SUM(order_quantity) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(revenue) AS total_revenue
FROM 
    bike_sales
WHERE 
    product_category = 'Accessories'
GROUP BY 
    sub_category
order by total_sales desc, total_profit desc, total_revenue desc;

-- ============================================================================
/*
-- 
CREATE TABLE bike_sales_quarterly_country_1 AS
SELECT 
    YEAR(MIN(date)) AS year,
    country,
    SUM(order_quantity) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(revenue) AS total_revenue
FROM 
    bike_sales.bike_sales
GROUP BY 
    year, country
ORDER BY 
    year,  country;
*/
-- ============================================================================

-- 6. Dice: Filter for 'Adults (35-64)' age group and Male customers
CREATE TABLE bike_sales_adult_males_1 AS
SELECT 
    country,
    state,
    SUM(order_quantity) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(revenue) AS total_revenue
FROM 
    bike_sales
WHERE 
    age_group = 'Adults (35-64)' AND customer_gender = 'M'
GROUP BY 
    country, state
ORDER BY total_sales DESC;

-- ============================================================================

-- 7. Drill-down: Analyze sales by Product and State
CREATE TABLE bike_sales_category_country_1 AS
SELECT 
    product_category,
    country,
    SUM(order_quantity) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(revenue) AS total_revenue
FROM 
    bike_sales
GROUP BY 
    product_category, country
ORDER BY 
    total_sales DESC, total_profit DESC, total_revenue DESC;

-- ============================================================================

-- 8. Slice: Extract sales data for customers aged 'Youth (<25)'
CREATE TABLE bike_sales_youth_1 AS
SELECT * 
FROM bike_sales 
WHERE age_group = 'Youth (<25)'
ORDER BY date;

-- ============================================================================

-- 9. roll up by year to analyze revenue and profit
CREATE TABLE bike_sales_year_income_1 AS
select year,count(id) as total_sales, 
avg(revenue) as 'Avg Revenue',sum(revenue) as 'Total Revenue', 
avg(profit) as 'Avg Profit',sum(profit) as 'total profit'
from bike_sales
group by year
ORDER BY year;

-- ============================================================================

-- 10. roll up by product category to analyze revenue and profit
CREATE TABLE bike_sales_pc_revenue_1 AS
select product_category,count(id) as total_sales, 
avg(revenue) as 'Avg Revenue',sum(revenue) as 'Total Revenue', 
avg(profit) as 'Avg Profit',sum(profit) as total_profit
from bike_sales
group by product_category
ORDER BY total_profit desc;

-- ============================================================================
