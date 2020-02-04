-- Table/Relation Creation 

DROP TABLE demo.foaf.knows ;

CREATE TABLE demo.foaf.knows (subject VARCHAR, object VARCHAR, PRIMARY KEY (subject, object))
ALTER INDEX foaf_knows_idx ON demo.foaf.knows PARTITION (subject VARCHAR);
CREATE INDEX foaf_knows_idx2 ON demo.foaf.knows (object, subject) PARTITION (object VARCHAR);

-- SPARQL Relation Eequivalents 
-- <urn:a> foaf:knows <urn:b> , <urn:c>, <urn:d>, <urn:e>, <urn:f>, <urn:m>, <urn:g> .
INSERT INTO demo.foaf.knows VALUES ('a', 'b');
INSERT INTO demo.foaf.knows VALUES ('a', 'c');
INSERT INTO demo.foaf.knows VALUES ('a', 'd');
INSERT INTO demo.foaf.knows VALUES ('a', 'e');
INSERT INTO demo.foaf.knows VALUES ('a', 'f');
INSERT INTO demo.foaf.knows VALUES ('a', 'm');
INSERT INTO demo.foaf.knows VALUES ('a', 'g');

-- SPARQL Relation Eequivalents 
-- <urn:b> foaf:knows	<urn:a> , <urn:c> .
INSERT INTO demo.foaf.knows VALUES ('b', 'a');
INSERT INTO demo.foaf.knows VALUES ('b', 'c');

-- SPARQL Relation Eequivalents 
-- <urn:c> foaf:knows <urn:a> , <urn:b>, <urn:i>, <urn:l> .
INSERT INTO demo.foaf.knows VALUES ('c', 'a');
INSERT INTO demo.foaf.knows VALUES ('c', 'b');
INSERT INTO demo.foaf.knows VALUES ('c', 'i');
INSERT INTO demo.foaf.knows VALUES ('c', 'l');

-- SPARQL Relation Eequivalents 
-- <urn:d> foaf:knows	<urn:a> , <urn:k> .
INSERT INTO demo.foaf.knows VALUES ('d', 'a');
INSERT INTO demo.foaf.knows VALUES ('d', 'k');

-- SPARQL Relation Eequivalents 
--  <urn:e> foaf:knows	<urn:a> , <urn:m> .
INSERT INTO demo.foaf.knows VALUES ('e', 'a');
INSERT INTO demo.foaf.knows VALUES ('e', 'm');

-- SPARQL Relation Eequivalents 
-- <urn:f> foaf:knows	<urn:a> , <urn:i> .
INSERT INTO demo.foaf.knows VALUES ('f', 'a');
INSERT INTO demo.foaf.knows VALUES ('f', 'i');

-- SPARQL Relation Eequivalents 
-- <urn:m> foaf:knows	<urn:a> , <urn:e> , <urn:g> .
INSERT INTO demo.foaf.knows VALUES ('m', 'a');
INSERT INTO demo.foaf.knows VALUES ('m', 'e');
INSERT INTO demo.foaf.knows VALUES ('m', 'g');

-- SPARQL Relation Eequivalents 
-- <urn:g> foaf:knows	<urn:a> , <urn:m> , <urn:k> , <urn:h> , <urn:j> .
INSERT INTO demo.foaf.knows VALUES ('g', 'a');
INSERT INTO demo.foaf.knows VALUES ('g', 'm');
INSERT INTO demo.foaf.knows VALUES ('g', 'k');
INSERT INTO demo.foaf.knows VALUES ('g', 'h');
INSERT INTO demo.foaf.knows VALUES ('g', 'j');

-- SPARQL Relation Eequivalents 
-- <urn:i> foaf:knows	<urn:c> , <urn:f> .
INSERT INTO demo.foaf.knows VALUES ('i', 'c');
INSERT INTO demo.foaf.knows VALUES ('i', 'f');

