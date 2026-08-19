USE SmartParkingDB;

-- 1. Check total number of records
SELECT
    COUNT(*) AS Total_Records
FROM parking_transactions;


-- 2. Check duplicate Transaction IDs
SELECT
    Transaction_ID,
    COUNT(*) AS Duplicate_Count
FROM parking_transactions
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;


-- 3. Check NULL values in important columns
SELECT
    SUM(CASE WHEN Transaction_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Transaction_ID,
    SUM(CASE WHEN Facility_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Facility_ID,
    SUM(CASE WHEN Vehicle_Type IS NULL THEN 1 ELSE 0 END) AS Missing_Vehicle_Type,
    SUM(CASE WHEN Customer_Type IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_Type,
    SUM(CASE WHEN Entry_Date IS NULL THEN 1 ELSE 0 END) AS Missing_Entry_Date,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Missing_Payment_Method,
    SUM(CASE WHEN Payment_Status IS NULL THEN 1 ELSE 0 END) AS Missing_Payment_Status
FROM parking_transactions;


-- 4. Check invalid parking duration
SELECT
    COUNT(*) AS Invalid_Duration
FROM parking_transactions
WHERE Parking_Duration_Min <= 0;


-- 5. Check invalid hourly rates
SELECT
    COUNT(*) AS Invalid_Hourly_Rate
FROM parking_transactions
WHERE Hourly_Rate <= 0;


-- 6. Check negative revenue
SELECT
    COUNT(*) AS Negative_Revenue
FROM parking_transactions
WHERE Net_Revenue < 0;


-- 7. Check invalid discount values
SELECT
    COUNT(*) AS Invalid_Discount
FROM parking_transactions
WHERE Discount_Amount < 0;


-- 8. Check invalid occupancy rates
SELECT
    COUNT(*) AS Invalid_Occupancy
FROM parking_transactions
WHERE Occupancy_Rate < 0
   OR Occupancy_Rate > 1;


-- 9. Check invalid entry hours
SELECT
    COUNT(*) AS Invalid_Entry_Hour
FROM parking_transactions
WHERE Entry_Hour < 0
   OR Entry_Hour > 23;


-- 10. Check future dates
SELECT
    COUNT(*) AS Future_Dates
FROM parking_transactions
WHERE Entry_Date > CURDATE();


-- 11. Check available vehicle types
SELECT
    Vehicle_Type,
    COUNT(*) AS Total
FROM parking_transactions
GROUP BY Vehicle_Type
ORDER BY Total DESC;


-- 12. Check customer types
SELECT
    Customer_Type,
    COUNT(*) AS Total
FROM parking_transactions
GROUP BY Customer_Type
ORDER BY Total DESC;


-- 13. Check payment methods
SELECT
    Payment_Method,
    COUNT(*) AS Total
FROM parking_transactions
GROUP BY Payment_Method
ORDER BY Total DESC;


-- 14. Check payment status
SELECT
    Payment_Status,
    COUNT(*) AS Total
FROM parking_transactions
GROUP BY Payment_Status
ORDER BY Total DESC;


-- 15. Check parking types
SELECT
    Parking_Type,
    COUNT(*) AS Total
FROM parking_transactions
GROUP BY Parking_Type
ORDER BY Total DESC;
