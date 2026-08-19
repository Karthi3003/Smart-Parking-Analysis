USE SmartParkingDB;

-- =========================================================
-- SMART PARKING ANALYSIS - BUSINESS QUERIES
-- =========================================================


-- 1. Total Parking Sessions
SELECT
    COUNT(*) AS Total_Parking_Sessions
FROM parking_transactions;


-- 2. Total Revenue
SELECT
    SUM(Net_Revenue) AS Total_Revenue
FROM parking_transactions;


-- 3. Average Parking Duration
SELECT
    ROUND(AVG(Parking_Duration_Min), 2) AS Average_Parking_Duration
FROM parking_transactions;


-- 4. Average Occupancy Rate
SELECT
    ROUND(AVG(Occupancy_Rate), 2) AS Average_Occupancy_Rate
FROM parking_transactions;


-- 5. Revenue by Parking Facility
SELECT
    Facility_ID,
    COUNT(*) AS Parking_Sessions,
    SUM(Net_Revenue) AS Total_Revenue
FROM parking_transactions
GROUP BY Facility_ID
ORDER BY Total_Revenue DESC;


-- 6. Parking Sessions by Facility
SELECT
    Facility_ID,
    COUNT(*) AS Total_Sessions
FROM parking_transactions
GROUP BY Facility_ID
ORDER BY Total_Sessions DESC;


-- 7. Revenue by Vehicle Type
SELECT
    Vehicle_Type,
    COUNT(*) AS Total_Sessions,
    SUM(Net_Revenue) AS Total_Revenue
FROM parking_transactions
GROUP BY Vehicle_Type
ORDER BY Total_Revenue DESC;


-- 8. Revenue by Customer Type
SELECT
    Customer_Type,
    COUNT(*) AS Total_Sessions,
    SUM(Net_Revenue) AS Total_Revenue
FROM parking_transactions
GROUP BY Customer_Type
ORDER BY Total_Revenue DESC;


-- 9. Revenue by Payment Method
SELECT
    Payment_Method,
    COUNT(*) AS Total_Sessions,
    SUM(Net_Revenue) AS Total_Revenue
FROM parking_transactions
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;


-- 10. Payment Status Analysis
SELECT
    Payment_Status,
    COUNT(*) AS Total_Transactions,
    SUM(Net_Revenue) AS Total_Revenue
FROM parking_transactions
GROUP BY Payment_Status
ORDER BY Total_Transactions DESC;


-- 11. Parking Type Analysis
SELECT
    Parking_Type,
    COUNT(*) AS Total_Sessions,
    SUM(Net_Revenue) AS Total_Revenue,
    ROUND(AVG(Occupancy_Rate), 2) AS Average_Occupancy
FROM parking_transactions
GROUP BY Parking_Type
ORDER BY Total_Revenue DESC;


-- 12. Peak Parking Hours
SELECT
    Entry_Hour,
    COUNT(*) AS Total_Sessions
FROM parking_transactions
GROUP BY Entry_Hour
ORDER BY Total_Sessions DESC;


-- 13. Average Parking Duration by Vehicle Type
SELECT
    Vehicle_Type,
    ROUND(AVG(Parking_Duration_Min), 2) AS Average_Duration
FROM parking_transactions
GROUP BY Vehicle_Type
ORDER BY Average_Duration DESC;


-- 14. Average Parking Duration by Customer Type
SELECT
    Customer_Type,
    ROUND(AVG(Parking_Duration_Min), 2) AS Average_Duration
FROM parking_transactions
GROUP BY Customer_Type
ORDER BY Average_Duration DESC;


-- 15. Monthly Revenue
SELECT
    YEAR(Entry_Date) AS Year,
    MONTH(Entry_Date) AS Month_Number,
    MONTHNAME(Entry_Date) AS Month,
    SUM(Net_Revenue) AS Total_Revenue
FROM parking_transactions
GROUP BY
    YEAR(Entry_Date),
    MONTH(Entry_Date),
    MONTHNAME(Entry_Date)
ORDER BY
    Year,
    Month_Number;


-- 16. Monthly Parking Sessions
SELECT
    YEAR(Entry_Date) AS Year,
    MONTH(Entry_Date) AS Month_Number,
    MONTHNAME(Entry_Date) AS Month,
    COUNT(*) AS Total_Sessions
FROM parking_transactions
GROUP BY
    YEAR(Entry_Date),
    MONTH(Entry_Date),
    MONTHNAME(Entry_Date)
ORDER BY
    Year,
    Month_Number;


-- 17. Revenue per Parking Session
SELECT
    ROUND(
        SUM(Net_Revenue) / COUNT(*),
        2
    ) AS Revenue_Per_Session
