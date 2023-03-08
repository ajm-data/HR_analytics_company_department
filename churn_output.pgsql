-- current employee count using .current_employee_snapshot
with current_cte AS (
SELECT 
  department,
  gender,
  COUNT(DISTINCT(employee_id)) AS current_employee_count
FROM mv_employees.current_employee_snapshot -- current employee materialized view
GROUP BY department, gender
), -- churned employee count using .historic_employee_records
churned_cte AS (
SELECT
  department,
  gender,
  COUNT(*) AS churn_employee_count
FROM mv_employees.historic_employee_records
WHERE event_order = 1 -- most recent event AND
AND expiry_date != '9999-01-01' -- that event was employee leaving the company
GROUP BY department, gender
)

-- churned_employees, total_employees, churn_rate, grouped by department and gender
SELECT 
  churn.department,
  churn.gender,
  SUM(churn_employee_count) AS total_employees_churned,
  SUM(current_employee_count) AS total_current_employees,
  (100 * SUM(churn_employee_count)) / SUM(current_employee_count) AS churn_rate
FROM churned_cte AS churn
LEFT JOIN current_cte AS current
  ON churn.department = current.department AND churn.gender = current.gender
GROUP BY churn.department, churn.gender;

SELECT * FROM mv_employees.current_employee_snapshot-- current employee materialized view;

/*
-- need to get age from birth_date
SELECT * FROM mv_employees.employee
LIMIT 10;

-- AGE OF employees
Select first_name, last_name, birth_date, EXTRACT(year FROM AGE(current_date, birth_date)) AS age
from mv_employees.employee
ORDER BY age;

SELECT * 
FROM mv_employees.current_employee_snapshot;
*/