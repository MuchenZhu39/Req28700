/* 
Question 3: Complex SQL Queries for Data Exploration
Load the database and create the necessary tables in an SQLite or PostgreSQL database setup 
*/ 
sqlite3 Chinook_Sqlite.sqlite
.schema table_name /* View the schema. */ 

.mode csv /* Set output mode to csv */ 

/* 1. Find the top 5 most popular genres by total sales. */ 
.output Q31_top_5_genres.csv

SELECT g.Name AS Genre, ROUND(SUM(il.UnitPrice * il.Quantity),2) AS TotalSales
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY g.Name
ORDER BY TotalSales DESC
LIMIT 5;
.output stdout

/* 2. Calculate the average invoice total by country. */ 
/* 2.1 Calculate the average invoice total by customer country. */ 
.output Q32_avg_invoice_total_by_custormer_country.csv
SELECT c.Country, ROUND(AVG(i.Total),2) AS AverageInvoiceTotal
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.Country
ORDER BY AverageInvoiceTotal DESC;
.output stdout

/* 2.2 Calculate the average invoice total by billing country. */ 
.output Q32_avg_invoice_total_by_billing_country.csv
SELECT i.BillingCountry AS Country, ROUND(AVG(i.Total),2) AS AverageInvoiceTotal
FROM Invoice i
GROUP BY i.BillingCountry
ORDER BY AverageInvoiceTotal DESC;
.output stdout

/* 3. Identify the top 3 most valued customers based on the total sum of invoices. */ 
.output Q33_top_3_customers.csv
SELECT c.FirstName || ' ' || c.LastName AS CustomerName, ROUND(SUM(i.Total),2) AS TotalInvoice
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY CustomerName
ORDER BY TotalInvoice DESC
LIMIT 3;
.output stdout

/* 4. Generate a report listing all employees who have sold over a specified amount (provide examples for amounts 1000, 5000) */
.output Q341_employees_sales_over_1000.csv
SELECT e.FirstName || ' ' || e.LastName AS EmployeeName, ROUND(SUM(i.Total),2) AS TotalSales
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY EmployeeName
HAVING TotalSales > 1000
ORDER BY TotalSales DESC;
.output stdout

.output Q342_employees_sales_over_5000.csv
SELECT e.FirstName || ' ' || e.LastName AS EmployeeName, ROUND(SUM(i.Total),2) AS TotalSales
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY EmployeeName
HAVING TotalSales > 5000
ORDER BY TotalSales DESC;
.output stdout

/* 4.x Because the above 2 queries rendered blank, I included the query below to return all the reults. */
.output Q34x_all_employees_sales.csv
SELECT e.FirstName || ' ' || e.LastName AS EmployeeName, ROUND(SUM(i.Total),2) AS TotalSales
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY EmployeeName
ORDER BY TotalSales DESC;
.output stdout

/* Exit SQLite */
.exit
