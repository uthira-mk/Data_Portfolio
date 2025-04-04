-- Drop the procedure 'vehicles_p' if it already exists to avoid conflicts
DROP PROCEDURE IF EXISTS vehicles_p;

-- Set the delimiter to $$ to allow multi-line stored procedures
DELIMITER $$ 

-- Create a new procedure 'vehicles_p'
CREATE PROCEDURE vehicles_p()
BEGIN
    -- Insert data from 'temp_t' into 'new_wheels_t' 
    -- All columns from 'temp_t' will be inserted into 'new_wheels_t'
	INSERT INTO vehdb.new_wheels_t (
		SHIPPER_ID,
		SHIPPER_NAME,
		SHIPPER_CONTACT_DETAILS,
		PRODUCT_ID,
		VEHICLE_MAKER,
		VEHICLE_MODEL,
		VEHICLE_COLOR,
		VEHICLE_MODEL_YEAR,
		VEHICLE_PRICE,
		QUANTITY,
		DISCOUNT,
		CUSTOMER_ID,
		CUSTOMER_NAME,
		GENDER,
		JOB_TITLE,
		PHONE_NUMBER,
		EMAIL_ADDRESS,
		CITY,
		COUNTRY,
		STATE,
		CUSTOMER_ADDRESS,
		ORDER_DATE,
		ORDER_ID,
		SHIP_DATE,
		SHIP_MODE,
		SHIPPING,
		POSTAL_CODE,
		CREDIT_CARD_TYPE,
		CREDIT_CARD_NUMBER,
		CUSTOMER_FEEDBACK,
		QUARTER_NUMBER
	) 
    -- Select all rows from the 'temp_t' table and insert them into 'new_wheels_t'
	SELECT * FROM vehdb.temp_t;
END;


-- Uncomment the next line to call the procedure and execute it
-- CALL vehicles_p();
