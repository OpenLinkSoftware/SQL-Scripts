-- Create Filesystem Mapping Files to control Virtuoso Table Name preferences via the following files
-- in ~virtuoso/vad directory, downloaded and extracted from: http://bitnine.net/tutorial/import-northwind-dataset.zip

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
DROP TABLE  "csv_bl"."Northwind"."manager" ;
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

SELECT TOP 5 * FROM "DB"."DBA"."csv_load_list" ;


-- Run CSV Bulk Loader

CSV_LOADER_RUN () ;
	

-- Check that DB.DBA.csv_load_list table show changed load stated from 2 to 0

SELECT * FROM "DB"."DBA"."csv_load_list" ;

-- Make Manager Table from Query against Employees Table

CREATE TABLE "csv_bl"."Northwind"."manager"
	AS SELECT DISTINCT *
	FROM "csv_bl"."Northwind"."employees"  WHERE "reportsTo" IS NOT NULL WITH DATA ;
		
-- Confirm Tables have been successfully created by CSV Bulk Loader

SELECT TOP 5 * FROM "csv_bl"."Northwind"."categories" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."customers" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."manager" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."employees" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."employee_territories" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."order_details" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."orders" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."products" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."regions" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."shippers" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."suppliers" ;
SELECT TOP 5 * FROM "csv_bl"."Northwind"."territories" ;


	
	
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



-- MANAGERS Table 
		
ALTER TABLE "csv_bl"."Northwind"."manager"
      MODIFY PRIMARY KEY ("employeeID", "reportsTo") ;
	  

-- ALTER EMPLOYEES TABLE

	   
ALTER TABLE "csv_bl"."Northwind"."employees" 
      MODIFY PRIMARY KEY ("employeeID") ;
	  
-- ALTER TABLE "csv_bl"."Northwind"."employees"   
-- ADD FOREIGN KEY ("employeeID") REFERENCES "csv_bl"."Northwind"."employees" ("employeeID") ;

ALTER TABLE  "csv_bl"."Northwind"."employees"   
  	-- ADD FOREIGN KEY ("employeeID","reportsTo") REFERENCES "csv_bl"."Northwind"."manager" ("employeeID","reportsTo");
	ADD FOREIGN KEY ("employeeID","reportsTo") REFERENCES "csv_bl"."Northwind"."manager" ("employeeID","reportsTo");
				   
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


-- Test Queries
-- Works

SPARQL

PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT DISTINCT *
FROM <http://demo.openlinksw.com/csv_bl#> 
WHERE { 
		?s northwind:has_manager ?o .
	  }
 ;


-- Fails when storage is Virtual only

SPARQL

PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT DISTINCT *
# FROM <http://demo.openlinksw.com/csv_bl#> 
WHERE { 
		?s northwind:has_manager ?o .
	  }

;

-- Works due to existence of Physical Graphs 

SPARQL

PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT DISTINCT *
# FROM <http://demo.openlinksw.com/csv_bl#> 
# FROM <urn:demo.openlinksw.com:csv_bl>
WHERE { 
		?s northwind:has_manager ?o .
	  }
;

-- Sanity Checks

-- SQL

select DISTINCT B.employeeid, A.reportsTo
from "csv_bl"."Northwind"."employees" A
inner join "csv_bl"."Northwind"."employees" B on A.reportsTo = B.reportsTo
order by 2 desc

-- SPARQL

SPARQL

PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT DISTINCT *
# FROM <http://demo.openlinksw.com/csv_bl#> 
# FROM <urn:demo.openlinksw.com:csv_bl>
WHERE {
       ?s northwind:firstname ?name ;
          northwind:lastname ?lastName ;
          northwind:manager_of ?o. 
       ?o northwind:firstname ?mgrName ;
          northwind:lastname ?mgrlastName .
     }
	 ;
	 
-- Total Orders by Employee

SPARQL

PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT ?employee ?name sum((?quantity * ?unitprice * (1 - ?discount))) as ?orderTotalByEmp 
# FROM <urn:demo.openlinksw.com:Demo>
WHERE  
{
?employee a northwind:employees ;
           northwind:firstname ?firstname ;
           northwind:lastname ?lastname ;
BIND (concat(?firstname,' ', ?lastname) as ?name) .

?order northwind:has_employees ?employee .
?order northwind:orders_of ?order_details. 
?order_details northwind:quantity ?quantity ;
              northwind:unitprice ?unitprice ;
              northwind:discount ?discount .
}
GROUP BY ?employee ?name
ORDER BY desc(?orderTotalByEmp) 

