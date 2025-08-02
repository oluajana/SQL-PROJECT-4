SELECT * FROM project.emptable;

UPDATE emptable
SET hire_date = STR_TO_DATE(hire_date, '%m/%d/%Y');

SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(CASE 
            WHEN hire_date > DATE_SUB(CURDATE(), INTERVAL 5 YEAR) 
            THEN 1 
            ELSE 0 
        END) AS recent_hires,
    (SUM(CASE 
            WHEN hire_date > DATE_SUB(CURDATE(), INTERVAL 5 YEAR) 
            THEN 1 
            ELSE 0 
        END) * 100.0) / COUNT(*) AS recent_hire_percentage
FROM 
    emptable
GROUP BY 
    department
HAVING 
    recent_hire_percentage > 50;









