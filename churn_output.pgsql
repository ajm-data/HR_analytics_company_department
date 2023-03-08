-- current employee count
with current_cte AS (
SELECT 
  department,
  gender,
  COUNT(DISTINCT(employee_id)) AS current_employee_count
FROM mv_employees.current_employee_snapshot-- current employee materialized view
GROUP BY department, gender
), 
churned_cte AS (
SELECT
  department,
  gender,
  COUNT(*) AS churn_employee_count
FROM mv_employees.historic_employee_records
WHERE event_order = 1
AND expiry_date != '9999-01-01'
GROUP BY department, gender
)

SELECT 
  churn.department AS dept,
  churn.gender AS gend,
  SUM(churn_employee_count) AS this,
  SUM(current_employee_count) AS smth,
  (100 * SUM(churn_employee_count)) / SUM(current_employee_count) AS big
FROM churned_cte AS churn
LEFT JOIN current_cte AS current
  ON churn.department = current.department AND churn.gender = current.gender
GROUP BY churn.department, churn.gender;

SELECT * FROM mv_employees.current_employee_snapshot-- current employee materialized view;

-- need to get age from birth_date
SELECT * FROM mv_employees.employee
LIMIT 10;

-- AGE OF employees
Select first_name, last_name, birth_date, EXTRACT(year FROM AGE(current_date, birth_date)) AS age
from mv_employees.employee
ORDER BY age;

SELECT * 
FROM mv_employees.current_employee_snapshot;