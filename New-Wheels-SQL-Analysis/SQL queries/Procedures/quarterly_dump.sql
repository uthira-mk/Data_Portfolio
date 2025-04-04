-- Set the active database to 'vehdb'
USE vehdb;

-- Truncate the 'temp_t' table to remove any existing data before loading new data
TRUNCATE temp_t;

-- Load data from a CSV file into the 'temp_t' table
-- The LOCAL keyword allows the file to be loaded from the local machine (client machine)
-- Ensure the file path is correctly specified in <File_path>
LOAD DATA LOCAL INFILE "<File_path>"
INTO TABLE temp_t
FIELDS terminated by ','
OPTIONALLY enclosed by '"'
lines terminated by '\n'
ignore 1 lines
-- Map the columns in the input file to the columns in the table
(  SHIPPER_ID, SHIPPER_NAME, SHIPPER_CONTACT_DETAILS, PRODUCT_ID, VEHICLE_MAKER, VEHICLE_MODEL, VEHICLE_COLOR, VEHICLE_MODEL_YEAR, 
	VEHICLE_PRICE, QUANTITY, DISCOUNT, CUSTOMER_ID, CUSTOMER_NAME, GENDER, JOB_TITLE, PHONE_NUMBER, EMAIL_ADDRESS, CITY, COUNTRY, STATE,
    CUSTOMER_ADDRESS, ORDER_DATE, ORDER_ID, SHIP_DATE, SHIP_MODE, SHIPPING, POSTAL_CODE, CREDIT_CARD_TYPE, CREDIT_CARD_NUMBER, 
    CUSTOMER_FEEDBACK, QUARTER_NUMBER
)