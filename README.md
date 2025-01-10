# Bike Sales Analysis SQL Project
## Project Overview

**Project Title**: Bike Sales Analysis 
**Database**: `bike_sales`

This dataset contains detailed sales data for bike-related products across multiple regions. It includes information on sales by date, customer demographics, and product details, allowing for in-depth analysis of sales trends, customer behavior, and product performance.

## Objectives

1. **Set up a Bike sales database**: Create and populate a bike sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Dataset Description
- **Number of Columns:** 18
- **Number of Rows:** 113036
- **Columns Description**
    1. **Date**: The date of the transaction (format: DD-MM-YY).
    2. **Day**: The day of the transaction.
    3.**Month**: The month of the transaction.
    4. **Year**: The year of the transaction.
    5. **Customer_Age**: Age of the customer.
    6. **Age_Group**: Age group category of the customer.
    7. **Customer_Gender**: Gender of the customer (M for Male, F for Female).
    8. **Country**: The country where the transaction occurred.
    9. **State**: The state where the transaction occurred.
    10. **Product_Category**: Broad category of the product.
    11. **Sub_Category**: Specific sub-category of the product.
    12. **Product**: Name of the product sold.
    13. **Order_Quantity**: Number of units sold.
    14. **Unit_Cost**: Cost per unit of the product.
    15. **Unit_Price**: Selling price per unit of the product.
    16. **Profit**: Profit generated from the sale (calculated as Revenue - Cost).
    17. **Cost**: Total cost for the order (calculated as Order_Quantity * Unit_Cost).
    18. **Revenue**: Total revenue generated (calculated as Order_Quantity * Unit_Price).
      
### 2. Database Setup

- **Database Creation**: The project starts by creating a database named `bike_sales`.
- **Table Creation**: A table named `bike_sales` is created to store the sales data. The table structure includes columns describing the sales data of bikes in various regions.

    ```sql
    -- Create Database
    CREATE DATABASE bike_sales;
    
    -- Use Database
    USE bike_sales;
    
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
    ```
- After creating the table import the dataset directly into the SQL using import wizard.

### 2. Data Exploration & Cleaning

- To view all the record from the table and understand the columns and their attributes.
  
    ```sql
    -- To view all the records inserted
    select * from bike_sales
    
    -- To verify the data types of the dataset
    DESCRIBE bike_sales;
    ```
    
- Data Cleaning
  1. Handling Missing Values

     ```sql
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
        ```
     
  2. Removing Unnecessary Whitespace

     ```sql
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
     ```

- Data Exploration
    1. Summary Statistics: Generate key metrics such as total sales, profit, and revenue across various dimensions

       ```sql
        SELECT year, country, product_category, 
        SUM(order_quantity) AS total_sales, 
        SUM(profit) AS total_profit, 
        SUM(revenue) AS total_revenue
        FROM bike_sales
        GROUP BY year, country, product_category
        order by year;
        ```
       
    2. Yearly Trends: Analyze the yearly distribution of revenue and profit

       ```sql
       SELECT year, SUM(revenue) AS total_revenue, SUM(profit) AS total_profit
        FROM bike_sales
        GROUP BY year
        ORDER BY total_revenue DESC;
        ```
       
    3. Demographic Analysis: Examine sales by age group and customer gender

       ```sql
        SELECT age_group, customer_gender, 
        SUM(order_quantity) AS total_sales, 
        SUM(profit) AS total_profit, 
        SUM(revenue) AS total_revenue
        FROM bike_sales
        GROUP BY age_group, customer_gender
        order by total_revenue desc;
       ```
    4. Geographic Analysis: Explore sales performance by country and state 

       ```sql
        SELECT country, state, 
        SUM(order_quantity) AS total_sales, 
        SUM(profit) AS total_profit, 
        SUM(revenue) AS total_revenue
        FROM bike_sales
        GROUP BY country, state
        ORDER BY total_sales DESC;
       ```
       
    5. Product Performance: Analyze sales at the product category and sub-category levels

       ```sql
        SELECT product_category, sub_category, 
        SUM(order_quantity) AS total_sales, 
        SUM(profit) AS total_profit, 
        SUM(revenue) AS total_revenue
        FROM bike_sales
        GROUP BY product_category, sub_category
        ORDER BY total_sales DESC;
       ```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. Create a summary table for total sales, profit, and revenue by year, country, and product category

   ```sql
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
   ```

2. Slice: Extract sales data for the year 2015
   ```sql
    CREATE TABLE bike_sales_2015_1 AS
    SELECT * FROM bike_sales WHERE year = 2015
    order by date;
   ```

