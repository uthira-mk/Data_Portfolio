USE vehdb;
CREATE TABLE product_t (
	PRODUCT_ID INTEGER,
	VEHICLE_MAKER VARCHAR(60),
	VEHICLE_MODEL VARCHAR(60),
	VEHICLE_COLOR VARCHAR(60),
	VEHICLE_MODEL_YEAR INTEGER,
	VEHICLE_PRICE DECIMAL(14 , 2 ),
	PRIMARY KEY (PRODUCT_ID)
);