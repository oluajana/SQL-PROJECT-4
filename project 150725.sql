SELECT * FROM emptable;
USE world;
SELECT 
    hire_date,
    STR_TO_DATE(hire_date, '%m/%d/%Y') AS hiredate
FROM emptable;

ALTER TABLE emptable
DROP COLUMN hire_date;
UPDATE emptable
SET hire_date = hiredate;