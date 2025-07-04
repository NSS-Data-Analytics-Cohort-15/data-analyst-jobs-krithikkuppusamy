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
SELECT COUNT(*) AS postings_TN
FROM data_analyst_jobs
WHERE location ='TN';
--ANS 21

SELECT COUNT(*) AS postings_TN_KY
FROM data_analyst_jobs
WHERE location IN ('TN','KY');
--ANS 27

SELECT location,COUNT(*)
FROM data_analyst_jobs
GROUP BY location
HAVING location IN ('TN','KY');
--ANS tn 21
--    ky 6

--4.	How many postings in Tennessee have a star rating above 4?

SELECT COUNT(*) AS above_4star_rating
FROM data_analyst_jobs
WHERE location='TN'
AND star_rating>4;
--ANS 3

5.	How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
--ANS 151

--6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state ,AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating;

--7.	Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;
--ANS 881

--8.	How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location='CA';
--ANS 230

--9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company,AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL AND review_count>5000
GROUP BY company
ORDER BY avg_rating;

--ANS 40

--10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT company,ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL AND review_count>5000
GROUP BY company
ORDER BY avg_rating DESC;
--ANS Unilever 4.20

--11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';
--ANS 774

--12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT title, COUNT(DISTINCT title)
FROM data_analyst_jobs
GROUP BY title
HAVING title NOT ILIKE '%analyst%'
AND  title NOT ILIKE '%analytics%';
--ANS 4 ,Tableau

--*BONUS:**
--You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 

SELECT domain,COUNT(*) AS number_of_jobs
FROM data_analyst_jobs
WHERE skill='SQL' AND days_since_posting>21 
GROUP BY domain;

--Disregard any postings where the domain is NULL. 
SELECT domain,COUNT(*) AS number_of_jobs
FROM data_analyst_jobs
WHERE skill='SQL' AND days_since_posting>21 
GROUP BY domain
HAVING domain IS NOT NULL;

 
--Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top.
SELECT domain,COUNT(*) AS number_of_jobs
FROM data_analyst_jobs
WHERE skill='SQL' AND days_since_posting>21 
GROUP BY domain
HAVING domain IS NOT NULL
ORDER BY  number_of_jobs DESC;

 -- Which three industries are in the top 3 on this list? How many jobs have been listed for more than 3 weeks for each of the top 3?

 SELECT domain,COUNT(*) AS number_of_jobs
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%' AND days_since_posting>21 
GROUP BY domain
HAVING domain IS NOT NULL
ORDER BY  number_of_jobs DESC
LIMIT 3;

