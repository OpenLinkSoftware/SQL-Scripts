--
--
--  $Id: schools_db.sql
--
--  RDF Mappings
--
--  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
--  project.
--
--  Copyright (C) 1998-2019 OpenLink Software
--
--  This project is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; only version 2 of the License, dated June 1991.
--
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
--  General Public License for more details.
--
--  You should have received a copy of the GNU General Public License along
--  with this program; if not, write to the Free Software Foundation, Inc.,
--  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
--
--

-- DROP Tables
drop table School.DBA.OnsiteCourse;
drop table School.DBA.OnlineCourse;
drop table School.DBA.CourseGrade;
drop table School.DBA.CourseInstructor;
drop table School.DBA.OfficeAssignment;
drop table School.DBA.Course;
drop table School.DBA.Department;
drop table School.DBA.Person;

-- CREATE Tables 

USE School;

CREATE TABLE "Department"(
"DepartmentID" int NOT NULL,
"Name" nvarchar(50) NOT NULL,
"Budget" decimal NOT NULL,
"StartDate" datetime NOT NULL,
"Administrator" int NULL,
CONSTRAINT "PK_Department" PRIMARY KEY
(
"DepartmentID" ASC
));

CREATE TABLE "Person"(
"PersonID" int NOT NULL,
"LastName" nvarchar(50) NOT NULL,
"FirstName" nvarchar(50) NOT NULL,
"HireDate" datetime NULL,
"EnrollmentDate" datetime NULL,
CONSTRAINT "PK_School.Student" PRIMARY KEY
(
"PersonID" ASC
));

CREATE TABLE "OnsiteCourse"(
"CourseID" int NOT NULL,
"Location" nvarchar(50) NOT NULL,
"Days" nvarchar(50) NOT NULL,
"Time" time NOT NULL,
CONSTRAINT "PK_OnsiteCourse" PRIMARY KEY
(
"CourseID" ASC
));

CREATE TABLE "OnlineCourse"(
"CourseID" int NOT NULL,
"URL" nvarchar(100) NOT NULL,
CONSTRAINT "PK_OnlineCourse" PRIMARY KEY
(
"CourseID" ASC
));

CREATE TABLE "CourseGrade"(
"EnrollmentID" int IDENTITY,
"CourseID" int NOT NULL,
"StudentID" int NOT NULL,
"Grade" decimal(3, 2) NULL,
CONSTRAINT "PK_CourseGrade" PRIMARY KEY
(
"EnrollmentID" ASC
));

CREATE TABLE "CourseInstructor"(
"CourseID" int NOT NULL,
"PersonID" int NOT NULL,
CONSTRAINT "PK_CourseInstructor" PRIMARY KEY
(
"CourseID" ASC,
"PersonID" ASC
));

CREATE TABLE "Course"(
"CourseID" int NOT NULL,
"Title" nvarchar(100) NOT NULL,
"Credits" int NOT NULL,
"DepartmentID" int NOT NULL,
CONSTRAINT "PK_School.Course" PRIMARY KEY
(
"CourseID" ASC
));

CREATE TABLE "OfficeAssignment"(
"InstructorID" int NOT NULL,
"Location" nvarchar(50) NOT NULL,
"Timestamp" timestamp NOT NULL,
CONSTRAINT "PK_OfficeAssignment" PRIMARY KEY
(
"InstructorID" ASC
));

ALTER TABLE "OnsiteCourse" ADD
FOREIGN KEY("CourseID")
REFERENCES "Course" ("CourseID");

ALTER TABLE "OnlineCourse" ADD
FOREIGN KEY("CourseID")
REFERENCES "Course" ("CourseID");

ALTER TABLE "CourseGrade" ADD
FOREIGN KEY("CourseID")
REFERENCES "Course" ("CourseID");

ALTER TABLE "CourseGrade" ADD
FOREIGN KEY("StudentID")
REFERENCES "Person" ("PersonID");

ALTER TABLE "CourseInstructor" ADD
FOREIGN KEY("CourseID")
REFERENCES "Course" ("CourseID");

ALTER TABLE "CourseInstructor" ADD
FOREIGN KEY("PersonID")
REFERENCES "Person" ("PersonID");

ALTER TABLE "Course" ADD
FOREIGN KEY("DepartmentID")
REFERENCES "Department" ("DepartmentID");

ALTER TABLE "OfficeAssignment" ADD
FOREIGN KEY("InstructorID")
REFERENCES "Person" ("PersonID");

-- INSERT Data 

INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (1, 'Abercrombie', 'Kim', '1995-03-11', null);
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (2, 'Barzdukas', 'Gytis', null, '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (3, 'Justice', 'Peggy', null, '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (4, 'Fakhouri', 'Fadi', '2002-08-06', null);
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (5, 'Harui', 'Roger', '1998-07-01', null);
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (6, 'Li', 'Yan', null, '2002-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (7, 'Norman', 'Laura', null, '2003-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (8, 'Olivotto', 'Nino', null, '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (9, 'Tang', 'Wayne', null, '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (10, 'Alonso', 'Meredith', null, '2002-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (11, 'Lopez', 'Sophia', null, '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (12, 'Browning', 'Meredith', null, '2000-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (13, 'Anand', 'Arturo', null, '2003-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (14, 'Walker', 'Alexandra', null, '2000-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (15, 'Powell', 'Carson', null, '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (16, 'Jai', 'Damien', null, '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (17, 'Carlson', 'Robyn', null, '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (18, 'Zheng', 'Roger', '2004-02-12', null);
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (19, 'Bryant', 'Carson', null, '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (20, 'Suarez', 'Robyn', null, '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (21, 'Holt', 'Roger', null, '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (22, 'Alexander', 'Carson', null, '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (23, 'Morgan', 'Isaiah', null, '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (24, 'Martin', 'Randall', null, '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (25, 'Kapoor', 'Candace', '2001-01-15', null);
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (26, 'Rogers', 'Cody', null, '2002-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (27, 'Serrano', 'Stacy', '1999-06-01', null);
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (28, 'White', 'Anthony', null, '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (29, 'Griffin', 'Rachel', null, '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (30, 'Shan', 'Alicia', null, '2003-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (31, 'Stewart', 'Jasmine', '1997-10-12', null);
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (32, 'Xu', 'Kristen', '2001-7-23', null);
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (33, 'Gao', 'Erica', null, '2003-01-30');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate)
VALUES (34, 'Van Houten', 'Roger', '2000-12-07', null);

INSERT INTO Department (DepartmentID, "Name", Budget, StartDate, Administrator)
VALUES (1, 'Engineering', 350000.00, '2007-09-01', 2);
INSERT INTO Department (DepartmentID, "Name", Budget, StartDate, Administrator)
VALUES (2, 'English', 120000.00, '2007-09-01', 6);
INSERT INTO Department (DepartmentID, "Name", Budget, StartDate, Administrator)
VALUES (4, 'Economics', 200000.00, '2007-09-01', 4);
INSERT INTO Department (DepartmentID, "Name", Budget, StartDate, Administrator)
VALUES (7, 'Mathematics', 250000.00, '2007-09-01', 3);


INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (1050, 'Chemistry', 4, 1);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (1061, 'Physics', 4, 1);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (1045, 'Calculus', 4, 7);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (2030, 'Poetry', 2, 2);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (2021, 'Composition', 3, 2);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (2042, 'Literature', 4, 2);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (4022, 'Microeconomics', 3, 4);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (4041, 'Macroeconomics', 3, 4);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (4061, 'Quantitative', 2, 4);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (3141, 'Trigonometry', 4, 7);

INSERT INTO OnlineCourse (CourseID, URL)
VALUES (2030, 'http://www.fineartschool.net/Poetry');
INSERT INTO OnlineCourse (CourseID, URL)
VALUES (2021, 'http://www.fineartschool.net/Composition');
INSERT INTO OnlineCourse (CourseID, URL)
VALUES (4041, 'http://www.fineartschool.net/Macroeconomics');
INSERT INTO OnlineCourse (CourseID, URL)
VALUES (3141, 'http://www.fineartschool.net/Tri;nometry');

INSERT INTO OnsiteCourse (CourseID, Location, Days, "Time")
VALUES (1050, '123 Smith', 'MTWH', '11:30');
INSERT INTO OnsiteCourse (CourseID, Location, Days, "Time")
VALUES (1061, '234 Smith', 'TWHF', '13:15');
INSERT INTO OnsiteCourse (CourseID, Location, Days, "Time")
VALUES (1045, '121 Smith','MWHF', '15:30');
INSERT INTO OnsiteCourse (CourseID, Location, Days, "Time")
VALUES (4061, '22 Williams', 'TH', '11:15');
INSERT INTO OnsiteCourse (CourseID, Location, Days, "Time")
VALUES (2042, '225 Adams', 'MTWH', '11:00');
INSERT INTO OnsiteCourse (CourseID, Location, Days, "Time")
VALUES (4022, '23 Williams', 'MWF', '9:00');

INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (1050, 1);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (1061, 31);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (1045, 5);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (2030, 4);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (2021, 27);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (2042, 25);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (4022, 18);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (4041, 32);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (4061, 34);

INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (1, '17 Smith');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (4, '29 Adams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (5, '37 Williams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (18, '143 Smith');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (25, '57 Adams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (27, '271 Williams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (31, '131 Smith');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (32, '203 Williams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (34, '213 Smith');

INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2021, 2, 4);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2030, 2, 3.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2021, 3, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2030, 3, 4);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2021, 6, 2.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2042, 6, 3.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2021, 7, 3.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2042, 7, 4);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2021, 8, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (2042, 8, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4041, 9, 3.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4041, 10, null);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4041, 11, 2.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4041, 12, null);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4061, 12, null);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4022, 14, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4022, 13, 4);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4061, 13, 4);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4041, 14, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4022, 15, 2.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4022, 16, 2);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4022, 17, null);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4022, 19, 3.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4061, 20, 4);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4061, 21, 2);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4022, 22, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4041, 22, 3.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4061, 22, 2.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (4022, 23, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1045, 23, 1.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1061, 24, 4);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1061, 25, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1050, 26, 3.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1061, 26, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1061, 27, 3);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1045, 28, 2.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1050, 28, 3.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1061, 29, 4);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1050, 30, 3.5);
INSERT INTO CourseGrade (CourseID, StudentID, Grade)
VALUES (1061, 30, 4);
