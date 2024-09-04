--Let's explore and analyze this data to gain insights into customer purchase behavior.

--Let's start by understanding the overall sales data.
SELECT
  SUM(SALES) AS total_sales,
  COUNT(ORDERNUMBER) AS total_orders,
  COUNT(DISTINCT CUSTOMERNAME) AS unique_customers
FROM
  sales_data_sample;
  
--We can also look at the distribution of orders by year and quarter.
 SELECT
  YEAR_ID,
  QTR_ID,
  COUNT(ORDERNUMBER) AS orders_count
FROM
  sales_data_sample
GROUP BY
  YEAR_ID, QTR_ID
ORDER BY
  YEAR_ID, QTR_ID;
  
 --Understanding the best-selling product line.
 SELECT
  PRODUCTLINE,
  SUM(SALES) AS total_sales
FROM
  sales_data_sample
GROUP BY
  PRODUCTLINE
ORDER BY
  total_sales DESC
LIMIT 1;

--The top customers by total sales.
SELECT
  CUSTOMERNAME,
  SUM(SALES) AS total_sales
FROM
  sales_data_sample
GROUP BY
  CUSTOMERNAME
ORDER BY
  total_sales DESC
LIMIT 10;

--Analyze the data to gain deeper insights.

--Identifying the best-selling products within the top-selling product line.
  WITH TopProductLine AS (
    SELECT
        PRODUCTLINE
    FROM
        sales_data_sample
    GROUP BY
        PRODUCTLINE
    ORDER BY
        SUM(SALES) DESC
    LIMIT 1
)

SELECT
    sd.PRODUCTLINE,
    sd.PRODUCTCODE,
    SUM(sd.SALES) AS total_sales
FROM
    sales_data_sample sd
JOIN
    TopProductLine tpl ON sd.PRODUCTLINE = tpl.PRODUCTLINE
GROUP BY
    sd.PRODUCTLINE, sd.PRODUCTCODE
ORDER BY
    total_sales DESC;

--Analyzing the relationship between order size (DEALSIZE) and sales.
SELECT
  DEALSIZE,
  ROUND(AVG(SALES),2) AS avg_sales,
  SUM(SALES) AS total_sales
FROM
  sales_data_sample
GROUP BY
  DEALSIZE
ORDER BY
  total_sales DESC;
  
--Investigating the impact of customer location (country, territory) on sales.
SELECT
  COUNTRY,
  TERRITORY,
  SUM(SALES) AS total_sales
FROM
  sales_data_sample
GROUP BY
  COUNTRY, TERRITORY
ORDER BY
  total_sales DESC;
  
--Examining the correlation between order date and sales to identify seasonal trends.
SELECT
  YEAR_ID,
  MONTH_ID,
  SUM(SALES) AS total_sales
FROM
  sales_data_sample
GROUP BY
  YEAR_ID, MONTH_ID
ORDER BY
  YEAR_ID, MONTH_ID;
  
--Performing segmentation analysis to group customers with similar purchase behavior.
SELECT
  CUSTOMERNAME,
  SUM(SALES) AS total_sales,
  COUNT(ORDERNUMBER) AS num_orders,
  AVG(QUANTITYORDERED) AS avg_quantity,
  DEALSIZE
FROM
  sales_data_sample
GROUP BY
  CUSTOMERNAME
ORDER BY
  total_sales DESC;

-- We now ready to answer the business questions toghter :) 

--1. Identify the total number of invoices, unique customers, and product categories.
SELECT 
    COUNT(DISTINCT ORDERNUMBER) AS total_invoices,
    COUNT(DISTINCT CUSTOMERNAME) AS unique_customers,
    COUNT(DISTINCT PRODUCTLINE) AS product_categories
FROM sales_data_sample;
--total_invoices = 307 , unique_customers = 92 , product categories = 7

--2. Calculate basic summary statistics for key metrics like total sales amount,
--average order value, and most frequently purchased items.
SELECT 
    SUM(SALES) AS total_sales_amount ,
    ROUND(AVG(SALES), 2)AS average_order_value ,
    COUNT(PRODUCTCODE) AS purchase_count
FROM sales_data_sample
GROUP BY PRODUCTCODE
ORDER BY purchase_count DESC
LIMIT 5;

--3. Explore purchase patterns by country or any other relevant demographic information.
SELECT 
    COUNTRY,
    COUNT(ORDERNUMBER) AS total_orders,
    SUM(SALES) AS total_sales
FROM sales_data_sample
GROUP BY COUNTRY 
ORDER BY total_sales DESC;
  




