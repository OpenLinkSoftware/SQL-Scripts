-- Works on the assumption of Northwind CSV files in  ~virtuoso/vad directory, downloaded and extracted from: 
-- http://bitnine.net/tutorial/import-northwind-dataset.zip


DROP TABLE  "csv"."northwind_from_attached_csv"."customers" ;
DROP TABLE  "csv"."northwind_from_attached_csv"."order_details" ;
DROP TABLE  "csv"."northwind_from_attached_csv"."orders" ;
DROP TABLE  "csv"."northwind_from_attached_csv"."products" ;
DROP TABLE  "csv"."northwind_from_attached_csv"."categories" ;
DROP TABLE  "csv"."northwind_from_attached_csv"."suppliers" ;
DROP TABLE  "csv"."northwind_from_attached_csv"."employee_territories" ;
DROP TABLE  "csv"."northwind_from_attached_csv"."territories";
DROP TABLE  "csv"."northwind_from_attached_csv"."employees" ;
DROP TABLE  "csv"."northwind_from_attached_csv"."regions" ;
DROP TABLE  "csv"."northwind_from_attached_csv"."shippers" ;



-- ATTACH CATEGORIES TABLE

ATTACH_FROM_CSV ('csv.northwind.categories', 'file:../vad/categories.csv', ',', '\n', null, 1, vector(1));

CREATE TABLE "csv"."northwind_from_attached_csv"."categories" 
       AS SELECT * FROM  "csv"."northwind"."categories" WITH DATA ;
	   
ALTER TABLE "csv"."northwind_from_attached_csv"."categories" 
      MODIFY PRIMARY KEY ("categoryID") ;
	  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."categories" ;

--ATTACH CUSTOMERS TABLE

ATTACH_FROM_CSV ('csv.northwind.customers', 'file:../vad/customers.csv', ',', '\n', null, 1, vector(1));

CREATE TABLE "csv"."northwind_from_attached_csv"."customers" 
       AS SELECT * FROM  "csv"."northwind"."customers" WITH DATA ;
	   
ALTER TABLE "csv"."northwind_from_attached_csv"."customers" 
      MODIFY PRIMARY KEY ("customerID") ;
	  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."customers"  ;


--ATTACH REGIONS TABLE

ATTACH_FROM_CSV ('csv.northwind.regions', 'file:../vad/regions.csv', ',', '\n', null, 1, vector(1));

CREATE TABLE "csv"."northwind_from_attached_csv"."regions" 
       AS SELECT * FROM  "csv"."northwind"."regions" WITH DATA ;
	   
ALTER TABLE "csv"."northwind_from_attached_csv"."regions" 
      MODIFY PRIMARY KEY ("regionID") ;
	  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."regions" ;


--ATTACH TERRITORIES TABLE

ATTACH_FROM_CSV ('csv.northwind.territories', 'file:../vad/territories.csv', ',', '\n', null, 1, vector(1,3));

CREATE TABLE "csv"."northwind_from_attached_csv"."territories" 
       AS SELECT * FROM  "csv"."northwind"."territories" WITH DATA ;
	   
ALTER TABLE "csv"."northwind_from_attached_csv"."territories" 
      MODIFY PRIMARY KEY ("territoryID","regionID") ;
	  
ALTER TABLE "csv"."northwind_from_attached_csv"."territories"    
  	  ADD FOREIGN KEY ("regionID") REFERENCES "csv"."northwind_from_attached_csv"."regions" ("regionID") ;
		  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."territories" ;


--ATTACH EMPLOYEES TABLE

ATTACH_FROM_CSV ('csv.northwind.employees', 'file:../vad/employees.csv', ',', '\n', null, 1, vector(1));

CREATE TABLE "csv"."northwind_from_attached_csv"."employees" 
       AS SELECT * FROM  "csv"."northwind"."employees" WITH DATA ;
	   
ALTER TABLE "csv"."northwind_from_attached_csv"."employees" 
      MODIFY PRIMARY KEY ("employeeID") ;

ALTER TABLE "csv"."northwind_from_attached_csv"."employees"   
 	  ADD FOREIGN KEY ("employeeID") REFERENCES "csv"."northwind_from_attached_csv"."employees" ("employeeID") ;
		 	  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."employees"   ;

-- ALTER EMPLOYEE_TERRITORIES TABLE

ATTACH_FROM_CSV ('csv.northwind.employee_territories', 'file:../vad/employee_territories.csv', ',', '\n', null, 1, vector(1,2));

