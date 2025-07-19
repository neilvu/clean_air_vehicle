/* TOPIC 1: Clean Eligible Vehicles By Each County Population */

#########/* CODE 1: Calculating total residents who owns ELIGIBLE EV cars by each WA county */######

-- PURPOSE: To identify how many residents in WA had owned eligible vehicles to meet the clean air
-- requirement for tax exemption purposes.

########################### ENTRY NOTES #######################
-- a). Always highlight which database type that you need to 
-- input from your tables.

-- b). Write your name on each of the query by the clause
-- so that we know who is being assigned to.

-- c). Check with the syntaxs as well the logic to ensure that
-- the code works in a way that reflects the team question
##############################################################



### PART I: Counting Total Residents on Each WA County on all vehicles combined ######

-- DESCRIPTION: To count total residents from each WA county on all vehicles combined,
-- regardless if their vehicles are marked eligible or not.

-- TABLES: registration_location, vehicles
-- KEY: registration_id, location_id, ve_reg_id

USE ev_cars;
CREATE OR REPLACE VIEW total_pop_by_county_owns_vehicles AS
-- Count by total residents by each county who owns EV cars on record.
SELECT 
	   CONCAT(r.county, ' ', 'County') AS 'County Name',
	   COUNT(v.ve_reg_id) AS 'Total County Residents Who Have ALL Vehicles.'
FROM registration_location r
	-- Count by total amount of vehicles in each of the manufacters in this section.
	JOIN vehicle v
		USING(location_id)
	JOIN 
		(SELECT 
			SUM(ev.clean_veh_fuel_elig) AS total_veh
		 FROM ev_vehicle_descrp ev)t
GROUP BY county
ORDER BY county ASC;


/* Check the values to see the results */
SELECT *
FROM total_pop_by_county_owns_vehicles;




### PART II: Counting Total Residents on Each WA County Who Are Eligible on Vehicles marked Clean ####

-- DESCRIPTION: To count total residents from each WA County who have their eligible vehicles marked
-- as clean, enviromental friendly for the state.

-- This is saying how many eligible vehicles idenitfied in each county as of the year gathered when 
-- extracting into the database.

-- TABLES: registration_location, ev_vehicle_descrip, vehicles
-- KEY: registration_id, location_id, ve_reg_id, ev_veh_id

USE ev_cars;
CREATE OR REPLACE VIEW total_pop_by_county_owns_clean_eligible_vehicles AS
-- Count by total residents by each county who owns EV cars on record.
SELECT 
	   CONCAT(r.county, ' ', 'County') AS 'County Name',
	   COUNT(v.ve_reg_id) AS 'Total County Residents Who Have Eligible Clean Vehicles.'
FROM registration_location r
	-- Count by total amount of vehicles in each of the manufacters in this section.
	JOIN vehicle v
		USING(location_id)
	JOIN 
		(SELECT 
			COUNT(ev_veh_id),
			COUNT(ev.clean_veh_fuel_elig) AS total_eligible_veh
		 FROM ev_vehicle_descrp ev
		 WHERE ev.clean_veh_fuel_elig AND ev_veh_id = 'Eligible')t
GROUP BY county
ORDER BY county ASC;


/* Check the values to see the results */
SELECT *
FROM total_pop_by_county_owns_clean_eligible_vehicles;
