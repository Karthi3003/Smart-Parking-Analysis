# Smart Parking Analysis — Data Dictionary

## Dataset Overview

The Smart Parking Analysis dataset contains 10,000 parking transaction records used to analyze parking operations, occupancy, revenue, customer behavior, and parking demand.

## Transaction Fields

| Column               | Data Type     | Description                                        | Example    |
| -------------------- | ------------- | -------------------------------------------------- | ---------- |
| Transaction_ID       | VARCHAR(20)   | Unique identifier for each parking transaction     | PT100001   |
| Facility_ID          | VARCHAR(10)   | Identifier of the parking facility                 | F007       |
| Vehicle_Type         | VARCHAR(30)   | Type of vehicle using the parking facility         | Car        |
| Customer_Type        | VARCHAR(30)   | Type of parking customer                           | Member     |
| Entry_Date           | DATE          | Date when the vehicle entered the parking facility | 2025-05-30 |
| Entry_Hour           | INT           | Hour of vehicle entry, from 0 to 23                | 8          |
| Parking_Duration_Min | INT           | Total parking duration in minutes                  | 261        |
| Payment_Method       | VARCHAR(30)   | Method used to make the payment                    | UPI        |
| Payment_Status       | VARCHAR(20)   | Status of the parking payment                      | Paid       |
| Parking_Type         | VARCHAR(30)   | Type of parking facility/space                     | Covered    |
| Hourly_Rate          | DECIMAL(10,2) | Parking charge per hour                            | 50.00      |
| Discount_Amount      | DECIMAL(10,2) | Discount applied to the parking transaction        | 10.00      |
| Net_Revenue          | DECIMAL(10,2) | Final revenue generated from the transaction       | 150.00     |
| Occupancy_Rate       | DECIMAL(5,2)  | Parking occupancy rate represented as a decimal    | 0.85       |

## Power Query Derived Columns

The following columns were created during the Power Query transformation stage.

| Column                    | Description                                           | Example     |
| ------------------------- | ----------------------------------------------------- | ----------- |
| Entry_Hour_Category       | Groups entry time into business-friendly time periods | Morning     |
| Parking_Duration_Category | Groups parking duration into stay categories          | Medium Stay |
| Occupancy_Category        | Classifies parking occupancy level                    | High        |

## Entry Hour Categories

| Category  | Range    |
| --------- | -------- |
| Morning   | Up to 10 |
| Afternoon | 11–14    |
| Evening   | 15–18    |
| Night     | 19–23    |

## Parking Duration Categories

| Category      | Duration              |
| ------------- | --------------------- |
| Short Stay    | Up to 60 minutes      |
| Medium Stay   | 61–180 minutes        |
| Long Stay     | 181–300 minutes       |
| Extended Stay | More than 300 minutes |

## Occupancy Categories

| Category      | Occupancy Rate |
| ------------- | -------------- |
| Underutilized | Below 40%      |
| Normal        | 40%–69%        |
| High          | 70%–84%        |
| Critical      | 85% or above   |

## Data Quality Checks

The dataset was validated for:

* Duplicate transaction IDs
* Missing values
* Invalid parking duration
* Invalid hourly rates
* Negative revenue
* Invalid discount values
* Invalid occupancy rates
* Invalid entry hours
* Future dates
* Unexpected categorical values

## Power BI Data Model

A Date dimension was created in Power BI and related to the parking transaction table using `Entry_Date`.

```text
Dim_Date
    |
    | 1 : *
    |
Smartparking analysis
```

## Key Analytical Measures

* Total Revenue
* Total Parking Sessions
* Average Parking Duration
* Average Occupancy
* Average Revenue per Session
* Paid Sessions
* Payment Success Rate
* Total Discount
* Paid Revenue
* Revenue per Parking Minute
* Peak Parking Hour
* Peak Occupancy
* High Occupancy Sessions
* Low Occupancy Sessions
