--1.	How many rows are in the data_analyst_jobs table?
SELECT * 
FROM data_analyst_jobs;
--ANS 1793

--2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT * 
FROM data_analyst_jobs
LIMIT 10;
--ANS ExxonMobil

--3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(location) AS postings_TN
FROM data_analyst_jobs
WHERE location ='TN';
--ANS 21

SELECT COUNT(location) AS postings_TN_KY
FROM data_analyst_jobs
WHERE location IN ('TN','KY');
--ANS 27

SELECT location,COUNT(location)
FROM data_analyst_jobs
GROUP BY location
HAVING location IN ('TN','KY');