-- SPARQL Relation Eequivalents 
-- <urn:l> foaf:knows	<urn:c> .
INSERT INTO demo.foaf.knows VALUES ('l', 'c');

-- SPARQL Relation Eequivalents 
-- <urn:k> foaf:knows	<urn:d> , <urn:g> .
INSERT INTO demo.foaf.knows VALUES ('k', 'd');
INSERT INTO demo.foaf.knows VALUES ('k', 'g');

-- SPARQL Relation Eequivalents 
-- <urn:h> foaf:knows	<urn:g> .
INSERT INTO demo.foaf.knows VALUES ('h', 'g');

-- SPARQL Relation Eequivalents 
-- <urn:j> foaf:knows	<urn:g> .
INSERT INTO demo.foaf.knows VALUES ('j', 'g');

-- Centrality
SELECT subject, count(*) 
FROM demo.foaf.knows 
GROUP BY subject ORDER BY 2 DESC ;

-- Degree Centrality 
SELECT count(*) AS cnt
FROM ( 
        SELECT TRANSITIVE T_DISTINCT 
              T_IN (1) T_OUT (2) T_MIN (1) 
              subject , 
              object 
        FROM demo.foaf.knows 
     ) AS k  
WHERE k.subject = 'a' ;

-- Closeness Centrality
SELECT subject, object, sum(step) AS steps
FROM ( 
        SELECT TRANSITIVE T_DISTINCT 
               T_IN (1) T_OUT (2) T_MIN (1)  
               subject, 
               object , 
               T_STEP ('step_no') AS step 
        FROM demo.foaf.knows 
     ) AS k 
WHERE k.subject = 'a' 
GROUP BY subject, object ;

-- Betweeness Centrality
SELECT A.object AS via, COUNT (1) AS cnt
FROM (
        SELECT TRANSITIVE T_DISTINCT  T_MIN(1) 
               T_OUT(2) T_IN(1)
               subject,
               object, 
               T_STEP( 'step_no' ) AS dist_to_via
          FROM demo.foaf.knows
      ) AS A
INNER JOIN (
              SELECT  TRANSITIVE T_DISTINCT T_SHORTEST_ONLY T_MIN(1)
                      T_OUT(2) T_IN(1)  
                      subject,
                      object, 
                      T_STEP( 'step_no' ) AS dist_from_via
              FROM demo.foaf.knows
            ) AS B
ON (A.object = B.subject)
WHERE A.subject =  'a'
GROUP BY A.object
ORDER BY 2 DESC ;

-- Betweeness Centrality using Shortest Path
SELECT A.subject, A.dist_to_via, A.object AS via,  B.object
FROM (
        SELECT TRANSITIVE T_DISTINCT  T_MIN(1) 
               T_OUT(2) T_IN(1)
               subject,
               object, 
               T_STEP( 'step_no' ) AS dist_to_via
          FROM demo.foaf.knows
      ) AS A
INNER JOIN (
              SELECT  TRANSITIVE T_DISTINCT T_SHORTEST_ONLY T_MIN(1)
                      T_OUT(2) T_IN(1)  
                      subject,
                      object, 
                      T_STEP( 'step_no' ) AS dist_from_via
              FROM demo.foaf.knows
            ) AS B
ON (A.object = B.subject)
WHERE A.subject =  'a'
AND B.object <> 'a'
-- 	GROUP BY A.subject, A.dist_to_via, A.object, B.object
ORDER BY 3 DESC   ;

-- Betweeness Centrality without Shortest Path
SELECT subject, object, step AS steps, path
FROM ( 
        SELECT TRANSITIVE T_DISTINCT 
               T_IN (1) T_OUT (2) T_MIN (1)  
               subject, 
               object , 
               T_STEP ('step_no') AS step,
               T_STEP ('path_id') AS path
        FROM demo.foaf.knows 
     ) AS k 
WHERE k.subject = 'c' AND k.object = 'j'
-- GROUP BY subject, object ;
ORDER BY steps DESC  ;



