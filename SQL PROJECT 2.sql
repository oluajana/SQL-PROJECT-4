SELECT * FROM project.bajaj;
SET SQL_SAFE_UPDATES = 0;

ALTER TABLE bajaj
CHANGE COLUMN `Prev Close` `Prev_Close` VARCHAR(50),
CHANGE COLUMN `Open Price` `Open_Price` VARCHAR(50),
CHANGE COLUMN `High Price` `High_Price` VARCHAR(50),
CHANGE COLUMN `Low Price` `Low_Price` VARCHAR(50),
CHANGE COLUMN `Last Price` `Last_Price` VARCHAR(50),
CHANGE COLUMN `Close Price` `Close_Price` VARCHAR(50),
CHANGE COLUMN `Average Price` `Avg_Price` VARCHAR(50),
CHANGE COLUMN `Total Traded Quantity` `Total_Quantity` VARCHAR(50),
CHANGE COLUMN `No. of Trades` `NoOfTrade` VARCHAR(50);

ALTER TABLE bajaj
ADD COLUMN Price_Range VARCHAR(50);
UPDATE bajaj
SET Price_Range = ROUND(High_Price - Low_Price, 2);

ALTER TABLE bajaj 
ADD COLUMN Dates DATE;
UPDATE bajaj
SET Dates = STR_TO_DATE(Date, '%d-%b-%Y');

ALTER TABLE bajaj 
ADD COLUMN Year INT;
UPDATE bajaj
SET Year = YEAR(Dates);

ALTER TABLE bajaj 
ADD COLUMN Month VARCHAR(20);
UPDATE bajaj
SET Month_Name = MONTHNAME(Dates);

CREATE TABLE bajaj_backup AS
SELECT * FROM bajaj;

/*11. On which days did the stock trade fewer than 1,000 units but still record a turnover above ₹50,000?*/
SELECT Date, Total_Quantity, Turnover
FROM bajaj
WHERE Total_Quantity >1000 AND Turnover > 50000;

/*12. Identify all dates where the daily price range (high minus low) exceeded ₹100.*/
SELECT Date, Price_Range
FROM bajaj
WHERE Price_Range > 100;

/*13. What is the average closing price for each year?*/
SELECT Year, ROUND(avg(Close_Price) ,2) AS Avg_CP
FROM bajaj
GROUP BY Year
HAVING Avg_CP;

/*14. Calculate the total number of shares traded each year.*/
SELECT 
	Year, 
	SUM(Total_Quantity) AS Trade_Per_Year
	FROM bajaj
	GROUP BY Year
    HAVING Trade_Per_Year;
    
/*    15. Which year had the highest average turnover per trading day?*/
SELECT 
	Year,
    ROUND(SUM(Turnover)/COUNT(*),2) AS Daily_Turnover
FROM bajaj   
GROUP BY Year
ORDER BY Daily_Turnover DESC
LIMIT 1;

/*16. Find the years where the average traded quantity was below 5,000.*/
SELECT 
	Year, 
	ROUND(avg(Total_Quantity),2) AS Avg_Total_Quantity
FROM bajaj
GROUP BY Year
HAVING Avg_Total_Quantity < 5000;

/*17. Which months had an average close price above ₹500?*/
SELECT 
	Month_Name, 
    ROUND(avg(Close_Price), 2) AS Avg_CP
FROM bajaj
GROUP BY Month_Name
HAVING  Avg_CP > 500;   














