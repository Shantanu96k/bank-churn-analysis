SELECT * FROM bank.bank_data;

use bank;
select * from bank_data;

-- How many total customers are present in the dataset?
select count(*) as total_customers from bank_data;

-- How many customers have exited the bank?
select count(*) as total_customer_exited from bank_data
where exited = 1;

-- How many customers are still active (not exited)?
select count(*) as still_active from bank_data
where exited  <> 1;

-- What is the average credit score of customers?
select avg(creditscore) as avg_credit_score from bank_data;

-- What is the minimum and maximum age of customers?
select min(age) as minimum_age, max(age) as maximum_age from bank_data;

-- How many customers belong to each geography?
select geography, count(*) from bank_data
group by geography;

-- How many male and female customers are there?
select gender, count(*) as gender_count from bank_data
group by gender ;

-- What is the average balance of all customers?
select avg(balance) from bank_data;
select avg(balance) from bank_data
where exited = 1;
select gender, avg(balance) from bank_data
group by gender;
select gender, avg(balance) from bank_data
where exited = 1
group by gender;

-- How many customers have a credit card?
select count(*) from bank_data;
select count(*) from bank_data
where exited = 1;
select gender, count(*) from bank_data
group by gender;

-- How many customers are active members of the bank?
select count(*) from bank_data
where isactivemember = 1;

-- What is the average estimated salary of customers?

-- How many customers have more than one product?
select count(*) as more_than_one_product from bank_data
where NumOfProducts > 1;

-- What is the distribution of customers by tenure?

-- How many customers have zero balance?
select count(*) as zero_balance from bank_data
where balance = 0;

-- What is the average age of customers who exited? 
select avg(age) as avg_age from bank_data;

-- What is the average credit score of customers who exited vs those who stayed?
select Exited, avg(CreditScore) as Avg_Credit_Score
from bank_data
group by exited;

-- Which geography has the highest number of customers?
select Geography, count(*) as Highest_no_customer from bank_data
group by Geography
order by count(*) desc;

-- Which geography has the highest churn rate?
select Geography, count(*) as highest_churn_rate from bank_data
where Exited = 0
group by Geography
Order by count(*) desc;

-- What is the average balance for customers in each geography?
select Geography, avg(Balance) as Avg_balance from bank_data
group by Geography;

-- How does churn vary by gender?
select gender,Exited, count(*) as churn from bank_data
group by gender, exited;

-- What is the average age of customers who exited vs those who stayed?
select Exited, avg(age) as avg_age from bank_data
group by exited;
select Exited,gender, avg(age) as avg_age from bank_data
group by exited, gender;

-- What is the average estimated salary by geography?
select geography,gender, avg(EstimatedSalary) as avg_salary from bank_data
group by geography,gender
order by geography;

-- What is the churn rate for customers who have a credit card vs those who don't?
select case
when HasCrCard = 1 then 'Has a Card'
else 'No Card'
end as
HasCrCard,Gender, count(*),
count(*) * 100 / (select count(*) from bank_data) as Percentage from bank_data
group by HasCrCard, gender;

-- What is the churn rate for active vs inactive members?
select case
when IsActiveMember = 1 then 'Active Member'
else 'Non Active'
end as churn_rate,
count(*) * 100 / (select count(*) from bank_data) as churn_rate_in_Percent,
count(*) from bank_data
group by IsActiveMember;

-- What is the average number of products used by exited customers?
select case
when Exited = 1 then 'Exited customer'
else 'not exited'
end as Exited_customer, avg(NumOfProducts) as avg_num_of_product from bank_data
where Exited = 1;

-- Which tenure group has the highest churn rate?
select Tenure, count(*) as churn,
count(*) * 100 / (select count(*) from bank_data where exited = 1) as churn_rate from bank_data
where exited = 1
group by tenure
order by tenure desc;

-- What is the average balance for male vs female customers?
select gender,avg(balance) as Avg_balance from bank_data
group by gender;

-- Which age group has the highest number of exits?
select case
when age >= 18 and age < 25 then 'Young Age'
when age >= 25 and age < 40 then 'Adult Age'
else 'Old Age'
end as Age_Group  ,count(*) as Exited from bank_data
where exited = 1
group by Age_Group;


