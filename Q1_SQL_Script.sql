/* 
Question 1: Data Analysis with SQL and Python
Create table and name it as OnlineRetail 
*/ 

CREATE TABLE IF NOT EXISTS OnlineRetail (
    InvoiceNo INT,
    StockCode NVARCHAR(50),
    Description NVARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice FLOAT,
    CustomerID INT,
    Country NVARCHAR(50),
    PRIMARY KEY (InvoiceNo, StockCode)
)

/* Enable CSV mode */ 
.mode csv

/* Import the CSV file into the OnlineRetail table */ 
.import 'Online_Retail.csv' OnlineRetail

/* Verify the data */ 
SELECT * FROM OnlineRetail LIMIT 10;

/* Find the top 10 customers by total purchase amount. */
SELECT
    CustomerID,
    SUM(UnitPrice * Quantity) AS TotalPurchaseAmount
FROM
    OnlineRetail
WHERE
    CustomerID IS NOT NULL
GROUP BY
    CustomerID
ORDER BY
    TotalPurchaseAmount DESC
LIMIT 10

/* Identify the most popular products based on the number of orders. */
SELECT
    StockCode,
    Description,
    COUNT(*) AS NumberOfOrders
FROM
    OnlineRetail
WHERE
    StockCode IS NOT NULL
GROUP BY
    StockCode, Description
ORDER BY
    NumberOfOrders DESC
LIMIT 10

/* Calculate the monthly revenue for the dataset's time range */
SELECT
    strftime('%Y-%m', InvoiceDate) AS Month,
    ROUND(SUM(UnitPrice * Quantity), 2) AS MonthlyRevenue
FROM
    OnlineRetail
WHERE
    InvoiceDate IS NOT NULL
GROUP BY
    strftime('%Y-%m', InvoiceDate)
ORDER BY
    Month