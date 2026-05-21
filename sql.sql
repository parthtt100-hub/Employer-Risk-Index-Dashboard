create database Employer_Risk_Index;

use Employer_Risk_Index;

select * from data ;

SELECT 
    COUNT(*) AS total_jobs,
    SUM(fraudulent) AS fake_jobs,
    ROUND(SUM(fraudulent)*100/COUNT(*),2) AS fake_percentage
FROM data ;

SELECT employment_type,
       COUNT(*) total_jobs,
       SUM(fraudulent) fake_jobs
FROM data 
GROUP BY employment_type
ORDER BY fake_jobs DESC;

SELECT telecommuting,
       COUNT(*) total_jobs,
       SUM(fraudulent) fake_jobs
FROM data 
GROUP BY telecommuting;

SELECT required_education,
       COUNT(*) total_jobs,
       SUM(fraudulent) fake_jobs
FROM data
GROUP BY required_education
ORDER BY fake_jobs DESC;

SELECT industry,
       COUNT(*) total_jobs,
       SUM(fraudulent) fake_jobs
FROM data 
GROUP BY industry
ORDER BY fake_jobs DESC
LIMIT 10;

SELECT required_experience,
       COUNT(*) total_jobs,
       SUM(fraudulent) fake_jobs
FROM data 
GROUP BY required_experience
ORDER BY fake_jobs DESC;

SELECT location,
COUNT(*) total_jobs,
SUM(fraudulent) fake_jobs,
ROUND(SUM(fraudulent)*100/COUNT(*),2) AS fake_percentage
FROM data
GROUP BY location
HAVING total_jobs > 50
ORDER BY fake_percentage DESC
LIMIT 10;


SELECT telecommuting,
COUNT(*) total_jobs,
SUM(fraudulent) fake_jobs,
ROUND(SUM(fraudulent)*100/COUNT(*),2) AS fake_percentage
FROM data
GROUP BY telecommuting;

SELECT 
CASE 
WHEN salary_range IS NULL OR salary_range = '' 
THEN 'No Salary Mentioned'
ELSE 'Salary Mentioned'
END AS salary_status,
COUNT(*) total_jobs,
SUM(fraudulent) fake_jobs,
ROUND(SUM(fraudulent)*100/COUNT(*),2) AS fake_percentage
FROM data
GROUP BY salary_status;

SELECT has_company_logo,
COUNT(*) total_jobs,
SUM(fraudulent) fake_jobs,
ROUND(SUM(fraudulent)*100/COUNT(*),2) AS fake_percentage
FROM data
GROUP BY has_company_logo;

SELECT 
CASE 
WHEN LENGTH(description) < 500 THEN 'Short Description'
WHEN LENGTH(description) BETWEEN 500 AND 1500 THEN 'Medium Description'
ELSE 'Long Description'
END AS description_size,
COUNT(*) total_jobs,
SUM(fraudulent) fake_jobs,
ROUND(SUM(fraudulent)*100/COUNT(*),2) AS fake_percentage
FROM data
GROUP BY description_size;

SELECT 
employment_type,
required_experience,
industry,
telecommuting,
has_company_logo,
COUNT(*) total_jobs,
SUM(fraudulent) fake_jobs,
ROUND(SUM(fraudulent)*100/COUNT(*),2) AS fake_percentage
FROM data
GROUP BY employment_type, required_experience, industry, telecommuting, has_company_logo;