CHOCOLATE SALES ANALYSIS — PORTFOLIO DOCUMENTATION
====================================================

PROJECT OVERVIEW
----------------
This project analyzes sales data for a chocolate company operating across 5 countries 
(Australia, Brazil, Germany, India, Japan) with 12 products. The goal is to understand 
revenue patterns, product performance, regional differences, and marketing efficiency 
to drive business decisions.

Tools Used: SQL, Power BI, Excel
Dataset: 200,000 orders, 27.9M boxes shipped, $117.78M total revenue


PROBLEM 1: MONTHLY SALES OVERVIEW
----------------------------------
Business Question:
What was the total revenue, boxes sold, transactions, and average price per box for 
each month? Which month had the highest revenue?

SQL Approach:
- Extract year-month from Order_Date using FORMAT(Order_Date, 'yyyy-MM')
- Filter out NULL dates
- Group by formatted month
- Calculate: AVG(Price_per_Box), SUM(Price_per_Box * Boxes_Shipped), 
  SUM(Boxes_Shipped), COUNT(Order_ID)
- Sort chronologically

Key Results:
- Highest revenue month: December ($12.8M)
- Second highest: November ($11.2M)
- Lowest revenue month: June ($8.3M)
- Peak boxes sold: December
- Pattern: Strong Q4 seasonality; Dec peaks, mid-year weakest

Business Insight:
December is the absolute sales peak, driven by holiday gifting season. Summer months 
(June–August) show the weakest performance — presenting a potential opportunity for 
summer-themed promotions or product launches to boost off-season sales.


PROBLEM 2: TOP & BOTTOM PRODUCTS
---------------------------------
Business Question:
Which are the top 10 products by total revenue? Which are the bottom 10 products by units 
sold? Is there any product that appears in both lists?

SQL Approach:
Part A — Top 10 by Revenue: Group by Products, calculate total revenue and boxes sold, 
sort by revenue descending, limit to 10.
Part B — Bottom 10 by Units Sold: Same grouping, sort by total boxes sold ascending, 
limit to 10.

Key Results:
Top 3 by Revenue:
1. 70% Dark Bar — $30.3M
2. Mixed Assortment Box — $22.5M
3. Truffle Gift Box — $22.2M

Bottom 3 by Units Sold:
1. Hazelnut Milk Bar — $2.5M
2. Salted Caramel Bar — $3.2M
3. 85% Dark Bar — $3.4M

Overlap Analysis:
6 products appear in both Top 10 by Revenue and Bottom 10 by Units Sold.

Business Insight:
The significant overlap indicates that most products have similar price points, causing 
revenue ranking to closely track volume ranking. The true low-performers are Hazelnut Milk 
Bar and Salted Caramel Bar, which appear only in the bottom list — suggesting potential 
candidates for discontinuation or reformulation.


PROBLEM 3: REGIONAL PERFORMANCE
--------------------------------
Business Question:
How do sales differ across countries or regions? Which region generates the most revenue 
per transaction on average? Which region has the lowest average price per box?

SQL Approach:
- Group by Country
- Calculate: Total Revenue, Revenue per Transaction, Average Price per Box
- Run three separate queries sorted by different metrics

Key Results:
Country          | Total Revenue | Revenue per Transaction
-----------------|---------------|-------------------------
Australia        | $48.8M        | $458
Brazil           | $42.0M        | $692
Germany          | $13.0M        | $449
India            | $7.4M         | $371
Japan            | $6.5M         | $485

Answers to Business Questions:
1. Highest Total Revenue: Australia ($48.8M)
2. Highest Revenue per Transaction: Brazil ($692)
3. Lowest Revenue per Transaction: India ($371)

Business Insight:
The regional analysis reveals three distinct market profiles: Australia operates as a 
volume leader; Brazil represents a premium, high-spend-per-order market; and India shows 
the lowest revenue per transaction, suggesting a price-sensitive market. The business 
should consider region-specific strategies: maintain volume in Australia, premium product 
expansion in Brazil, and basket-size optimization in India.


PROBLEM 4: PROFIT MARGIN ANALYSIS (POWER BI DASHBOARD)
-------------------------------------------------------
Business Question:
How efficient is marketing spend by country? What is the profit after marketing and the 
margin percentage?

DAX Measures Used:
- Total Revenue = SUM(Sales[Amount])
- Total Marketing Spend = SUM(Sales[Marketing_Spend])
- Profit After Marketing = [Total Revenue] - [Total Marketing Spend]
- Profit Margin % = DIVIDE([Profit After Marketing], [Total Revenue], 0)

