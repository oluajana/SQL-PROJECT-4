SELECT * FROM world.`employee attrition`;

/*-- find the percentage of employee whose marital status is divorced in the organisation -- employee attrition */

USE world;
SELECT  MaritalStatus, COUNT(*) AS total_employees
FROM `employee attrition`
WHERE (MaritalStatus/total_employees)*100

                      



