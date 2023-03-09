-------Column names-------
SELECT *
FROM information_schema.columns
WHERE
  table_schema = 'mv_employees'
  AND table_name = 'current_employee_snapshot';
-----------------------------------------------


-- What is the full name of the employee with the highest salary?
SELECT 
  employee_name,
  salary
FROM mv_employees.current_employee_snapshot
ORDER BY salary DESC
LIMIT 1;

      /*------------------------------
  Tokuyasu Pesch : $158220
  --------------------------------*/

-- How many current employees have the equal longest tenure years in their current title?
SELECT 
  title_tenure_years,
  COUNT(*) AS num_employees
FROM mv_employees.current_employee_snapshot
GROUP BY title_tenure_years
ORDER BY title_tenure_years DESC;


    /*------------------------------
    3505 employees have held their title for 20 years
  --------------------------------*/

--Which department has the least number of current employees?
SELECT 
  department,
  COUNT(DISTINCT employee_id) AS employees_per_department
FROM mv_employees.current_employee_snapshot
GROUP BY department
ORDER BY employees_per_department ASC;



    /*------------------------------
  Finance dept has 12,437 employees
  --------------------------------*/

-- What is the largest difference between minimimum and maximum salary values for all current employees?
SELECT 
  MAX(salary) - MIN(salary) AS largest_diff_salary
FROM mv_employees.current_employee_snapshot;



    /*------------------------------
The largest difference in salary is $119,597 among current employees
  --------------------------------*/

-- How many male employees are above the overall average salary value for the `Production` department?

WITH cte AS (
  SELECT
    gender,
    salary,
    AVG(salary) OVER () AS avg_salary
  FROM mv_employees.current_employee_snapshot
  WHERE
    department = 'Production'
)
SELECT
  SUM(
    CASE
      WHEN salary > avg_salary THEN 1
      ELSE 0
    END
  ) AS above_average_employee_count
FROM cte
WHERE gender = 'M';


    /*------------------------------
  14,999 men in 'Production' make more than average 'Production' salary
  --------------------------------*/

--  Which title has the highest average salary for male employees?

SELECT 
  title,
  AVG(salary) AS avg_salary
FROM mv_employees.current_employee_snapshot
WHERE gender = 'M'
GROUP BY title 
ORDER BY avg_salary DESC;



    /*------------------------------
Senior Staff (title) has the highest avg salary among men at $80,735
  --------------------------------*/

  -- Which department has the highest average salary for female employees?

SELECT 
  department,
  AVG(salary) AS avg_salary
FROM mv_employees.current_employee_snapshot
WHERE gender = 'F'
GROUP BY department 
ORDER BY avg_salary DESC;

    /*------------------------------
Sales department has highest average salary for Female employees $88,835
  --------------------------------*/

  -- Which department has the least amount of female employees?

SELECT 
  department,
  COUNT(*) AS count_employees
FROM mv_employees.current_employee_snapshot
WHERE gender = 'F'
GROUP BY department
ORDER BY count_employees DESC;
 
 /*------------------------------
Finance has the least female employees (5,014)
  --------------------------------*/

-- What is the gender ratio in the department which has the highest average male salary 
    -- and what is the average male salary value rounded to the nearest integer?
WITH department_cte AS (
  SELECT
    department,
    ROUND(AVG(salary)) as avg_salary
  FROM mv_employees.current_employee_snapshot
  WHERE gender = 'M'
  GROUP BY department
  ORDER BY avg_salary DESC
  LIMIT 1
)
SELECT
  gender,
  avg_salary,
  COUNT(*) AS employee_count
FROM mv_employees.current_employee_snapshot
INNER JOIN department_cte
  ON current_employee_snapshot.department = department_cte.department
GROUP BY
  gender,
  avg_salary;


    /*-----------------------------------------------------
    Female 14,999: Male 22,702 & Male avg_salary = $88,864
-------------------------------------------------------*/


-- HR wants to change the average salary increase percentage value to 2 decimal places - what should the new value be for males for the company level dashboard?
-- Action: Look at the `mv_employees.company_level_dashboard` view
SELECT
  ROUND(AVG(salary_percentage_change), 2) AS avg_salary_percentage_change
FROM mv_employees.current_employee_snapshot
WHERE gender = 'M';


/*--------------------------------------------------------------
 Updated, male average salary (rounded 2 decimal places) = 3.02
----------------------------------------------------------------*/