FROM parking_transactions;


-- 18. Facility Average Occupancy
SELECT
    Facility_ID,
    ROUND(AVG(Occupancy_Rate), 2) AS Average_Occupancy
FROM parking_transactions
GROUP BY Facility_ID
ORDER BY Average_Occupancy DESC;


-- 19. High Occupancy Analysis
SELECT
    Facility_ID,
    COUNT(*) AS High_Occupancy_Sessions
FROM parking_transactions
WHERE Occupancy_Rate >= 0.85
GROUP BY Facility_ID
ORDER BY High_Occupancy_Sessions DESC;


-- 20. Low Occupancy Analysis
SELECT
    Facility_ID,
    COUNT(*) AS Low_Occupancy_Sessions
FROM parking_transactions
WHERE Occupancy_Rate < 0.40
GROUP BY Facility_ID
ORDER BY Low_Occupancy_Sessions DESC;


-- 21. Discount Analysis
SELECT
    Customer_Type,
    SUM(Discount_Amount) AS Total_Discount,
    AVG(Discount_Amount) AS Average_Discount
FROM parking_transactions
GROUP BY Customer_Type
ORDER BY Total_Discount DESC;


-- 22. Facility Revenue and Occupancy
SELECT
    Facility_ID,
    COUNT(*) AS Total_Sessions,
    SUM(Net_Revenue) AS Total_Revenue,
    ROUND(AVG(Occupancy_Rate), 2) AS Average_Occupancy,
    ROUND(AVG(Parking_Duration_Min), 2) AS Average_Duration
FROM parking_transactions
GROUP BY Facility_ID
ORDER BY Total_Revenue DESC;


-- 23. Facilities with Revenue Above Average
SELECT
    Facility_ID,
    SUM(Net_Revenue) AS Total_Revenue
FROM parking_transactions
GROUP BY Facility_ID
HAVING SUM(Net_Revenue) >
(
    SELECT AVG(Facility_Revenue)
    FROM
    (
        SELECT
            Facility_ID,
            SUM(Net_Revenue) AS Facility_Revenue
        FROM parking_transactions
        GROUP BY Facility_ID
    ) AS Revenue_Table
)
ORDER BY Total_Revenue DESC;


-- 24. Rank Facilities by Revenue
WITH Facility_Revenue AS
(
    SELECT
        Facility_ID,
        SUM(Net_Revenue) AS Total_Revenue
    FROM parking_transactions
    GROUP BY Facility_ID
)
SELECT
    Facility_ID,
    Total_Revenue,
    RANK() OVER (
        ORDER BY Total_Revenue DESC
    ) AS Revenue_Rank
FROM Facility_Revenue
ORDER BY Revenue_Rank;


-- 25. Rank Vehicle Types by Revenue
WITH Vehicle_Revenue AS
(
    SELECT
        Vehicle_Type,
        SUM(Net_Revenue) AS Total_Revenue
    FROM parking_transactions
    GROUP BY Vehicle_Type
)
SELECT
    Vehicle_Type,
    Total_Revenue,
    RANK() OVER (
        ORDER BY Total_Revenue DESC
    ) AS Revenue_Rank
FROM Vehicle_Revenue
ORDER BY Revenue_Rank;


-- 26. Customer Type with Highest Revenue
SELECT
    Customer_Type,
    SUM(Net_Revenue) AS Total_Revenue
FROM parking_transactions
GROUP BY Customer_Type
ORDER BY Total_Revenue DESC
LIMIT 1;


-- 27. Vehicle Type with Highest Parking Usage
SELECT
    Vehicle_Type,
    COUNT(*) AS Total_Sessions
FROM parking_transactions
GROUP BY Vehicle_Type
ORDER BY Total_Sessions DESC
LIMIT 1;


-- 28. Busiest Parking Hour
SELECT
    Entry_Hour,
    COUNT(*) AS Total_Sessions
FROM parking_transactions
GROUP BY Entry_Hour
ORDER BY Total_Sessions DESC
LIMIT 1;


-- 29. Facility with Highest Occupancy
SELECT
    Facility_ID,
    ROUND(AVG(Occupancy_Rate), 2) AS Average_Occupancy
FROM parking_transactions
GROUP BY Facility_ID
ORDER BY Average_Occupancy DESC
LIMIT 1;


-- 30. Facility with Lowest Occupancy
SELECT
    Facility_ID,
    ROUND(AVG(Occupancy_Rate), 2) AS Average_Occupancy
FROM parking_transactions
GROUP BY Facility_ID
ORDER BY Average_Occupancy
LIMIT 1;
