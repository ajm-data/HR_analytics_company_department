-- Query Column names for reference
SELECT *
FROM information_schema.columns
WHERE table_schema = 'mv_employees'
  AND table_name = 'historic_employee_records';

-- How many employees have left the company?
-- Action: Count every employee's most recent event that isn't at the company
SELECT
  COUNT(*) AS employees_churned
FROM
  mv_employees.historic_employee_records
WHERE
  event_order = 1
  AND expiry_date <> '9999-01-01';
  /*------------------------------
  59,910 employees left the company
  --------------------------------*/




-- What percentage of churn employees were male?
-- Action: cte and query the proportion of churned employees grouped by gender, filter for 'M' (male)
with churned_gender_cte AS (
    SELECT
      gender,
      ROUND (100 * COUNT(*)) / (SUM(COUNT(*)) OVER()) :: NUMERIC AS employees_churned
    FROM
      mv_employees.historic_employee_records
    WHERE
      event_order = 1
      AND expiry_date <> '9999-01-01'
    GROUP BY
      gender
)

SELECT *
FROM churned_gender_cte
WHERE gender = 'M';
  /*------------------------------
  60% of churned employees were male
  --------------------------------*/

-- Which job title had the most churn?
-- Action: count the number of churned employees, group by 'title' (job title)
SELECT
  title,
  COUNT(*) AS number_churned
FROM
  mv_employees.historic_employee_records
WHERE
  event_order = 1
  AND expiry_date <> '9999-01-01'
GROUP BY
  title
ORDER BY
  number_churned DESC
LIMIT
  1;
    /*------------------------------
  Engineer was the most churned title
  --------------------------------*/


-- Which department had the most churn?
-- Action: count the number of churned employees, grouped by 'department'
SELECT
  department,
  COUNT(*) AS employees_churned
FROM
  mv_employees.historic_employee_records
WHERE
  expiry_date <> '9999-01-01'
  AND event_order = 1
GROUP BY
  department
ORDER BY
  employees_churned DESC;

    /*------------------------------
  Development was the most churned department
  --------------------------------*/



-- Which year had the most churn? 2018
-- Action: count the number of churned employees, grouped by year
SELECT
  EXTRACT(YEAR FROM expiry_date) AS churn_year,
  COUNT(*) AS churn_employee_count
FROM
  mv_employees.historic_employee_records
WHERE
  event_order = 1
  AND expiry_date != '9999-01-01'
GROUP BY
  churn_year
ORDER BY
  churn_employee_count DESC;

      /*------------------------------
  2018 was the year with the most churn
  --------------------------------*/

-- What was the average salary for employees who left the company?
-- Action: return the average of salary of churned employees
SELECT 
    AVG(salary) AS average_salary
FROM 
    mv_employees.historic_employee_records
WHERE event_order = 1
  AND expiry_date != '9999-01-01';

      /*------------------------------
  $61,574 was the avg. salary of employees at time of churn
  --------------------------------*/

-- What was the median total company tenure for each churn employee just bfore they left? 12
-- Action: take the 50th percentile ordered by company tenure for churned employees
SELECT
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY company_tenure_years) AS median_company_tenure
FROM 
  mv_employees.historic_employee_records
WHERE
  event_order = 1
  AND expiry_date != '9999-01-01';

      /*------------------------------
  12 years was the median 'company_tenure' for churned employees
  --------------------------------*/
  
-- On average, how many different titles did each churn employee hold rounded to 1 decimal place? 1.203
-- Action: Long query... 

WITH churn_employees_cte AS ( -- cte churned employees to filter
  SELECT
    employee_id
  FROM mv_employees.historic_employee_records
  WHERE event_order = 1
    AND expiry_date != '9999-01-01'
),

title_count_cte AS ( -- cte count of distinct job titles where employee_id in churn_employees_cte
SELECT
  employee_id,
  COUNT(DISTINCT title) AS title_count
FROM mv_employees.historic_employee_records AS t1
WHERE EXISTS (
  SELECT 1
  FROM churn_employees_cte
  WHERE historic_employee_records.employee_id = churn_employees_cte.employee_id
)
GROUP BY employee_id
)

SELECT -- get average count of distinct job titles for churned employees
  AVG(title_count) AS average_title_count
FROM title_count_cte;

    /*------------------------------
  avg of 1.2 distinct job titles for churned employees
  --------------------------------*/

--  What was the average last pay increase for churned employees?
-- Action: cte churned_employees, avg of latest_salary_change > 0
with churned_employee_cte AS (
SELECT 
  employee_id,
  latest_salary_amount_change
FROM 
  mv_employees.historic_employee_records
WHERE
  event_order = 1
  AND expiry_date != '9999-01-01'
  AND latest_salary_amount_change > 0 -- excludes pay decreases
)
SELECT 
  AVG(latest_salary_amount_change)
FROM churned_employee_cte;

    /*------------------------------
  $2,254.44 was the avg pay increase for churned employees
  --------------------------------*/

-- What percentage of churn employees had a pay decrease event in their last 5 events?
-- Action: 
  -- need count of all churned employees -> denominator
  -- need count of all churned employees w/ pay decrease 

WITH decrease_cte AS (
  SELECT
    employee_id,
    MAX( -- returns 1 or 0 for every employee_id
      CASE WHEN event_name = 'Salary Decrease' THEN 1
      ELSE 0 END
    ) AS salary_decrease_flag
  FROM mv_employees.employee_deep_dive AS t1
  WHERE EXISTS (
    SELECT 1
    FROM mv_employees.employee_deep_dive AS t2
    WHERE t2.event_order = 1
      AND t2.expiry_date != '9999-01-01'
      AND t1.employee_id = t2.employee_id
    )
  GROUP BY employee_id
)

SELECT
  ROUND(100 * SUM(salary_decrease_flag) / COUNT(*)::NUMERIC) AS percentage_decrease
FROM decrease_cte;

    /*------------------------------
  24% of churned employees had a pay decrease
  --------------------------------*/
  
