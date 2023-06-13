
/******************************* Create statement for all tables *******************************/

CREATE DATABASE `openpit_mining_scm` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

Use openpit_mining_scm;

-- Create Stateement for cleaned cycle data.

CREATE TABLE `cycle_data` (
  `AT Available Time (iMine)` text,
  `Available SMU Time` text,
  `Completed Cycle Count` text,
  `Cycle Duration` text,
  `Cycle SMU Duration` text,
  `Cycle Type` text,
  `Delay Time` text,
  `Down Time` text,
  `Dumping Duration` text,
  `Cycle End Timestamp (GMT8)` text,
  `Estimated Fuel Used` text,
  `Fuel Used` text,
  `Full Travel Duration` text,
  `Idle Duration` text,
  `iMine Availability` text,
  `iMine Load FCTR Truck` text,
  `iMine Utilisation` text,
  `Loading Count` text,
  `Loading Duration` text,
  `Source Loading End Timestamp (GMT8)` text,
  `Source Loading Start Timestamp (GMT8)` text,
  `OPERATINGBURNRATE` text,
  `OPERATINGTIME (CAT)` text,
  `Payload (kg)` text,
  `Queuing Duration` text,
  `Cycle Start Timestamp (GMT8)` text,
  `TMPH` text,
  `Source Location Name` text,
  `Source Location is Active Flag` text,
  `Source Location is Source Flag` text,
  `Destination Location Name` text,
  `Destination Location is Active Flag` text,
  `Destination Location is Source Flag` text,
  `Primary Machine Name` text,
  `Primary Machine Category Name` text,
  `Primary Machine Class Name` text,
  `Secondary Machine Name` text,
  `Secondary Machine Category Name` text,
  `Secondary Machine Class Name` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create statment for delay data.

CREATE TABLE `delay_data` (
  `Delay OID` bigint DEFAULT NULL,
  `Description` text,
  `ECF Class ID` text,
  `Acknowledge Flag` text,
  `Acknowledged Flag` text,
  `Confirmed Flag` text,
  `Engine Stopped Flag` text,
  `Field Notification Required Flag` text,
  `Office Confirm Flag` text,
  `Production Reporting Only Flag` text,
  `Frequency Type` int DEFAULT NULL,
  `Shift Type` text,
  `Target Location` text,
  `Target Road` text,
  `Workorder Ref` text,
  `Delay Class Name` text,
  `Delay Class Description` text,
  `Delay Class is Active Flag` text,
  `Delay Class Category Name` text,
  `Target Machine Name` text,
  `Target Machine is Active Flag` text,
  `Target Machine Class Name` text,
  `Target Machine Class Description` text,
  `Target Machine Class is Active Flag` text,
  `Target Machine Class Category Name` text,
  `Delay Reported By Person Name` text,
  `Delay Reported By User Name` text,
  `Delay Status Description` text,
  `Delay Start Timestamp (GMT8)` text,
  `Delay Finish Timestamp (GMT8)` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create statment for cleaned loaction data. 

CREATE TABLE `location_data` (
  `Location_Id` int DEFAULT NULL,
  `Name` text,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create statment for equipment_master table. 

CREATE TABLE equipment_master AS
Select
	`Primary Machine Name`,
	`Primary Machine Class Name`,
	`Secondary Machine Name`,
	`Secondary Machine Class Name`,
	`Cycle Type`,
	`Loading Count`,
	`iMine Load FCTR Truck`,
	`AT Available Time (iMine)`,
	`Full Travel Duration`,
	`Delay Time`,
	`Down Time`,
	`Idle Duration`,
	`Loading Duration`,
	`Dumping Duration`,
	`Payload (kg)`,
	`Estimated Fuel Used`,
	`Fuel Used`,
	`OPERATINGBURNRATE`,
	`TMPH`
FROM cycle_data;

-- Create statment for equipment_type_master table.

CREATE TABLE equipment_type_master AS
SELECT
  `Cycle Type`,
  `Primary Machine Category Name`,
  `Secondary Machine Category Name`,
  `AT Available Time (iMine)`,
  `Available SMU Time`,
  `Cycle Duration`,
  `Cycle SMU Duration`,
  `Delay Time`,
  `Down Time`,
  `Completed Cycle Count`,
  `iMine Availability`L,
  `iMine Utilisation`
FROM cycle_data;

-- Create statment for location_master table. 

CREATE TABLE location_master AS
SELECT
  `Source Location Name`,
  `Destination Location Name`,
  `Queuing Duration`,
  `Cycle End Timestamp (GMT8)`,
  `Cycle Start Timestamp (GMT8)`,
  `Source Loading Start Timestamp (GMT8)`,
  `Source Loading End Timestamp (GMT8)`
FROM cycle_data;

-- Create statement for location_type_master table. 

CREATE TABLE location_type_master AS
SELECT
  `Queuing Duration`,
  `Source Location is Active Flag`,
  `Source Location is Source Flag`,
  `Destination Location is Active Flag`,
  `Destination Location is Source Flag`
FROM cycle_data;

-- Create ststamnent for movement_data table.

CREATE TABLE Movement_data AS
SELECT
    `Primary Machine Name`,
    `Primary Machine Category Name`,
    `Secondary Machine Name`,
    `Secondary Machine Category Name`,
    `Source Location Name`,
    `Destination Location Name`,
    `Payload (kg)`,
    `Cycle Start Timestamp (GMT8)`,
    `Cycle End Timestamp (GMT8)`
FROM cycle_data;

-- Create statment for OEE (Overall Equipment Efficency)

Create TABLE OEE AS
SELECT 
	`Primary Machine Name`,
    round((((`AT available time (imine)` - `idle duration`) - `down time`)/`AT available time (imine)`)*100,2) as availability,
    round(((`operatingtime (cat)` - `delay time`)/`operatingtime (cat)`)*100, 2) as performance,
    round((((`operatingtime (cat)` - `idle duration`)- `down time`)/`operatingtime (cat)`)*100,2) as quality
FROM cycle_data;

Select * from oee;

/******************************* Stored Procedures for all tables *******************************/

-- Stored Procedures for cycle_data

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cycle_data`()
BEGIN
SELECT `AT Available Time (iMine)`,
    `Cycle Type`,
    `Delay Time`,
    `Down Time`,
    `Dumping Duration`,
    `Estimated Fuel Used`,
    `Fuel Used`,
    `Full Travel Duration`,
    `Idle Duration`,
    `iMine Load FCTR Truck`,
    `Loading Count`,
    `Loading Duration`,
    `OPERATINGBURNRATE`,
    `OPERATINGTIME (CAT)`,
    `Payload (kg)`,
    `TMPH`,
    `Primary Machine Name`,
    `Primary Machine Class Name`,
    `Secondary Machine Name`,
    `Secondary Machine Class Name`,
    `Available SMU Time`,
    `Completed Cycle Count`,
    `Cycle Duration`,
    `Cycle SMU Duration`,
    `iMine Availability`,
    `iMine Utilisation`,
    `Primary Machine Category Name`,
    `Secondary Machine Category Name`,
    `Cycle End Timestamp (GMT8)`,
    `Source Loading End Timestamp (GMT8)`,
    `Source Loading Start Timestamp (GMT8)`,
    `Queuing Duration`,
    `Cycle Start Timestamp (GMT8)`,
    `Source Location Name`,
    `Destination Location Name`,
    `Source Location is Active Flag`,
    `Source Location is Source Flag`,
    `Destination Location is Active Flag`,
    `Destination Location is Source Flag`
FROM cycle_data;
END$$
DELIMITER ;

-- Stored Procedure delay data. 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delay_data`()
BEGIN
SELECT `Delay OID`,
    `Description`,
    `ECF Class ID`,
    `Acknowledge Flag`,
    `Acknowledged Flag`,
    `Confirmed Flag`,
    `Engine Stopped Flag`,
    `Field Notification Required Flag`,
    `Office Confirm Flag`,
    `Production Reporting Only Flag`,
    `Frequency Type`,
    `Shift Type`,
    `Target Location`,
    `Target Road`,
    `Workorder Ref`,
    `Delay Class Name`,
    `Delay Class Description`,
    `Delay Class is Active Flag`,
    `Delay Class Category Name`,
    `Target Machine Name`,
    `Target Machine is Active Flag`,
    `Target Machine Class Name`,
    `Target Machine Class Description`,
    `Target Machine Class is Active Flag`,
    `Target Machine Class Category Name`,
    `Delay Reported By Person Name`,
    `Delay Reported By User Name`,
    `Delay Status Description`,
    `Delay Start Timestamp (GMT8)`,
    `Delay Finish Timestamp (GMT8)`
FROM delay_data;
END$$
DELIMITER ;

-- Stored procedure for location data. 
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `location_data`()
BEGIN
SELECT `Location_Id`,
    `Name`,
    `Latitude`,
    `Longitude`
FROM location_data;
END$$
DELIMITER ;

-- Stored procedure for equipment master. 
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `equipment_master`()
BEGIN
SELECT `Primary Machine Name`,
    `Primary Machine Class Name`,
    `Secondary Machine Name`,
    `Secondary Machine Class Name`,
    `Cycle Type`,
    `Loading Count`,
    `iMine Load FCTR Truck`,
    `AT Available Time (iMine)`,
    `Full Travel Duration`,
    `Delay Time`,
    `Down Time`,
    `Idle Duration`,
    `Loading Duration`,
    `Dumping Duration`,
    `Payload (kg)`,
    `Estimated Fuel Used`,
    `Fuel Used`,
    `OPERATINGTIME (CAT)`,
    `OPERATINGBURNRATE`,
    `TMPH`
FROM equipment_master;
END$$
DELIMITER ;

-- Stored procedure for equipment_type_master. 
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `equipment_type_master`()
BEGIN
SELECT `Cycle Type`,
    `Primary Machine Category Name`,
    `Secondary Machine Category Name`,
    `AT Available Time (iMine)`,
    `Available SMU Time`,
    `Cycle Duration`,
    `Cycle SMU Duration`,
    `Delay Time`,
    `Down Time`,
    `Completed Cycle Count`,
    `iMine Availability`,
    `iMine Utilisation`
FROM equipment_type_master;
END$$
DELIMITER ;

-- Store procedure location_master. 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `location_master`()
BEGIN
SELECT `Source Location Name`,
    `Destination Location Name`,
    `Queuing Duration`,
    `Cycle End Timestamp (GMT8)`,
    `Cycle Start Timestamp (GMT8)`,
    `Source Loading Start Timestamp (GMT8)`,
    `Source Loading End Timestamp (GMT8)`
FROM location_master;
END$$
DELIMITER ;

-- Stored procedure location_type_master. 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `location_type_master`()
BEGIN
SELECT `Queuing Duration`,
    `Source Location is Active Flag`,
    `Source Location is Source Flag`,
    `Destination Location is Active Flag`,
    `Destination Location is Source Flag`
FROM location_type_master;
END$$
DELIMITER ;

-- Stored procedure for movement_data. 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `movement_data`()
BEGIN
SELECT     `Primary Machine Name`,
    `Primary Machine Category Name`,
    `Secondary Machine Name`,
    `Secondary Machine Category Name`,
    `Source Location Name`,
    `Destination Location Name`,
    `Payload (kg)`,
    `Cycle Start Timestamp (GMT8)`,
    `Cycle End Timestamp (GMT8)`
FROM movement_data;
END$$
DELIMITER ;

-- Stored procedure for oee

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OEE_procedure`()
BEGIN
SELECT
	`Primary Machine Name`,
	`availability`,
    `performance`,
    `quality`,
    (`availability`*`performance`*`quality`) as OEE_score
FROM oee;
END$$
DELIMITER ;

/******************************* Analysis on data *******************************/

SELECT COUNT(*) AS Number_of_rows
FROM cycle_data;
    
-- We can see 44712 rows are uploded from cleaned data set. 

-- Number of euipments operating in the field ---

SELECT COUNT(DISTINCT `primary machine name`) AS unique_primary_machines
FROM cycle_data;

-- unique_primary_machines: 126

-- Number of equipments under maintenance

SELECT COUNT(DISTINCT `primary machine name`) AS unique_primary_machines
FROM cycle_data
where `Down Time` > 0;

-- unique_primary_machines under maintenece 118. 

-- number of cycles completed by each machine
 
SELECT `primary machine name` AS primary_machine_name,
SUM(`completed cycle count`) AS number_of_cycles_completed
FROM cycle_data
GROUP BY primary_machine_name
ORDER BY number_of_cycles_completed DESC;

-- Top 3 primary machines with cycle count EX8044	2348, EX8047	2179, EX8049	2171

-- Production vs Plan
-- This query is a comparison of the average cycle duration with and without delays

SELECT `primary machine name` AS primary_machine_name,
SUM(`completed cycle count`) AS number_of_cycles,
AVG(`cycle duration`) AS avg_cycle_duration,
AVG((`cycle duration` - `delay time`)) AS net_avg_cycle_duration
FROM cycle_data
GROUP BY primary_machine_name
ORDER BY number_of_cycles DESC;

-- Average Payload carried by trucks

SELECT `primary machine name` AS primary_machine_name,
ROUND(AVG(`payload (kg)`), 2) AS avg_payload_carried
FROM cycle_data
GROUP BY primary_machine_name;

-- Avg down time of machines

SELECT `primary machine name` AS primary_machine_name,
ROUND(AVG(`down time`),2) AS avg_down_time
FROM cycle_data
WHERE `down time` > 0
GROUP BY primary_machine_name
ORDER BY avg_down_time DESC;

-- Avg down time by category

SELECT `primary machine category name` AS primary_machine_category,
ROUND(AVG(`down time`),2) AS avg_down_time
FROM cycle_data
WHERE `down time` > 0
GROUP BY primary_machine_category
ORDER BY avg_down_time DESC;

-- Average Cycle time by equipment

SELECT `primary machine name` AS primary_machine_name,
`primary machine category name` AS primary_machine_category,
ROUND(AVG(`cycle duration`),2) AS avg_cycle_duration
FROM cycle_data
GROUP BY primary_machine_name
ORDER BY avg_cycle_duration;

-- Average Cycle time by category

SELECT `primary machine category name` AS primary_machine_category,
ROUND(AVG(`cycle duration`), 2) AS avg_cycle_duration
FROM cycle_data
GROUP BY primary_machine_category
ORDER BY avg_cycle_duration DESC;

-- AVG payload by category

SELECT `primary machine category name` AS primary_machine_category,
ROUND(AVG(`cycle duration`), 2) AS avg_cycle_duration,
ROUND(AVG(`payload (kg)`),2) AS avg_payload
FROM cycle_data
GROUP BY primary_machine_category
ORDER BY avg_cycle_duration DESC;


-- Only truck, loader and shovel classes are carrying the payload
-- Let's explore the 3 classes

SELECT `primary machine name` AS primary_machine_name,
ROUND(AVG(`down time`), 2) AS avg_down_time,
ROUND(AVG(`payload (kg)`),2) AS avg_payload
FROM cycle_data
WHERE `primary machine category name` = 'Truck Classes'
GROUP BY primary_machine_name
ORDER BY avg_down_time DESC;

-- We've identified the machines with the highest and lowest downtimes


-- exploring the cycle types
SELECT `cycle type` as cycle_type,
COUNT(`cycle type`) as cycle_type_count
FROM cycle_data
GROUP BY cycle_type;

-- TruckCycle: 20711 | LoaderCycle 21539 | AuxMobileCycle 2462

SELECT `cycle type` as cycle_type,
COUNT(`cycle type`) as cycle_type_count,
ROUND(AVG(`cycle duration`), 2) AS avg_cycle_duration,
ROUND(AVG(`down time`), 2) AS avg_down_time,
ROUND(AVG(`payload (kg)`),2) AS avg_payload
FROM cycle_data
GROUP BY cycle_type;

-- Loader cycle takes much lesser time than truck cycle

SELECT `primary machine name` AS primary_machine_name,
ROUND(AVG(`cycle duration`), 2) AS avg_cycle_duration,
ROUND(AVG(`down time`), 2) AS avg_down_time,
ROUND(AVG(`payload (kg)`), 2) AS avg_payload
FROM cycle_data
WHERE `cycle type` = 'TruckCycle'
GROUP BY primary_machine_name
ORDER BY avg_down_time DESC;

-- Truck cycle machines are prefixed with DT

-- exploring cycle duration, downtime and payload of loader cycle

SELECT `primary machine name` AS primary_machine_name,
`primary machine category name` AS primary_machine_category,
ROUND(AVG(`cycle duration`), 2) AS avg_cycle_duration,
ROUND(AVG(`down time`), 2) AS avg_down_time,
ROUND(AVG(`payload (kg)`), 2) AS avg_payload
FROM cycle_data
WHERE `cycle type` = 'LoaderCycle'
GROUP BY primary_machine_name
ORDER BY avg_down_time DESC;

-- Loadercycle machines are prefixed with either EX or WL

-- explore loading and dumping

SELECT `primary machine name` AS primary_machine_name,
`primary machine category name` AS primary_machine_category,
ROUND(AVG(`loading duration`), 2) AS loading_duration,
ROUND(AVG(`down time`), 2) AS avg_down_time,
ROUND(AVG(`payload (kg)`), 2) AS avg_payload
FROM cycle_data
WHERE `Cycle Type` = 'LoaderCycle'
GROUP BY primary_machine_name
ORDER BY loading_duration ASC;


-- dumping

SELECT `primary machine name` AS primary_machine_name,
`primary machine category name` AS primary_machine_category,
ROUND(AVG(`dumping duration`), 2) AS dumping_duration,
ROUND(AVG(`down time`), 2) AS avg_down_time,
ROUND(AVG(`payload (kg)`), 2) AS avg_payload
FROM cycle_data
WHERE `Cycle Type` = 'TruckCycle'
GROUP BY primary_machine_name
ORDER BY dumping_duration DESC;

-- Checking OEE Score.

Select	`Primary Machine Name` as primary_machine_name,
round(availability * performance * quality, 3) AS OEE
FROM oee
GROUP BY primary_machine_name
ORDER BY OEE DESC;

-- individual factors of OEE
SELECT `Primary Machine Name` as primary_machine_name,
availability,
performance,
quality
FROM oee
GROUP BY primary_machine_name;

-- Loading

SELECT ROUND(AVG(`loading duration`), 2) AS loading_duration
FROM cycle_data
WHERE `Primary machine category name` IN ('Loader Classes','Truck Classes', 'Shovel Classes');

-- Loader, Truck and Shovel classes are the only classes to have a loading time. On an average it itakes 183 seconds

-- dumping duratons

SELECT ROUND(AVG(`dumping duration`), 2) AS loading_duration
FROM cycle_data
WHERE `Primary machine category name` LIKE 'Truck Classes';

-- Average dumping duration is 45 second

-- Travelling durations

SELECT `primary machine name` AS primary_machine_name,
`primary machine category name` AS primary_machine_category,
ROUND(AVG(`full travel duration`), 2) AS full_travel_duration
FROM cycle_data
GROUP BY primary_machine_name
ORDER BY full_travel_duration DESC;

-- only the truck classes travel

-- totaly cycle durations

SELECT `primary machine name` AS primary_machine_name,
SUM(`Cycle Duration`) AS cycle_duration
FROM cycle_data
GROUP BY primary_machine_name;

-- payload per cycle

SELECT ROUND(SUM(`payload (kg)`) / SUM(`completed cycle count`),1) AS payload_per_cycle
FROM cycle_data;
    
-- On every cycle completion, 229 tonnes of payload is being transported

SELECT ROUND(SUM(`payload (kg)`) / SUM(`completed cycle count`),1) AS payload_per_cycle,
ROUND(SUM(`cycle duration`) / SUM(`completed cycle count`),1) AS cycle_time_per_cycle,
ROUND((SUM(`cycle duration`) - SUM(`delay time`)) / SUM(`completed cycle count`),1) AS cycle_time_without_delay
FROM cycle_data;

-- performance of equipments

SELECT `Primary Machine category Name` as primary_machine_category,
ROUND(AVG((`operatingtime (cat)` - `delay time`)/`operatingtime (cat)`)*100,2) as performance_percentage,
ROUND(AVG(`delay time`), 2) AS avg_delay_time
FROM cycle_data
GROUP BY primary_machine_category
ORDER BY performance_percentage DESC;

-- exploring source locations

SELECT count(DISTINCT `source location name`) 
FROM cycle_data;

-- 30 source locations

-- avg loading durations of each source

SELECT `source location name` AS source_location,
ROUND(AVG(`loading duration`),2) AS loading_duration
FROM cycle_data
GROUP BY source_location
ORDER BY loading_duration DESC;

-- exploring destination durations

SELECT DISTINCT count(distinct `destination location name`)
FROM cycle_data;

-- 69 destination locations












