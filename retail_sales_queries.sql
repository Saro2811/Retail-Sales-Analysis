-- Retail Sales & Profit Analysis
-- SQL Business Analysis Queries
-- Database: SQLite
-- Table: sales

-- 1. Total Sales
SELECT ROUND(SUM(Sales), 2) AS Total_Sales FROM sales;

-- 2. Total Profit
SELECT ROUND(SUM(Profit), 2) AS Total_Profit FROM sales;

-- 3. Total Orders
SELECT COUNT(DISTINCT "Order ID") AS Total_Orders FROM sales;

-- 4. Sales and Profit by Category
SELECT Category, ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales GROUP BY Category ORDER BY Total_Sales DESC;

-- 5. Sales and Profit by Region
SELECT Region, ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales GROUP BY Region ORDER BY Total_Sales DESC;

-- 6. Top 10 Products by Sales
SELECT "Product Name", ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales GROUP BY "Product Name"
ORDER BY Total_Sales DESC LIMIT 10;

-- 7. Top 10 Products by Profit
SELECT "Product Name", ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales GROUP BY "Product Name"
ORDER BY Total_Profit DESC LIMIT 10;

-- 8. Loss-Making Products
SELECT "Product Name", ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales GROUP BY "Product Name"
HAVING SUM(Profit) < 0 ORDER BY Total_Profit ASC LIMIT 10;

-- 9. Top 10 Customers by Profit
SELECT "Customer ID", "Customer Name",
       ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales
GROUP BY "Customer ID", "Customer Name"
ORDER BY Total_Profit DESC LIMIT 10;

-- 10. State-wise Profitability
SELECT State, ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales GROUP BY State ORDER BY Total_Profit DESC;

-- 11. Discount vs Profit
SELECT Discount, ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit,
       COUNT(DISTINCT "Order ID") AS Number_of_Orders
FROM sales GROUP BY Discount ORDER BY Discount;

-- 12. Yearly Performance
SELECT "Order Year" AS Order_Year,
       ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales GROUP BY "Order Year" ORDER BY Order_Year;

-- 13. Segment Performance
SELECT Segment, ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit,
       COUNT(DISTINCT "Order ID") AS Total_Orders
FROM sales GROUP BY Segment ORDER BY Total_Sales DESC;

-- 14. Shipping Performance
SELECT "Ship Mode", ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit,
       ROUND(AVG("Shipping Days"), 2) AS Average_Shipping_Days,
       COUNT(DISTINCT "Order ID") AS Total_Orders
FROM sales GROUP BY "Ship Mode" ORDER BY Total_Sales DESC;

-- 15. Category Ranking by Profit
SELECT Category, ROUND(SUM(Profit), 2) AS Total_Profit,
       RANK() OVER (ORDER BY SUM(Profit) DESC) AS Profit_Rank
FROM sales GROUP BY Category ORDER BY Profit_Rank;

-- 16. Sub-Category Performance
SELECT "Sub-Category", ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit,
       SUM(Quantity) AS Total_Quantity
FROM sales GROUP BY "Sub-Category" ORDER BY Total_Profit DESC;

-- 17. Category x Region Profit
SELECT Region, Category, ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales GROUP BY Region, Category
ORDER BY Region, Total_Profit DESC;

-- 18. Most Profitable Cities
SELECT City, State, ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales GROUP BY City, State
ORDER BY Total_Profit DESC LIMIT 10;

-- 19. High-Sales but Loss-Making Products
SELECT "Product Name", ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit
FROM sales GROUP BY "Product Name"
HAVING SUM(Sales) > (
    SELECT AVG(Product_Sales)
    FROM (
        SELECT SUM(Sales) AS Product_Sales
        FROM sales GROUP BY "Product Name"
    )
)
AND SUM(Profit) < 0
ORDER BY Total_Sales DESC;

-- 20. Overall Profit Margin
SELECT ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
       AS Profit_Margin_Percent
FROM sales;