;

-- Total Sales by Employee Product

SPARQL

PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT ?employee ?name ?productName sum((?quantity * ?unitprice * (1 - ?discount))) as ?orderTotalByEmp 
# FROM <urn:demo.openlinksw.com:Demo>
WHERE  
{
  ?employee a northwind:employees ;
              northwind:firstname ?firstname ;
              northwind:lastname ?lastname .
  BIND (concat(?firstname,' ', ?lastname) as ?name) .

  ?order northwind:has_employees ?employee .
  ?order northwind:orders_of ?order_details. 
  ?order_details northwind:quantity ?quantity ;
                 northwind:unitprice ?unitprice ;
                 northwind:discount ?discount ;
                 northwind:has_products ?product .
 ?product northwind:productname ?productName . 

}
;


-- Employees associated with Product Orders that have "Chai" in product name

SPARQL

PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT DISTINCT *
WHERE  
{
   ?employee northwind:employees_of / northwind:orders_of / northwind:has_products ?o .
   ?o northwind:productname ?name .
   ?name bif:contains "Chai" . 
} 
;

-- Employees (using Property Paths) associated with Cross Product Orders that have "Chai" in product name

SPARQL
PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT ?employee ?name count(?o2) AS ?count
WHERE  
{
   { 
   		?employee northwind:employees_of / northwind:orders_of / northwind:has_products ?o .
   	 	?o northwind:productname ?name .
   	 	?name bif:contains "Chai" . 
  }
  
  { 
  		?employee2 northwind:employees_of / northwind:orders_of / northwind:has_products ?o2 .
  	 	?o2 northwind:productname ?name2 .
                
 }
  FILTER (?employee = ?employee2)
} 
;


-- SPARQL (using BI) Employees associated with Cross Product Orders that have "Chai" in product name

SPARQL

PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT ?employee ?o+>northwind:productname AS ?productName  count(?o2+>northwind:productname) AS ?totalProductSalesCount
WHERE  
{
   { 
   		?employee+>northwind:employees_of+>northwind:orders_of northwind:has_products ?o .
   	 	?o northwind:productname ?name .
   	 	?name bif:contains "Chai" . 
  }
  
  { 
  		?employee2+>northwind:employees_of+>northwind:orders_of northwind:has_products ?o2 .
  	 	?o2 northwind:productname ?name2 .
                
 }
  FILTER (?employee = ?employee2)
} 

ORDER BY DESC 3
;


-- Employees Orders Totals using Property Paths


SPARQL


PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT DISTINCT ?employee2 ?orderid ?unitprice ?quantity ?discount ((?unitprice * ?quantity) - ?discount) as ?total 
{
  		?employee2 northwind:employees_of / northwind:orders_of / northwind:has_products ?o2 ;
                   northwind:employees_of / northwind:orders_of / northwind:unitprice ?unitprice ;
                   northwind:employees_of / northwind:orders_of / northwind:quantity ?quantity ;
                   northwind:employees_of / northwind:orders_of / northwind:discount ?discount ;
                   northwind:employees_of / northwind:orders_of / northwind:orderid ?orderid .
  	 	?o2 northwind:productname ?name2 .

} 
;


-- Employee and Cross Tab of "Chai" and other Products Ordered

SPARQL

PREFIX northwind: <http://demo.openlinksw.com/schemas/csv_bl/>

SELECT DISTINCT ?employee ?employee2 ?o ?name ?o2 ?name2 
WHERE  
{
   {
    ?employee northwind:employees_of / northwind:orders_of / northwind:has_products ?o .
    ?o northwind:productname ?name .
    ?name bif:contains "Chai" . 
   }

  {
    ?employee2 northwind:employees_of / northwind:orders_of / northwind:has_products ?o2 .
    ?o2 northwind:productname ?name2 .
    filter not exists { ?o2 northwind:productname ?name2 . ?name2 bif:contains "Chai" } . 
  }

FILTER ( ?employee = ?employee2)
} 
;
