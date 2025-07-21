/*DATA CLEANING */
USE car_theft;
SELECT * FROM car_theft.stolen_vehicles;
ALTER TABLE stolen_vehicles
CHANGE ï»¿vehicle_id vehicle_id INT;

SET SQL_SAFE_UPDATES = 0;
UPDATE stolen_vehicles
SET date_stolen = STR_TO_DATE(date_stolen, '%m/%d/%Y');
SET SQL_SAFE_UPDATES = 1;

/* JOINNG OF TABLES*/
SELECT 
    stolen_vehicles.*,
    locations.region,
    locations.population,
    locations.country,
    locations.density,
    make_details.make_name,
    make_details.make_type
FROM stolen_vehicles
JOIN locations ON stolen_vehicles.location_id = locations.location_id
JOIN make_details ON stolen_vehicles.make_id = make_details.make_id;


/*1. What day of the week are vehicles most and least often stolen?*/
SELECT 
    DAYNAME(date_stolen) AS `Dark days`,
    COUNT(*) AS `Occurrence`
FROM stolen_vehicles
GROUP BY DAYNAME (date_stolen)
ORDER BY `Occurrence` DESC;


SELECT 
    vehicle_type AS `Vehicle Type`,
    COUNT(*) AS `Occurrence`
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY `Occurrence` DESC;

/*3. Does this vary by region? (Vehicle type by region)*/
SELECT 
    region AS `Region`,
    vehicle_type AS `Vehicle Type`,
    COUNT(*) AS `Occurrence`
FROM stolen_vehicles
GROUP BY region, vehicle_type
ORDER BY region, `Occurrence` DESC;  
/*Error Code: 1054. Unknown column 'region' in 'field list'*/

/*4a)Which regions have the most and least number of stolen vehicles*/
SELECT 
    locations.region AS `Region`,
    COUNT(*) AS `Total Thefts`
FROM stolen_vehicles
GROUP BY locations.region
ORDER BY `Total Thefts` DESC;
/*-- Error Code: 1054. Unknown column 'locations.region' in 'field list'*/

/*What are the characteristics of the regions?

-- Urban Areas
Experience the highest number of vehicle thefts

Stolen vehicles are generally newer and span a wide variety of makes and models

Large population sizes contribute to higher theft opportunities

Black and white cars are most commonly targeted

Reflects areas with greater vehicle availability and higher resale demand

--- Suburban Areas
Show moderate levels of theft

Vehicles stolen tend to be mid-aged with a balanced range of types

Populations are moderate, offering a middle ground in exposure

Colour variation is broader, though still centered around neutral tones

---- Rural Areas
Report the lowest incidence of vehicle theft

Stolen vehicles are often older 

Silver and white vehicles are the most frequently taken

Note: Regions can be categorized by their population
*/