Dashboard Pages:
- KPI Cards: Profit After Marketing ($98.73M), Total Revenue ($117.78M), 
  Marketing Spend ($19.05M), Profit Margin (83.83%)
- Country Bar Chart: Revenue vs Profit After Marketing by Country
- Monthly Line Chart: Revenue and Profit After Marketing trend over months
- Margin Ranking: Profit Margin % by Country (Brazil 87%, Japan 81%, Australia 81%, 
  Germany 80%, India 75%)

Key Results:
- Overall profit margin: 83.83%
- Brazil leads with 87% margin
- India trails with 75% margin
- December peak: $12.8M revenue
- June slump: $8.3M revenue
- Clear seasonal pattern: holiday surge, summer dip

Business Insight:
Brazil generates the most profit per dollar spent. India needs attention due to low margin 
and low revenue. Seasonal patterns are consistent and predictable.

Important Note:
This measures marketing efficiency only (Revenue - Marketing). It does NOT include 
manufacturing costs (COGS), shipping, import tariffs, or local operating costs. True 
business profit would be significantly lower.


PROBLEM 5: TRENDS & GROWTH
---------------------------
Business Question:
What is the month-over-month revenue growth rate? Which months showed the biggest increase 
and biggest decline? Can we identify seasonal patterns that repeat across both years?

SQL Approach:
- Step 1: Aggregate monthly revenue using GROUP BY with FORMAT(Order_Date, 'yyyy-MM')
- Step 2: Retrieve previous month revenue using LAG() window function
- Step 3: Calculate growth rate: ((Current - Previous) / Previous) * 100

Key Results:
Metric                | Month     | Revenue Change | Growth %
----------------------|-----------|----------------|----------
Biggest Increase      | 2022-12   | +$0.9M         | +15.83%
Second Biggest        | 2022-11   | +$0.5M         | +10.46%
Biggest Decline       | 2023-02   | -$1.1M         | -19.16%
Second Biggest        | 2022-02   | -$0.9M         | -14.86%
Post-Holiday Drop     | 2023-01   | -$0.5M         | -8.26%

Findings:
- Holiday Peak (December): Consistently highest revenue surge
- Pre-Holiday Buildup (November): Strong growth
- Post-Holiday Collapse (Jan-Feb): Sharp declines
- Summer Slump (June-Aug): Consistently lower revenue
- Recovery (Mar-May, Sep-Oct): Gradual return to normal

Business Insight:
The business exhibits high month-to-month volatility driven primarily by seasonal demand. 
Negative growth in January-February is expected, not alarming. Promotions should be 
concentrated in low months (June-August) to stimulate demand, not in December when natural 
demand is already high.


SKILLS DEMONSTRATED
-------------------
- SQL: Aggregation, GROUP BY, ORDER BY, TOP, WHERE, CTEs, Window Functions (LAG), 
  Date Formatting, Ratio Calculation
- Power BI: Dashboard Design, DAX Measures, KPI Cards, Bar Charts, Line Charts, 
  Slicers, Filters
- Excel: Data Cleaning, PivotTables, Charts
- Business Analysis: Insight Extraction, Recommendation Formulation, 
  Seasonal Pattern Recognition, Pareto Analysis


KEY BUSINESS RECOMMENDATIONS
----------------------------
1. Boost summer marketing (June–August) to offset seasonal dip
2. Promote 85% Dark Bar — highest margin product, underperforming in volume
3. Discontinue or reformulate Hazelnut Milk Bar — weakest performer
4. Expand premium offerings in Brazil — highest revenue per transaction
5. Fix pricing in India — lowest revenue per transaction, most price-sensitive
6. Plan inventory for December peak — need 15-20% more stock than November
7. Run promotions in low months (June-Aug), not in December


LIMITATIONS
-----------
- Only 2 years of data (2022–2023)
- No cost data (COGS, shipping, tariffs) — profit margin is marketing efficiency only
- No customer-level data for segmentation or retention analysis
- No external factors tracked (promotions, competitors, weather, economic conditions)
- First month excluded from growth calculation due to LAG function


FILES INCLUDED
--------------
- SQL queries for all problems (.sql)
- Power BI dashboard (.pbix)
- Excel source data (.xlsx)
- Portfolio documentation (this file)
- Dashboard screenshots (PNG)


END OF DOCUMENTATION
