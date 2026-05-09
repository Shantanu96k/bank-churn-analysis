# Bank Churn Analysis

![Excel](https://img.shields.io/badge/Excel-Data%20Cleaning-green)
![SQL](https://img.shields.io/badge/SQL-Analysis-orange)
![PowerBI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811)
![License](https://img.shields.io/badge/License-MIT-blue)

An end-to-end customer churn analysis for a bank dataset covering
10,000 customers. Built with Excel (data cleaning), SQL (analysis),
and Power BI (dashboard). Identifies the key drivers of churn across
geography, age group, product type, and account activity.

## Dataset

| Column          | Description                          |
|-----------------|--------------------------------------|
| CustomerId      | Unique customer ID                   |
| Surname         | Customer surname                     |
| CreditScore     | Credit score (350–850)               |
| Geography       | France / Germany / Spain             |
| Gender          | Male / Female                        |
| Age             | Customer age                         |
| Tenure          | Years with the bank                  |
| Balance         | Account balance                      |
| NumOfProducts   | Number of bank products held         |
| HasCrCard       | Has credit card (1/0)                |
| IsActiveMember  | Active in last month (1/0)           |
| EstimatedSalary | Estimated annual salary              |
| Exited          | Churned (1 = yes, 0 = no) ← TARGET  |

- **Rows:** 10,000 customers
- **Source:** [Kaggle — Bank Customer Churn](https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn)

  ## Tools & methodology

| Stage          | Tool        | What was done                              |
|----------------|-------------|--------------------------------------------|
| Analysis       | SQL (MySQL) | Churn rate queries by segment              |
| Reporting      | PDF         | Business summary of findings               |
