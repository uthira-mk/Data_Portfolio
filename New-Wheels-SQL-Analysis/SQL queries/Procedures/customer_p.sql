-- Drop the procedure if it already exists to avoid duplication errors
DROP PROCEDURE IF EXISTS customer_p;

-- Set the delimiter to $$ to allow multi-line stored procedures 
DELIMITER $$ 

-- Create a stored procedure named 'customer_p'
CREATE PROCEDURE customer_p()
BEGIN
    -- Insert new customer records from 'temp_t' into 'customer_t' 
    -- only if they do not already exist in 'customer_t'
	INSERT INTO vehdb.customer_t (
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
		POSTAL_CODE,
		CREDIT_CARD_TYPE,
		CREDIT_CARD_NUMBER
	) 
	-- Select distinct customer records from 'temp_t' (temporary table)
	SELECT DISTINCT
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
		POSTAL_CODE,
		CREDIT_CARD_TYPE,
		CREDIT_CARD_NUMBER
	FROM vehdb.temp_t 
	-- Insert only customers whose CUSTOMER_ID does not already exist in 'customer_t'
	WHERE CUSTOMER_ID NOT IN (SELECT DISTINCT CUSTOMER_ID FROM vehdb.customer_t);
END;