3. Dice: Break down sales data by age group and customer gender for Canada
    ```sql
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
    ```

4. Roll-up: Aggregate data from month to year level for total revenue
   ```sql
    CREATE TABLE bike_sales_yearly_revenue_1 AS
    SELECT 
        year,
        SUM(revenue) AS total_revenue
    FROM 
        bike_sales
    GROUP BY 
        year
    order by total_revenue desc;
   ```

5. Drill-down: Analyze total sales by product sub-category within the 'Accessories' category
   ```sql
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
   ```

6. Dice: Filter for 'Adults (35-64)' age group and Male customers
   ```sql
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
   ```

7. Drill-down: Analyze sales by Product and State
   ```sql
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
   ```

8. Slice: Extract sales data for customers aged 'Youth (<25)'
   ```sql
    CREATE TABLE bike_sales_youth_1 AS
    SELECT * 
    FROM bike_sales 
    WHERE age_group = 'Youth (<25)'
    ORDER BY date;
   ```

9. Roll up by year to analyze revenue and profit
    ```sql
    CREATE TABLE bike_sales_year_income_1 AS
    select year,count(id) as total_sales, 
    avg(revenue) as 'Avg Revenue',sum(revenue) as 'Total Revenue', 
    avg(profit) as 'Avg Profit',sum(profit) as 'total profit'
    from bike_sales
    group by year
    ORDER BY year;
    ```

10. Roll up by product category to analyze revenue and profit
    ```sql
    CREATE TABLE bike_sales_pc_revenue_1 AS
    select product_category,count(id) as total_sales, 
    avg(revenue) as 'Avg Revenue',sum(revenue) as 'Total Revenue', 
    avg(profit) as 'Avg Profit',sum(profit) as total_profit
    from bike_sales
    group by product_category
    ORDER BY total_profit desc;
    ```

### 4. Use Cases
This dataset can be used for:

Sales Trend Analysis: Identifying patterns over time based on sales data.
Customer Demographics Insights: Understanding customer behavior by age, gender, and region.
Profitability Analysis: Evaluating the cost, revenue, and profit margins of products.
     
### 5. Findings
#### Data Quality Insights

Several rows contained NULL values across critical columns such as date, customer_age, and revenue. These rows were identified and removed to ensure data completeness.
Leading and trailing whitespace was found in text fields such as product_category and country. These were cleaned to maintain consistency and avoid duplication in grouping operations.

#### Yearly Trends

The analysis revealed significant growth in revenue and profit over the years, with certain years performing exceptionally well.
Years with lower revenue often corresponded to reduced sales volumes, highlighting the correlation between order quantity and overall revenue generation.

#### Geographic Performance

Top-performing Countries: The highest revenue was observed in countries with larger customer bases and economic activity, such as Canada and the USA.
State-wise Analysis: Certain states outperformed others in terms of both sales volume and revenue, often driven by high demand for specific product categories.

#### Demographic Trends

The age group "Adults (35-64)" contributed the most to total sales and revenue, followed by "Youth (<25)".
Male customers exhibited higher purchase volumes compared to female customers, particularly in regions like Canada and the USA.

#### Product Performance

The "Accessories" category recorded the highest sales, with sub-categories such as "Helmets" and "Lights" being the most popular.
Premium products like bikes showed consistent profitability despite having lower sales volumes compared to accessories.

#### Profitability

Products with higher unit costs but premium pricing, such as high-end bikes, had the best profit margins.
Accessories contributed significantly to overall revenue but had lower profit margins compared to other categories.

### Conclusion
The data cleaning and exploration process of the bike_sales table provided valuable insights into sales performance, customer demographics, and product trends. Key takeaways include:

Data Readiness: After cleaning, the dataset was free of inconsistencies, enabling accurate analysis and decision-making.
Year-over-Year Growth: Positive revenue and profit trends indicate strong business growth, likely driven by effective marketing and product diversification.
Target Market Insights:
The "Adults (35-64)" age group should remain the primary target audience for marketing campaigns.
Regional marketing strategies should focus on high-performing states and countries.
Product Strategy:
Continued investment in high-margin products like premium bikes is recommended.
Efforts to improve the profitability of accessories, through either cost reduction or premium pricing, could significantly boost overall profits.
Future Actions:
Expand marketing efforts in top-performing regions while exploring opportunities in underperforming areas.
Introduce new products tailored to the preferences of high-contributing demographic segments.
By leveraging these findings, the company can make data-driven decisions to enhance operational efficiency, optimize sales strategies, and maximize profitability.

