-- How many managers are there currently in the company?

SELECT
  COUNT(*) AS current_manager_count
FROM mv_employees.title
WHERE
  to_date = '9999-01-01' AND
  title = 'Manager';
  
/*------------------------------
    9 current managers
  --------------------------------*/

  -- How many employees have ever been a manager?

SELECT
  COUNT(DISTINCT employee_id) AS total_manager_count
FROM mv_employees.title
WHERE
  title = 'Manager';

  /*------------------------------
    24 employees have held the title of 'Manager'
  --------------------------------*/

-- On average - how long did it take for an employee to first become a 
    -- manager from their the date they were originally hired in days?
  
WITH manager_cte AS (
  SELECT
    employee_id,
    MIN(from_date) AS first_appointment_date
  FROM mv_employees.title
  WHERE title = 'Manager'
  GROUP BY employee_id
)
SELECT
  AVG(
    DATE_PART(
      'DAY',
      manager_cte.first_appointment_date::TIMESTAMP -
        employee.hire_date::TIMESTAMP
    )
  ) AS average_days_till_management
FROM mv_employees.employee
INNER JOIN manager_cte
  ON employee.id = manager_cte.employee_id;

  /*------------------------------
    909 days
  --------------------------------*/

  -- What was the most common titles that managers had just 
    -- before before they became a manager?

WITH previous_title_cte AS (
  SELECT
    employee_id,
    from_date,
    title,
    LAG(title) OVER (
      PARTITION BY employee_id
      ORDER BY from_date
    ) AS previous_title
  FROM mv_employees.title
)
SELECT
  previous_title,
  COUNT(*) AS manager_count
FROM previous_title_cte
WHERE
  title = 'Manager' AND
  previous_title IS NOT NULL
GROUP BY previous_title
ORDER BY manager_count DESC;

/*------------------------------
    Senior Staff has the most with 7 employees promoted to manager
  --------------------------------*/


-- On average - how much more do current managers make on average compared 
-- to all other employees?


WITH previous_title_cte AS (
  SELECT
    employee_id,
    from_date,
    title,
    -- find previous job_title
    LAG(title) OVER (
      PARTITION BY employee_id
      ORDER BY from_date
    ) AS previous_title
  FROM mv_employees.title
)
SELECT
  COUNT(*) AS manager_count
FROM previous_title_cte
WHERE
  title = 'Manager' AND
  -- where no previous_title exists
  previous_title IS NULL;

/*------------------------------
    9 employees have been hired as managers
  --------------------------------*/

-- On average - how much more do current managers make on average compared to 
--      all other employees?

SELECT
  average_manager_salary - average_non_manager_salary AS average_difference,
  sal AS overall_avg_salary
FROM (
  SELECT
    AVG(
      CASE WHEN title = 'Manager' THEN salary
      ELSE NULL  -- DO NOT USE 0 HERE!!!!!!
      END
      ) AS average_manager_salary,
    AVG(
      CASE WHEN title != 'Manager' THEN salary
      ELSE NULL  -- DO NOT USE 0 HERE!!!!!!
      END
      ) AS average_non_manager_salary,
    AVG(salary) AS sal
  FROM mv_employees.current_employee_snapshot
) subquery;

/*---------
 $5,711 
----------*/
