USE SmartParkingDB;

CREATE TABLE parking_transactions (
    Transaction_ID VARCHAR(20),
    Facility_ID VARCHAR(10),
    Vehicle_Type VARCHAR(30),
    Customer_Type VARCHAR(30),
    Entry_Date DATE,
    Entry_Hour INT,
    Parking_Duration_Min INT,
    Payment_Method VARCHAR(30),
    Payment_Status VARCHAR(20),
    Parking_Type VARCHAR(30),
    Hourly_Rate DECIMAL(10,2),
    Discount_Amount DECIMAL(10,2),
    Net_Revenue DECIMAL(10,2),
    Occupancy_Rate DECIMAL(5,2)
);
