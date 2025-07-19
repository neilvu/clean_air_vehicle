/* TOPIC 2: List of Ineligible Registered Vehicles By Each WA County */

#########/* CODE 1: Calculating total residents who owns INELIGIBLE EV cars by each WA county */######

-- PURPOSE: To identify how many residents in WA who had owned ineligible vehicles as a way finding the 
-- flaws of the program and how it can be improved on meeting the clean air requirement threshold for the
-- program's decision.

########################### ENTRY NOTES #######################
-- a). Always highlight which database type that you need to 
-- input from your tables.

-- b). Write your name on each of the query by the clause
-- so that we know who is being assigned to.

-- c). Check with the syntaxs as well the logic to ensure that
-- the code works in a way that reflects the team question
##############################################################

### PART I: Counting Total Residents on Each WA County Who Are Ineligible on Vehicle Programs ####

-- DESCRIPTION: To count total residents from each WA County who have their vehicles marked
-- as ineligible for the state's program.

-- This is saying how many ineligible vehicles idenitfied in each county as of the year gathered when 
-- extracting into the database.

-- TABLES: registration_location, ev_vehicle_descrip, vehicles
-- KEY: registration_id, location_id, ve_reg_id, ev_veh_id

USE ev_cars;
CREATE OR REPLACE VIEW ineligible_veh_by_county AS
-- Count by total residents by each county who owns all vehicles on record.
SELECT CONCAT(t.county, ' ', 'County') AS 'County Name',
	   COUNT(t.county) AS 'Total Ineligible Vehicles By Each WA County'
FROM
		-- Count by total amount of all vehicles listed ineligible in this section.
		(SELECT r.county,
				r.location_id,
				ev.ev_veh_id, 
				ev.clean_veh_fuel_elig
		 FROM vehicle v
			JOIN models
				USING(model_id)
			JOIN ev_vehicle_descrp ev
				USING(ev_veh_id)
			JOIN registration_location r
				USING(location_id)
		 WHERE ev.clean_veh_fuel_elig = 'Ineligible'
         GROUP BY r.county, r.location_id, ev.ev_veh_id)t
-- Sort it by county to return the list of vehicles.
GROUP BY county
ORDER BY county ASC;


/* Check the values to see the results */
SELECT *
FROM ineligible_veh_by_county;
-- 14 rows returned