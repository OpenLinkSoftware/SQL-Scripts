-- Clean up

 
DROP TABLE hr.demo.dependents ;

DROP TABLE hr.demo.employees ;

DROP TABLE hr.demo.jobs ;

DROP TABLE hr.demo.departments ;

DROP TABLE hr.demo.locations ;

DROP TABLE hr.demo.countries ;

DROP TABLE hr.demo.regions ;

 


-- Create new Tables/Relations

CREATE TABLE hr.demo.regions (
    region_id INT IDENTITY PRIMARY KEY,
    region_name VARCHAR (25) DEFAULT NULL
);
 
CREATE TABLE hr.demo.countries (
    country_id CHAR (2) PRIMARY KEY,
    country_name VARCHAR (40) DEFAULT NULL,
    region_id INT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES hr.demo.regions (region_id) ON  DELETE CASCADE ON  UPDATE CASCADE
);
 
CREATE TABLE hr.demo.locations (
    location_id INT IDENTITY PRIMARY KEY,
    street_address VARCHAR (40) DEFAULT NULL,
    postal_code VARCHAR (12) DEFAULT NULL,
    city VARCHAR (30) NOT NULL,
    state_province VARCHAR (25) DEFAULT NULL,
    country_id CHAR (2) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES hr.demo.countries (country_id) ON  DELETE CASCADE ON  UPDATE CASCADE
);
 
CREATE TABLE hr.demo.jobs (
    job_id INT IDENTITY PRIMARY KEY,
    job_title VARCHAR (35) NOT NULL,
    min_salary DECIMAL (8, 2) DEFAULT NULL,
    max_salary DECIMAL (8, 2) DEFAULT NULL
);
 
CREATE TABLE hr.demo.departments (
    department_id INT IDENTITY PRIMARY KEY,
    department_name VARCHAR (30) NOT NULL,
    location_id INT DEFAULT NULL,
    FOREIGN KEY (location_id) REFERENCES hr.demo.locations (location_id) ON  DELETE CASCADE ON  UPDATE CASCADE
);
 
CREATE TABLE hr.demo.employees (
    employee_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR (20) DEFAULT NULL,
    last_name VARCHAR (25) NOT NULL,
    email VARCHAR (100) NOT NULL,
    phone_number VARCHAR (20) DEFAULT NULL,
    hire_date DATE NOT NULL,
    job_id INT NOT NULL,
    salary DECIMAL (8, 2) NOT NULL,
    manager_id INT DEFAULT NULL,
    department_id INT DEFAULT NULL,
    FOREIGN KEY (job_id) REFERENCES hr.demo.jobs (job_id) ON  DELETE CASCADE ON  UPDATE CASCADE,
    FOREIGN KEY (department_id) REFERENCES hr.demo.departments (department_id) ON  DELETE CASCADE ON  UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES hr.demo.employees (employee_id)
);
 
CREATE TABLE hr.demo.dependents (
    dependent_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50) NOT NULL,
    relationship VARCHAR (25) NOT NULL,
    employee_id INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES hr.demo.employees (employee_id) ON  DELETE CASCADE ON  UPDATE CASCADE
);

-- Grants to SPARQL Role


GRANT SELECT ON  hr.demo.departments TO vdb;

GRANT SELECT ON  hr.demo.locations TO vdb;

GRANT SELECT ON  hr.demo.countries TO vdb;

GRANT SELECT ON  hr.demo.regions TO vdb;
 
GRANT SELECT ON  hr.demo.jobs TO vdb;
 
GRANT SELECT ON  hr.demo.employees TO vdb;
 
GRANT SELECT ON  hr.demo.dependents TO vdb;

-- Grants to SPARQL_SELECT Role 

GRANT SELECT ON  hr.demo.departments TO vdb ;

GRANT SELECT ON  hr.demo.locations TO vdb ;

GRANT SELECT ON  hr.demo.countries TO vdb ;

GRANT SELECT ON  hr.demo.regions TO vdb ;
 
GRANT SELECT ON  hr.demo.jobs TO vdb ;
 
GRANT SELECT ON  hr.demo.employees TO vdb ;
 
GRANT SELECT ON  hr.demo.dependents TO vdb ;