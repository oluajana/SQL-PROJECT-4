SELECT * FROM project.samplestore;
SET SQL_SAFE_UPDATES = 0;

UPDATE samplestore
SET Sales = REPLACE(REPLACE(Sales, '$', ''), ',', '');

ALTER TABLE samplestore
ADD COLUMN Total_Sales VARCHAR(50);

UPDATE samplestore
SET Total_Sales = ROUND(Sales * Quantity, 2);

UPDATE samplestore
SET Total_Sales = ROUND(Sales * Quantity, 2);

UPDATE samplestore
SET Profit = REPLACE(REPLACE(Profit, '$', ''), ',', '');

ALTER TABLE samplestore
MODIFY COLUMN Total_Sales VARCHAR(50) AFTER Quantity;

UPDATE samplestore
SET 
    `Order Date` = STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
    `Ship Date` = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');

ALTER TABLE samplestore
ADD COLUMN Order_Year INT,
ADD COLUMN Order_Quarter VARCHAR(10);
UPDATE samplestore
SET 
    Order_Year = YEAR(`Order Date`),
    Order_Quarter = CONCAT('Q', QUARTER(`Order Date`));
    
    ALTER TABLE samplestore
ADD COLUMN Order_Month VARCHAR(20);
UPDATE samplestore
SET Order_Month = MONTHNAME(`Order Date`);

  





/*1. Which sub-categories tend to be sold in high quantities but result in poor or negative profits?*/
SELECT DISTINCT `Sub-Category`, Quantity, Profit
FROM samplestore
WHERE Profit <= 0
ORDER BY Quantity DESC;


SELECT DISTINCT `Sub-Category`,
       SUM(Quantity) AS Total_Quantity,
       SUM(Profit) AS Total_Profit
FROM samplestore
GROUP BY `Sub-Category`
ORDER BY Total_Quantity DESC;

/*--2. Are higher discounts consistently linked to lower profits across all markets, or are there exceptions?*/



/*3.Which customer segments benefit from high discounts yet still generate substantial profit?*/
SELECT Segment,
       MAX(Discount) AS Max_Discount,
       MAX(Profit) AS Max_Profit
FROM samplestore
GROUP BY Segment
ORDER BY Max_Profit DESC
LIMIT 1
OFFSET 2;

/* 4.Which cities are purchasing the most items overall, and how do their profit patterns compare?*/
SELECT City, 
SUM(Total_Sales) AS Gross_Sales,
SUM(Profit) AS Gross_Profit
FROM samplestore
GROUP BY Total_Sales
HAVING Gross_Profit
ORDER BY Gross_Sales DESC;

/*--5. Which markets (e.g., Asia Pacific, Europe) show the largest disparity between sales and profit?*/
SELECT 
	Market,
	ROUND(SUM(Total_Sales), 2) AS Gross_Sales,
	ROUND(SUM(Profit),2) AS Gross_Profit,
    ROUND(SUM(Total_Sales) - SUM(Profit), 2) AS Disparity
FROM 
	samplestore
GROUP BY Market
HAVING SUM(Total_Sales)
ORDER BY ROUND(SUM(Total_Sales) - SUM(Profit), 2) DESC
LIMIT 1;

/*6. Are there any delays between order date and ship date that occur more in certain regions or for specific segments?*/

SELECT 
	distinct Region, 
	`Order Date`, 
	`Ship Date`,
    DATEDIFF(`Ship Date`, `Order Date`) AS Delivery_Timeline
FROM samplestore
GROUP BY Region
HAVING DATEDIFF(`Ship Date`, `Order Date`) 
ORDER BY Delivery_Timeline DESC;

/*Which year or quarter had the best overall profit performance globally?*/
SELECT 
Order_Year,
Order_Quarter,
Profit
FROM samplestore
ORDER BY Profit DESC
LIMIT 1;

/* 8. Identify seasonal patterns — are there specific months where losses spike or profits soar?*/
SELECT Order_Year, Order_Month, Profit
FROM samplestore
WHERE Profit 
ORDER BY Order_Month ASC;











