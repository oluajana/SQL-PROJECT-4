SELECT * FROM project.hr;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE hr 
CHANGE `ï»¿ID` ID VARCHAR(50);

UPDATE hr
SET birthdate = STR_TO_DATE(birthdate, '%c/%e/%Y')
WHERE birthdate LIKE '%/%/%';

UPDATE hr
SET 
hire_date = STR_TO_DATE(hire_date, '%c/%e/%Y')
WHERE hire_date LIKE '%/%/%';

ALTER TABLE hr 
CHANGE location_state State VARCHAR(50),
CHANGE location_city City VARCHAR(50);



/*18. What is the gender breakdown in the Company?*/
SELECT gender, COUNT(*) AS No_of_Employees
FROM hr
GROUP BY gender;

/*19. How many employees work remotely for each department?*/
SELECT location, COUNT(department) AS Count_of_Employee
FROM hr
WHERE location = 'Remote'
GROUP BY location;

/*20. What is the distribution of employees who work remotely and HQ*/
SELECT location, COUNT(department) AS Count_of_Employee
FROM hr
GROUP BY location;

/*21. What is the race distribution in the Company?*/
SELECT race, COUNT(*) AS No_Of_Employee
FROM hr
GROUP BY race;

/*5. What is the distribution of employee across different states?*/
SELECT State, COUNT(*) AS No_of_Employee
FROM hr
GROUP BY State;

/*What is the number of employees whose employment has been terminated*/
SELECT COUNT(*) AS Ex_Staff
FROM hr
WHERE termdate IS NOT NULL;












