-- Create Filesystem Mapping Files to control Virtuoso Table Name preferences via the following files
-- in ~virtuoso/vad directory, downloaded and extracted from: http://bitnine.net/tutorial/import-northwind-dataset.zip
-- I did a cd to folder "/Applications/Virtuoso 8.2.app/Contents/virtuoso/vad"
-- downloaded files using: curl -O http://bitnine.net/tutorial/import-northwind-dataset.zip
-- extracted using command: unzip import-northwind-dataset.zip

-- "csv_bl"."Northwind"."territories > territories.tb
-- "csv_bl"."Northwind"."suppliers" > suppliers.tb
-- "csv_bl"."Northwind"."shippers" > shippers.tb
-- "csv_bl"."Northwind"."regions" > regions.tb
-- "csv_bl"."Northwind"."products" > products.tb
-- "csv_bl"."Northwind"."orders" > orders.tb
-- "csv_bl"."Northwind"."order_details" > order_details.tb
-- "csv_bl"."Northwind"."employee_territories" > employee_territories.tb
-- "csv_bl"."Northwind"."employees" > employees.tb
-- "csv_bl"."Northwind"."customers" > customers.tb
-- "csv_bl"."Northwind"."categories" > categories.tb

-- Cleanup

DROP TABLE  "csv_bl"."Northwind"."customers" ;
DROP TABLE  "csv_bl"."Northwind"."order_details" ;
DROP TABLE  "csv_bl"."Northwind"."orders" ;
DROP TABLE  "csv_bl"."Northwind"."products" ;
DROP TABLE  "csv_bl"."Northwind"."categories" ;
DROP TABLE  "csv_bl"."Northwind"."suppliers" ;
DROP TABLE  "csv_bl"."Northwind"."employee_territories" ;
DROP TABLE  "csv_bl"."Northwind"."territories";
DROP TABLE  "csv_bl"."Northwind"."employees" ;
DROP TABLE  "csv_bl"."Northwind"."regions" ;
DROP TABLE  "csv_bl"."Northwind"."shippers" ;

-- Clear DB.DBA.csv_load_list Table

-- DELETE FROM DB.DBA.csv_load_list WHERE cl_table LIKE '%csv_bl.Northwind%' ;

DELETE FROM DB.DBA.csv_load_list ;

SELECT * FROM DB.DBA.csv_load_list WHERE cl_table LIKE '%csv_bl.Northwind%' ;

-- Register CSV documents for batch loading 


CSV_REGISTER('../vad', 'categories.csv') ;
CSV_REGISTER('../vad', 'customers.csv') ;
CSV_REGISTER('../vad', 'employees.csv') ;
CSV_REGISTER('../vad', 'employee_territories.csv') ;
CSV_REGISTER('../vad', 'order_details.csv') ;
CSV_REGISTER('../vad', 'orders.csv') ;
CSV_REGISTER('../vad', 'products.csv') ;
CSV_REGISTER('../vad', 'regions.csv') ;
CSV_REGISTER('../vad', 'shippers.csv') ;
CSV_REGISTER('../vad', 'suppliers.csv') ;
CSV_REGISTER('../vad', 'territories.csv') ;

-- Check that DB.DBA.csv_load_list table contains CSV documents to loaded

SELECT * FROM "DB"."DBA"."csv_load_list" ;


-- Run CSV Bulk Loader

CSV_LOADER_RUN () ;
	

-- Check that DB.DBA.csv_load_list table show changed load stated from 2 to 0

SELECT * FROM "DB"."DBA"."csv_load_list" ;


-- Confirm Tables have been successfully created by CSV Bulk Loader

SELECT * FROM "csv_bl"."Northwind"."categories" ;
SELECT * FROM "csv_bl"."Northwind"."customers" ;
SELECT * FROM "csv_bl"."Northwind"."employees" ;
SELECT * FROM "csv_bl"."Northwind"."employee_territories" ;
SELECT * FROM "csv_bl"."Northwind"."order_details" ;
SELECT * FROM "csv_bl"."Northwind"."orders" ;
SELECT * FROM "csv_bl"."Northwind"."products" ;
SELECT * FROM "csv_bl"."Northwind"."regions" ;
SELECT * FROM "csv_bl"."Northwind"."shippers" ;
SELECT * FROM "csv_bl"."Northwind"."suppliers" ;
SELECT * FROM "csv_bl"."Northwind"."territories" ;