-- What is the average credit score by geography?
select geography, avg(CreditScore) as Avg_credit_score from bank_data
group by geography;

-- what is the average credit score by geography and by Age_group
with age_groups as (select case
when age >= 18 and age < 25 then 'Young Age'
when age >= 25 and age < 40 then 'Adult Age'
else 'Old Age'
end as Age_Group, CustomerID from bank_data)

select a.Age_Group, b.geography, avg(b.CreditScore) as Avg_credit_score from bank_data b join
age_groups a on b.CustomerID = a.customerID
group by b.geography, a.Age_Group
order by a.age_group;

-- What percentage of customers have more than 2 products?
select NumOfProducts, count(*) * 100 / (select count(*) from bank_data) as percentage from Bank_data
where NumOfProducts > 2
group by NumOfProducts;

-- Advance
-- Find the top 10 customers with the highest balance.
select surname, 
max(balance) over (order by balance desc)
from bank_data;
-- using windo rank function
select surname, balance, 
rank() over (order by balance desc)
from bank_data
limit 10;

-- Find the average salary of customers grouped by geography and gender.
select geography, gender, avg(EstimatedSalary) from bank_data
group by geography, gender
order by geography;

-- Identify customers whose credit score is below the average credit score.
select surname,
case 
when CreditScore < 500 then 'Wrost'
when CreditScore between 500 and 700 then 'Good'
else 'Excellent'
End as Credit_Score from bank_data
where CreditScore < (select avg(CreditScore) from bank_data);

-- Rank customers based on their balance within each geography.
select * from (select surname,geography,
rank() over (partition by geography order by balance desc) as rank_by_salary
from bank_data) t 
where rank_by_salary <=5;

-- Find the top 5 customers with the highest estimated salary in each geography.
select * from (select surname, geography,
rank() over (partition by geography order by EstimatedSalary desc ) as High_salary
from bank_data) t
where High_salary <=5;

-- Calculate the churn rate for each age group.
with age_groups as (select CustomerId, case 
when age >= 18 and age <= 25 then 'Young'
when age >= 26 and age <= 40 then 'Adult'
else 'Old'
end as Age_Group from bank_data)

select a.Age_Group,
count(*) as total_customer,
sum(b.Exited) as chruned_customer,
avg(b.Exited) * 100 as chruned_rate
from bank_data b 
join age_groups a
on b.customerid = a.customerid
group by a.Age_Group;

-- Find customers whose balance is greater than the average balance of their geography.
select customerid, surname, geography,balance from bank_data b
where balance > (select avg(balance) from bank_data where geography = b.geography);

select customerid, surname, geography,balance from (
select *,
row_number() over (partition by geography order by balance desc) as rank_balance,
avg(balance) over (partition by geography ) as average_balance from bank_data
) t
where balance > average_balance and rank_balance <= 10;


-- Find customers with the highest credit score in each geography.
select customerid,geography, CreditScore, surname from (
select *,
row_number() over (partition by geography order by CreditScore desc) as Hig_CR,
max(CreditScore) over (partition by geography) as maximum_CR 
from bank_data
) ta
where Hig_CR <= 10;

-- Identify customers who have more than 2 products but still exited.
select customerid,surname, NumOfProducts from bank_data
where NumOfProducts >1 and Exited = 1;

select NumOfProducts,
count(*) as total_customer,
sum(Exited) as total_exited,
avg(Exited) * 100 as churn_rate
from bank_data
group by NumOfProducts;
-- Find the average balance of the top 20% customers with the highest salaries.
select avg(balance) as average_balance
from (
select balance,
ntile(5) over (order by EstimatedSalary desc) as salary_group
from bank_data
) t
where salary_group = 1;

-- Find the percentage of customers who exited in each geography.
SELECT geography,
COUNT(*) AS exited_customers,
COUNT(*) * 100.0 / (
    SELECT COUNT(*)
    FROM bank_data b2
    WHERE b2.geography = b1.geography
) AS exited_percent
FROM bank_data b1
WHERE exited = 1
GROUP BY geography;

-- Rank customers by credit score within each gender.

-- Identify customers whose salary is above the overall average salary but still exited.

-- Find the top 3 age groups with the highest churn rate.

-- Calculate the cumulative balance of customers ordered by credit score.