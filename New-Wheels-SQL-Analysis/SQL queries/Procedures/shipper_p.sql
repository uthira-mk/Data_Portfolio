-- Drop the procedure 'shipper_p' if it already exists to avoid conflicts
DROP PROCEDURE IF EXISTS shipper_p;

-- Set the delimiter to $$ to allow multi-line stored procedures 
DELIMITER $$ 

-- Create the procedure 'shipper_p' to insert unique shipper data into 'shipper_t'
CREATE PROCEDURE shipper_p()
BEGIN
	-- Insert shipper records into 'shipper_t'
	INSERT INTO vehdb.shipper_t (
		SHIPPER_ID,
		SHIPPER_NAME,
		SHIPPER_CONTACT_DETAILS
	)
    -- Select unique shipper records from 'temp_t'
	SELECT DISTINCT
		SHIPPER_ID,
		SHIPPER_NAME,
		SHIPPER_CONTACT_DETAILS
	FROM vehdb.temp_t 
    -- Insert only those shipper records that do not already exist in 'shipper_t'
	WHERE SHIPPER_ID NOT IN (SELECT DISTINCT SHIPPER_ID FROM vehdb.shipper_t);
END;

-- Uncomment the next line to call the procedure and execute it
-- CALL shipper_p();