-- ADD Foreign Keys to each table. 
-- Works on the assumption of Northwind CSV files in ~virtuoso/vad directory (folder)  .

-- ATTACH CATEGORIES TABLE
	   
ALTER TABLE "csv_bl"."Northwind"."categories" 
      MODIFY PRIMARY KEY ("categoryID") ;
	  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."categories" ;

-- ALTER CUSTOMERS TABLE
	   
ALTER TABLE "csv_bl"."Northwind"."customers" 
      MODIFY PRIMARY KEY ("customerID") ;
	  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."customers"  ;



-- ALTER EMPLOYEES TABLE

	   
ALTER TABLE "csv_bl"."Northwind"."employees" 
      MODIFY PRIMARY KEY ("employeeID") ;
	  
ALTER TABLE "csv_bl"."Northwind"."employees"   
   ADD FOREIGN KEY ("employeeID") REFERENCES "csv_bl"."Northwind"."employees" ("employeeID") ;
		   
SELECT TOP 5 * FROM "csv_bl"."Northwind"."employees"  ;


-- ALTER EMPLOYEE TERRITORIES TABLE
	   
ALTER TABLE "csv_bl"."Northwind"."employee_territories" 
      MODIFY PRIMARY KEY ("employeeID","territoryID");
	  
ALTER TABLE "csv_bl"."Northwind"."employee_territories"   
	 ADD FOREIGN KEY ("employeeID") REFERENCES  "csv_bl"."Northwind"."employees"  ("employeeID") ;
			  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."employee_territories"  ;


-- ALTER ORDERS TABLE

	   
ALTER TABLE "csv_bl"."Northwind"."orders" 
      MODIFY PRIMARY KEY ("orderID");
 	   
ALTER TABLE "csv_bl"."Northwind"."orders"   
     ADD FOREIGN KEY ("employeeID") REFERENCES "csv_bl"."Northwind"."employees" ("employeeID") ;
	  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."orders" ;

-- ALTER SUPPLIERS TABLE
	   
ALTER TABLE "csv_bl"."Northwind"."suppliers" 
      MODIFY PRIMARY KEY ("supplierID");
	  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."suppliers" ;

-- ALTER PRODUCTS TABLE

	   
ALTER TABLE "csv_bl"."Northwind"."products" 
      MODIFY PRIMARY KEY ("productID");
	  
ALTER TABLE "csv_bl"."Northwind"."products" 
     ADD FOREIGN KEY ("supplierID") REFERENCES "csv_bl"."Northwind"."suppliers" ("supplierID") ;

ALTER TABLE "csv_bl"."Northwind"."products" 
	 ADD FOREIGN KEY ("categoryID") REFERENCES "csv_bl"."Northwind"."categories" ("categoryID") ;
	  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."products" ;


-- ALTER ORDERS_DETAILS TABLE

	   
-- ALTER TABLE "csv_bl"."Northwind"."order_details" MODIFY PRIMARY KEY ("orderID, productID");

ALTER TABLE "csv_bl"."Northwind"."order_details" 
      MODIFY PRIMARY KEY ("orderID","productID") ;
	  	   
ALTER TABLE "csv_bl"."Northwind"."order_details"   
     ADD FOREIGN KEY ("orderID") REFERENCES "csv_bl"."Northwind"."orders" ("orderID") ;
	 
ALTER TABLE "csv_bl"."Northwind"."order_details"   
  ADD FOREIGN KEY ("productID") REFERENCES "csv_bl"."Northwind"."products" ("productID") ;
	  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."order_details"  ;



-- ALTER REGIONS TABLE
	   
ALTER TABLE "csv_bl"."Northwind"."regions" 
      MODIFY PRIMARY KEY ("regionID");
	  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."regions" ;


-- ALTER SHIPPERS TABLE
	   
ALTER TABLE "csv_bl"."Northwind"."shippers" 
      MODIFY PRIMARY KEY ("shipperID");
	  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."shippers" ;


-- ALTER TERRITORIES TABLE
	   
ALTER TABLE "csv_bl"."Northwind"."territories" 
      MODIFY PRIMARY KEY ("territoryID");
	  
ALTER TABLE "csv_bl"."Northwind"."regions"   
	 ADD FOREIGN KEY ("regionID") REFERENCES "csv_bl"."Northwind"."regions" ("regionID") ;
			  
SELECT TOP 5 * FROM "csv_bl"."Northwind"."territories" ;


