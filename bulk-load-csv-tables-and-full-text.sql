-- Cleanup

DROP TABLE csv.demo.companies ;
DROP TABLE csv.demo.investments ;
DROP TABLE csv.demo.investors ;
DROP TABLE csv.demo.articles ;

DELETE FROM DB.DBA.csv_load_list ;

-- Register CSVs located in a directory relative to ~virtuoso/database or $VIRTUOSO/database 

CSV_REGISTER ('../vad', 'companies.csv') ;
CSV_REGISTER ('../vad', 'investments.csv') ;
CSV_REGISTER ('../vad', 'investors.csv') ;
CSV_REGISTER ('../vad', 'articles.csv') ;

-- Verify Regisration 

SELECT * FROM  DB.DBA.csv_load_list ;

-- Load Data 

CSV_LOADER_RUN () ;

-- Confirm Data Load

SELECT TOP 10 * FROM csv.demo.companies ;
SELECT TOP 10 * FROM csv.demo.investments ;
SELECT TOP 10 * FROM csv.demo.investors ;
SELECT TOP 10 * FROM csv.demo.articles ;

-- Full Text Indexing on "csv"."demo"."investors"

CREATE TEXT INDEX ON "csv"."demo"."investors" (overview) ;

SELECT COUNT (*) 
FROM "csv"."demo"."investors" 
WHERE CONTAINS (overview, '"venture capital"')  ;

SELECT blog_url 
FROM "csv"."demo"."investors" 
WHERE CONTAINS (overview, '"venture capital"') AND 
	  blog_url IS NOT NULL  ;

SELECT blog_url, blog_feed_url
FROM "csv"."demo"."investors"
WHERE CONTAINS (overview, '"venture capital"') AND
      blog_url AND blog_feed_url IS NOT NULL ;

-- Full Text Indexing on "csv"."demo"."articles

CREATE TEXT INDEX ON "csv"."demo"."articles" (snippet) ;


SELECT COUNT (*) 
FROM "csv"."demo"."articles" 
WHERE CONTAINS (title, '"Apple"')  ;

SELECT COUNT (*) 
FROM "csv"."demo"."articles" 
WHERE CONTAINS (snippet, '"Apple"')  ;

SELECT COUNT (*) 
FROM "csv"."demo"."articles" 
WHERE CONTAINS (title, '"Apple" OR "Samsung"')  ;

SELECT snippet 
FROM "csv"."demo"."articles" 
WHERE CONTAINS (snippet, '"Apple"') AND 
  snippet IS NOT NULL  ;
  
SELECT COUNT (*) 
FROM "csv"."demo"."articles" 
WHERE CONTAINS (snippet, '"Apple" and "Samsung"') AND 
snippet IS NOT NULL  ;
  
SELECT url, title, snippet
FROM "csv"."demo"."articles" 
WHERE CONTAINS (snippet, '"Apple" and "Samsung"') AND 
snippet IS NOT NULL  ;
  
SELECT url, title, snippet
FROM "csv"."demo"."articles" 
WHERE CONTAINS (snippet, '"Apple" and "Samsung" and "Cisco"') AND 
snippet IS NOT NULL  ;

SELECT url, title, snippet
FROM "csv"."demo"."articles" 
WHERE CONTAINS (title, '"Apple" OR "Samsung"') AND 
     snippet IS NOT NULL  ;


