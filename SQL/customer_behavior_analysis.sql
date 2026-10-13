CREATE DATABASE customer_shopping_analysis;
USE customer_shopping_analysis;
SELECT DATABASE();
USE customer_shopping_analysis;

CREATE TABLE customer_shopping (
    `Customer ID` INT,
    Age INT,
    Gender VARCHAR(20),
    `Item Purchased` VARCHAR(50),
    Category VARCHAR(50),
    `Purchase Amount (USD)` DECIMAL(10,2),
    Location VARCHAR(50),
    Size VARCHAR(10),
    Color VARCHAR(30),
    Season VARCHAR(20),
    `Review Rating` DECIMAL(3,1),
    `Subscription Status` VARCHAR(10),
    `Shipping Type` VARCHAR(30),
    `Discount Applied` VARCHAR(10),
    `Promo Code Used` VARCHAR(10),
    `Previous Purchases` INT,
    `Payment Method` VARCHAR(30),
    `Frequency of Purchases` VARCHAR(30),
    `Spending Category` VARCHAR(20),
    `Customer Type` VARCHAR(20),
    `Age Group` VARCHAR(20)
);

DESCRIBE customer_shopping;

SELECT COUNT(*) 
FROM customer_shopping;

SELECT *
FROM customer_shopping
LIMIT 10;

-- 1. Total Revenue
SELECT 
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS Total_Revenue
FROM customer_shopping;

-- 2. Average Purchase Amount
SELECT 
    ROUND(AVG(`Purchase Amount (USD)`), 2) AS Average_Purchase
FROM customer_shopping;

-- 3. Total Customers
SELECT 
    COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM customer_shopping;

-- 4. Average Review Rating
SELECT 
    ROUND(AVG(`Review Rating`), 2) AS Average_Rating
FROM customer_shopping;

-- 5. Overall Business KPIs
SELECT
    COUNT(DISTINCT `Customer ID`) AS Total_Customers,
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS Total_Revenue,
    ROUND(AVG(`Purchase Amount (USD)`), 2) AS Average_Purchase,
    ROUND(AVG(`Review Rating`), 2) AS Average_Rating
FROM customer_shopping;

-- 6. Revenue by Category
SELECT
    Category,
    COUNT(*) AS Number_of_Purchases,
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS Total_Revenue,
    ROUND(AVG(`Purchase Amount (USD)`), 2) AS Average_Purchase
FROM customer_shopping
GROUP BY Category
ORDER BY Total_Revenue DESC;

-- 7. Top 10 Products by Number of Purchases
SELECT
    `Item Purchased`,
    COUNT(*) AS Purchase_Count,
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS Total_Revenue
FROM customer_shopping
GROUP BY `Item Purchased`
ORDER BY Purchase_Count DESC
LIMIT 10;

-- 8. Subscription Performance
SELECT
    `Subscription Status`,
    COUNT(*) AS Number_of_Purchases,
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS Total_Revenue,
    ROUND(AVG(`Purchase Amount (USD)`), 2) AS Average_Purchase
FROM customer_shopping
GROUP BY `Subscription Status`
ORDER BY Total_Revenue DESC;

-- 10. Payment Method Analysis
SELECT
    `Payment Method`,
    COUNT(*) AS Number_of_Purchases,
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS Total_Revenue
FROM customer_shopping
GROUP BY `Payment Method`
ORDER BY Number_of_Purchases DESC;

-- 11. Customer Type Analysis
SELECT
    `Customer Type`,
    COUNT(*) AS Number_of_Purchases,
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS Total_Revenue,
    ROUND(AVG(`Purchase Amount (USD)`), 2) AS Average_Purchase
FROM customer_shopping
GROUP BY `Customer Type`
ORDER BY Total_Revenue DESC;

-- 12. Revenue by Age Group
SELECT
    `Age Group`,
    COUNT(*) AS Number_of_Purchases,
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS Total_Revenue,
    ROUND(AVG(`Purchase Amount (USD)`), 2) AS Average_Purchase
FROM customer_shopping
GROUP BY `Age Group`
ORDER BY Total_Revenue DESC;

-- 13. Customer Loyalty Classification
SELECT
    `Customer ID`,
    `Previous Purchases`,
    CASE
        WHEN `Previous Purchases` = 0 THEN 'One-Time'
        WHEN `Previous Purchases` BETWEEN 1 AND 10 THEN 'Occasional'
        WHEN `Previous Purchases` BETWEEN 11 AND 30 THEN 'Regular'
        ELSE 'Loyal'
    END AS Loyalty_Level
FROM customer_shopping
LIMIT 20;

-- 14. Category Revenue Ranking
WITH category_revenue AS (
    SELECT
        Category,
        SUM(`Purchase Amount (USD)`) AS Total_Revenue
    FROM customer_shopping
    GROUP BY Category
)

SELECT
    Category,
    ROUND(Total_Revenue, 2) AS Total_Revenue,
    RANK() OVER (ORDER BY Total_Revenue DESC) AS Revenue_Rank
FROM category_revenue
ORDER BY Revenue_Rank;