CREATE TABLE "csv"."northwind_from_attached_csv"."employee_territories" 
       AS SELECT * FROM  "csv"."northwind"."employee_territories" WITH DATA ;
	   	   
ALTER TABLE "csv"."northwind_from_attached_csv"."employee_territories" 
     MODIFY PRIMARY KEY ("employeeID","territoryID");
	  
ALTER TABLE "csv"."northwind_from_attached_csv"."employee_territories"   
	 ADD FOREIGN KEY ("employeeID") REFERENCES  "csv"."northwind_from_attached_csv"."employees"  ("employeeID") ;
			  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."employee_territories"  ;



--ATTACH ORDERS TABLE

ATTACH_FROM_CSV ('csv.northwind.orders', 'file:../vad/orders.csv', ',', '\n', null, 1, vector(1));

CREATE TABLE "csv"."northwind_from_attached_csv"."orders" 
       AS SELECT * FROM  "csv"."northwind"."orders" WITH DATA ;
	   
ALTER TABLE "csv"."northwind_from_attached_csv"."orders" 
      MODIFY PRIMARY KEY ("orderID");
 	   
ALTER TABLE "csv"."northwind_from_attached_csv"."orders"   
     ADD FOREIGN KEY ("employeeID") REFERENCES "csv"."northwind_from_attached_csv"."employees" ("employeeID") ;
	  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."orders" ;

--ATTACH SUPPLIERS TABLE

ATTACH_FROM_CSV ('csv.northwind.suppliers', 'file:../vad/suppliers.csv', ',', '\n', null, 1, vector(1));

CREATE TABLE "csv"."northwind_from_attached_csv"."suppliers" 
       AS SELECT * FROM  "csv"."northwind"."suppliers" WITH DATA ;
	   
ALTER TABLE "csv"."northwind_from_attached_csv"."suppliers" 
      MODIFY PRIMARY KEY ("supplierID");
	  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."suppliers" ;

--ATTACH PRODUCTS TABLE

ATTACH_FROM_CSV ('csv.northwind.products', 'file:../vad/products.csv', ',', '\n', null, 1, vector(1));

CREATE TABLE "csv"."northwind_from_attached_csv"."products" 
       AS SELECT * FROM  "csv"."northwind"."products" WITH DATA ;
	   
ALTER TABLE "csv"."northwind_from_attached_csv"."products" 
      MODIFY PRIMARY KEY ("productID");

ALTER TABLE "csv"."northwind_from_attached_csv"."products" 
      ADD FOREIGN KEY ("supplierID") REFERENCES "csv"."northwind_from_attached_csv"."suppliers" ("supplierID") ;
	 
ALTER TABLE "csv"."northwind_from_attached_csv"."products" 
  	 ADD FOREIGN KEY ("categoryID") REFERENCES "csv"."northwind_from_attached_csv"."categories" ("categoryID") ;
				  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."products" ;


--ATTACH ORDERS_DETAILS TABLE

ATTACH_FROM_CSV ('csv.northwind.order_details', 'file:../vad/order_details.csv', ',', '\n', null, 1, vector(1,2));

CREATE TABLE "csv"."northwind_from_attached_csv"."order_details" AS SELECT * FROM  "csv"."northwind"."order_details" WITH DATA;

ALTER TABLE "csv"."northwind_from_attached_csv"."order_details" 
     MODIFY PRIMARY KEY ("orderID","productID");
 	   
ALTER TABLE "csv"."northwind_from_attached_csv"."order_details"   
     ADD FOREIGN KEY ("orderID") REFERENCES "csv"."northwind_from_attached_csv"."orders" ("orderID") ;
	 
ALTER TABLE "csv"."northwind_from_attached_csv"."order_details"   
  	ADD FOREIGN KEY ("productID") REFERENCES "csv"."northwind_from_attached_csv"."products" ("productID") ;
	  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."order_details"  ;


--ATTACH SHIPPERS TABLE

ATTACH_FROM_CSV ('csv.northwind.shippers', 'file:../vad/shippers.csv', ',', '\n', null, 1, vector(1));

CREATE TABLE "csv"."northwind_from_attached_csv"."shippers" 
       AS SELECT * FROM  "csv"."northwind"."shippers" WITH DATA ;
	   
ALTER TABLE "csv"."northwind_from_attached_csv"."shippers" 
      MODIFY PRIMARY KEY ("shipperID");
	  
SELECT TOP 5 * FROM "csv"."northwind_from_attached_csv"."shippers" ;







