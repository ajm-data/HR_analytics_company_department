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

### [Current Employee Deep Dive](https://github.com/ajm-data/HR_analytics_company_department/blob/main/deep_dive_data_components/current_snapshot.pgsql)
### [Historic Employee Deep Dive](https://github.com/ajm-data/HR_analytics_company_department/blob/main/deep_dive_data_components/historic_employee_records.pgsql)

    - Show employment history ordered by date including salary, department, manager and title changes
    - Calculate previous historic payrise percentages and value changes
    - Calculate the previous position and department history in months with start and end dates
    - Compare an employee’s current salary, total company tenure, department, position and gender to the average benchmarks for their current position

