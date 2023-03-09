# HR Analytics
Assist HR to construct datasets to answer basic reporting questions and also feed their People Analytics dashboards.

The HR team requires 2 separate analytical views to be created using a single SQL script for two separate data assets that can be used for reporting purposes.

### The following data requirements are as follows:

# [Dashboard Data Components](https://github.com/ajm-data/HR_analytics_company_department/tree/main/dashboard_data_components)


### [Company Level Insights](https://github.com/ajm-data/HR_analytics_company_department/blob/main/dashboard_data_components/company_level_insights.json)


    Total number of employees 
    Average company tenure in years
    Gender ratios
    Average payrise percentage and amount

### [Department Level Insights](https://github.com/ajm-data/HR_analytics_company_department/blob/main/dashboard_data_components/department_level_insights.json)

    Number of employees in each department
    Current department manager tenure in years
    Gender ratios
    Average payrise percentage and amount

### [Title Level Insights](https://github.com/ajm-data/HR_analytics_company_department/blob/main/dashboard_data_components/title_level_insights.json)

    Number of employees with each title
    Minimum, average, standard deviation of salaries
    Average total company tenure
    Gender ratios
    Average payrise percentage and amount

# Deep Dive Data Components

### [Current Employee Snapshot](https://github.com/ajm-data/HR_analytics_company_department/blob/main/deep_dive_data_components/current_snapshot.pgsql)
### [Historic Employee Deep Dive](https://github.com/ajm-data/HR_analytics_company_department/blob/main/deep_dive_data_components/historic_employee_records.pgsql)

    Show employment history ordered by date including salary, department, manager and title changes    
    Calculate previous historic payrise percentages and value changes
    Calculate the previous position and department history in months with start and end dates

### [Salary Benchmark Views](https://github.com/ajm-data/HR_analytics_company_department/blob/main/deep_dive_data_components/salary_benchmark_views.pgsql)
    Compare an employee’s current salary, total company tenure, department, position and gender to the average benchmarks for their current position4


# Ad-Hoc Data Analysis

### Current Employee Analysis
    
    What is the full name of the employee with the highest salary?
    How many current employees have the equal longest time in their current positions?
    Which department has the least number of current employees?
    What is the largest difference between minimimum and maximum salary values for all current employees?
    How many male employees are above the average salary value for the Production department?
    Which title has the highest average salary for male employees?
    Which department has the highest average salary for female employees?
    Which department has the most female employees?
    What is the gender ratio in the department which has the highest average male salary and what is the average male salary value for that department?
    HR Analytica want to change the average salary increase percentage value to 2 decimal places - what will the new value be for males for the company level dashboard?


### Employee Churn

    
    How many employees have left the company?
    What percentage of churn employees were male?
    Which title had the most churn?
    Which department had the most churn?
    Which year had the most churn?
    What was the average salary for each employee who has left the company?
    What was the median total company tenure for each churn employee just bfore they left?
    On average, how many different titles did each churn employee hold?
    What was the average last pay increase for churn employees?
    What proportion of churn employees had a pay decrease event in their last 5 events?
    How many current employees have the equal longest overall time in their current positions (not in years)?


### Management Analysis

    
    How many managers are there currently in the company?
    How many employees have ever been a manager?
    On average - how long did it take for an employee to first become a manager from their the date they were originally hired?
    What was the most common titles that managers had just before before they became a manager?
    On average - how much more do current managers make on average compared to all other employees?


