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


# [Ad-Hoc Data Analysis](https://github.com/ajm-data/HR_analytics_company_department/tree/main/ad-hoc_analysis)

### [Current Employee Analysis](https://github.com/ajm-data/HR_analytics_company_department/blob/main/ad-hoc_analysis/current_employee_analysis.pgsql)
    
    What is the full name of the employee with the highest salary?
        - 'Tokuyasu Pesch' : $158,220
        
    How many current employees have the equal longest time in their current positions?
        - 3505 employees have held their title for 20 years
    
    Which department has the least number of current employees?
        - Finance dept has 12,437 employees

    What is the largest difference between minimimum and maximum salary values for all current employees?
        - $119,597

    How many male employees are above the average salary value for the Production department?
        - 14,999 men in 'Production' make more than average 'Production' salary

    Which title has the highest average salary for male employees?
        - Senior Staff (title): highest avg male salary at $80,735

    Which department has the highest average salary for female employees?
        - Sales: average salary for Female employees $88,835

    Which department has the least amount of female employees?
        - Finance has the least female employees (5,014)

    What is the gender ratio in the department which has the highest average male salary and what is the average male salary value for that department?
        - Female 14,999: Male 22,702 & Male avg_salary = $88,864
    
    HR Analytica want to change the average salary increase percentage value to 2 decimal places - what will the new value be for males for the company level dashboard?
        - Updated, male average salary (rounded 2 decimal places) = 3.02

### [Employee Churn](https://github.com/ajm-data/HR_analytics_company_department/blob/main/ad-hoc_analysis/churn_analysis.pgsql)

    How many employees have left the company?
        - 59,910 employees have left the company

    What percentage of churn employees were male?
        - 60% of churned employees were male

    Which job title had the most churn?
        - Engineer was the most churned title

    Which department had the most churn?
        - Development department had the most employee churn
    
    Which year had the most churn?
        - 2018 had the most employee churn

    What was the average salary for each employee who has left the company?
        - $61,574 was the avg. salary of employees at time of churn

    What was the median total company tenure for each churn employee just bfore they left?
        - 12 years was the median 'company_tenure' for churned employees

    On average, how many different titles did each churn employee hold?
        - avg of 1.2 distinct job titles for churned employees

    What was the average last pay increase for churn employees?
        - $2,254.44 was the avg pay increase for churned employees

    What proportion of churned employees had a pay decrease event in their last 5 events?
        - 24% of churned employees had a pay decrease


### Management Analysis

    
    How many managers are there currently in the company?
    How many employees have ever been a manager?
    On average - how long did it take for an employee to first become a manager from their the date they were originally hired?
    What was the most common titles that managers had just before before they became a manager?
    On average - how much more do current managers make on average compared to all other employees?


