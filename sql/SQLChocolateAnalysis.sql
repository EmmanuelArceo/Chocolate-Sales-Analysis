-- ============================================
-- CHOCOLATE SALES ANALYSIS - COMPLETE SQL QUERIES
-- ============================================

-- ============================================
-- PROBLEM 1: MONTHLY SALES OVERVIEW
-- Total revenue, boxes, transactions, avg price per month
-- ============================================

SELECT 
    FORMAT(Order_Date, 'yyyy-MM') AS Month,
    AVG(Price_per_Box) AS Avg_Price_Per_Box,
    SUM(Price_per_Box * Boxes_Shipped) AS Total_Revenue,
    SUM(Boxes_Shipped) AS Total_Boxes_Sold,
    COUNT(Order_ID) AS Total_Transactions
FROM Sales
WHERE Order_Date IS NOT NULL
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY Month;

-- ============================================
-- PROBLEM 2: TOP & BOTTOM PRODUCTS
-- ============================================

-- Top 10 products by revenue
SELECT TOP 10
    Products,
    SUM(Price_per_Box * Boxes_Shipped) AS Total_Revenue,
    SUM(Boxes_Shipped) AS Total_Boxes_Sold
FROM Sales
GROUP BY Products
ORDER BY Total_Revenue DESC;

-- Bottom 10 products by units sold
SELECT TOP 10
    Products,
    SUM(Price_per_Box * Boxes_Shipped) AS Total_Revenue,
    SUM(Boxes_Shipped) AS Total_Boxes_Sold
FROM Sales
GROUP BY Products
ORDER BY Total_Boxes_Sold ASC;

-- ============================================
-- PROBLEM 3: REGIONAL PERFORMANCE
-- ============================================

-- Revenue by country
SELECT 
    Country,
    SUM(Price_per_Box * Boxes_Shipped) AS Total_Revenue,
    SUM(Boxes_Shipped) AS Total_Boxes_Sold,
    COUNT(Order_ID) AS Total_Transactions
FROM Sales
GROUP BY Country
ORDER BY Total_Revenue DESC;

-- Revenue per transaction by country
SELECT 
    Country,
    SUM(Price_per_Box * Boxes_Shipped) / COUNT(Order_ID) AS Revenue_Per_Transaction
FROM Sales
GROUP BY Country
ORDER BY Revenue_Per_Transaction DESC;

-- Average price per box by country
SELECT 
    Country,
    AVG(Price_per_Box) AS Avg_Price_Per_Box
FROM Sales
GROUP BY Country
ORDER BY Avg_Price_Per_Box ASC;

-- ============================================
-- PROBLEM 4: PROFIT MARGIN (For Power BI)
-- ============================================

-- Profit after marketing by country
SELECT 
    Country,
    SUM(Amount) AS Total_Revenue,
    SUM(Marketing_Spend) AS Total_Marketing,
    SUM(Amount) - SUM(Marketing_Spend) AS Profit_After_Marketing
FROM Sales
GROUP BY Country
ORDER BY Profit_After_Marketing DESC;

-- Monthly profit after marketing
SELECT 
    FORMAT(Order_Date, 'yyyy-MM') AS Month,
    SUM(Amount) AS Total_Revenue,
    SUM(Marketing_Spend) AS Total_Marketing,
    SUM(Amount) - SUM(Marketing_Spend) AS Profit_After_Marketing
FROM Sales
WHERE Order_Date IS NOT NULL
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY Month;

-- ============================================
-- PROBLEM 5: TRENDS & GROWTH
-- Month-over-month growth rate
-- ============================================

WITH Monthly_Revenue AS (
    SELECT 
        FORMAT(Order_Date, 'yyyy-MM') AS Month,
        SUM(Price_per_Box * Boxes_Shipped) AS Total_Revenue
    FROM Sales
    WHERE Order_Date IS NOT NULL
    GROUP BY FORMAT(Order_Date, 'yyyy-MM')
)
SELECT 
    Month,
    Total_Revenue,
    LAG(Total_Revenue) OVER (ORDER BY Month) AS Previous_Month_Revenue,
    Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY Month) AS Revenue_Change,
    ROUND(
        ((Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY Month)) / 
        LAG(Total_Revenue) OVER (ORDER BY Month)) * 100, 
        2
    ) AS Growth_Rate_Percent
FROM Monthly_Revenue
ORDER BY Month;