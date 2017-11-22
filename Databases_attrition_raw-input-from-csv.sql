DROP DATABASE if exists Attrition;		#drop if already there

CREATE DATABASE Attrition;				#create database

USE Attrition;							#use it

DROP TABLE if exists Employees_raw;		#drop if already there

CREATE TABLE Employees_raw (			#create temporary holding table
    EmployeeID varchar(255),
    recorddate_key varchar(255),
	birthdate_key varchar(255),
    orighiredate_key varchar(255),
	terminationdate_key varchar(255),
	age int,
	length_of_service int,
	city_name varchar(255),
	department_name varchar(255),
	job_title varchar(255),
	store_name int,
	gender_short varchar(255),
	gender_full varchar(255),
	termreason_desc varchar(255),
	termtype_desc varchar(255),
	STATUS_YEAR year,
	STATUS varchar(255),
	BUSINESS_UNIT varchar(255)
);

LOAD DATA LOCAL INFILE 'C:/Users/jkras/Desktop/MFG10YearTerminationData_2.csv'	 #load in

INTO TABLE Attrition.Employees_raw		#use temporary holding table

FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'		#options

LINES TERMINATED BY '\n'		#termination of lines

IGNORE 1 ROWS;		#ignores CSV headers


CREATE TABLE Employees (		#create new table schema
    EmployeeID int,
    recorddate_key datetime,
	birthdate_key datetime,
    orighiredate_key datetime,
	terminationdate_key datetime,
	age int,
	length_of_service int,
	city_name varchar(255),
	department_name varchar(255),
	job_title varchar(255),
	store_name int,
	gender_short varchar(255),
	gender_full varchar(255),
	termreason_desc varchar(255),
	termtype_desc varchar(255),
	STATUS_YEAR year,
	STATUS varchar(255),
	BUSINESS_UNIT varchar(255)
);

INSERT INTO Employees (			#put into new table schema
	EmployeeID,
	recorddate_key, 
	birthdate_key, 
    orighiredate_key, 
    terminationdate_key, 
    age,
	length_of_service,
	city_name,
	department_name,
	job_title,
	store_name,
	gender_short,
	gender_full,
	termreason_desc,
	termtype_desc,
	STATUS_YEAR,
	STATUS,
	BUSINESS_UNIT)

SELECT EmployeeID,				#data being input to new table schema
    STR_TO_DATE(recorddate_key, '%c/%e/%Y %k:%i'),
	STR_TO_DATE(birthdate_key, '%c/%e/%Y'),
    STR_TO_DATE(orighiredate_key, '%c/%e/%Y'),
	STR_TO_DATE(terminationdate_key, '%c/%e/%Y'),
	age,
	length_of_service,
	city_name,
	department_name,
	job_title,
	store_name,
	gender_short,
	gender_full,
	termreason_desc,
	termtype_desc,
	STATUS_YEAR,
	STATUS,
	BUSINESS_UNIT FROM Employees_raw as T;
    

DROP TABLE if exists Employees_raw; 	#drop raw holding table