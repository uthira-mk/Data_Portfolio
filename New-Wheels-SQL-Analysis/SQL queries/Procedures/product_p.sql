-- Drop the procedure 'product_p' if it already exists to avoid conflicts
DROP PROCEDURE IF EXISTS product_p;

-- Set the delimiter to $$ to allow multi-line stored procedures
DELIMITER $$ 

-- Create a stored procedure named 'product_p'
CREATE PROCEDURE product_p()
BEGIN
    -- Insert new product records from 'temp_t' into 'product_t'
    -- only for the products that don't already exist in 'product_t'
	INSERT INTO vehdb.product_t (
		PRODUCT_ID,
		VEHICLE_MAKER,
		VEHICLE_MODEL,
		VEHICLE_COLOR,
		VEHICLE_MODEL_YEAR,
		VEHICLE_PRICE

	) 
	-- Select distinct product records from 'temp_t'
	SELECT DISTINCT
		PRODUCT_ID,
		VEHICLE_MAKER,
		VEHICLE_MODEL,
		VEHICLE_COLOR,
		VEHICLE_MODEL_YEAR,
		VEHICLE_PRICE
	FROM vehdb.temp_t 
	WHERE PRODUCT_ID NOT IN (SELECT DISTINCT PRODUCT_ID FROM vehdb.product_t);
END;

-- Uncomment the next line to call the procedure and execute it
-- CALL product_p();