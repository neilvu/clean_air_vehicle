/* TOPIC 1: List of All Vehicles By Each County Population */

#########/* CODE 1: Calculating total residents who owns all cars by each WA county */######

-- PURPOSE: To identify how many residents in WA had registered their vehicles for the 
-- emission program in the year 2022.

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
-- Count by total residents by each county who owns all vehicles on record.
SELECT 
	   CONCAT(r.county, ' ', 'County') AS 'County Name',
	   COUNT(v.ve_reg_id) AS 'Total County Residents Who Have ALL Vehicles.'
FROM registration_location r
	JOIN vehicle v
		USING(location_id)
	-- List the total amount of all vehicles listed eligible and ineligble in this section.
	JOIN 
		(SELECT 
			SUM(ev.clean_veh_fuel_elig) AS total_veh
		 FROM ev_vehicle_descrp ev)t
-- Sort it by county to return the list of vehicles.
GROUP BY county
ORDER BY county ASC;


/* Check the values to see the results */
SELECT *
FROM total_pop_by_county_owns_vehicles;