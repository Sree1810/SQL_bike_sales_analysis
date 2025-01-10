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
- **Number of Rows:** 7
- **Number of Columns:** 113036
- **Columns Description**
    **Date**: The date of the transaction (format: DD-MM-YY).
    **Day**: The day of the transaction.
    **Month**: The month of the transaction.
    **Year**: The year of the transaction.
    **Customer_Age**: Age of the customer.
    **Age_Group**: Age group category of the customer.
    **Customer_Gender**: Gender of the customer (M for Male, F for Female).
    **Country**: The country where the transaction occurred.
    **State**: The state where the transaction occurred.
    **Product_Category**: Broad category of the product.
    **Sub_Category**: Specific sub-category of the product.
    **Product**: Name of the product sold.
    **Order_Quantity**: Number of units sold.
    **Unit_Cost**: Cost per unit of the product.
    **Unit_Price**: Selling price per unit of the product.
    **Profit**: Profit generated from the sale (calculated as Revenue - Cost).
    **Cost**: Total cost for the order (calculated as Order_Quantity * Unit_Cost).
    **Revenue**: Total revenue generated (calculated as Order_Quantity * Unit_Price).
      
### 2. Database Setup

- **Database Creation**: The project starts by creating a database named `bike_sales`.
- **Table Creation**: A table named `bike_sales` is created to store the sales data. The table structure includes columns describing the sales data of bikes in various regions.
- 
