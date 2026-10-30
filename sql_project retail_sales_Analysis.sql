Drop table if exists sql_Project_1;
create table sql_Project_1(
	transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(50),
	age int,
	category varchar(50),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float

)


-- Data Cleaning

select * from sql_Project_1
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null
or
age is null


UPDATE sql_Project_1
SET age = (
    SELECT ROUND(AVG(age))
    FROM sql_Project_1
)
WHERE age IS NULL;



select * from sql_Project_1
where age is null



-- Data Exploration

-- how many sales we have achive

select count(*) from sql_Project_1


-- how many unique customer we have

select count(Distinct customer_id) from sql_Project_1

-- retrieve all columns for sales made on '2022-11-05'

select * from sql_Project_1
where sale_date = '2022-11-05'


-- retrieve all transactions where the category is 'Clothing' and the quantity 
-- sold is more then 10 in the month of Nov-2022


select * from sql_Project_1
where category = 'Clothing' and quantiy > 3 and sale_date between '2022-11-01' AND '2022-11-30';



-- calculate total_sales For each category

select category, sum(total_sale) as revenue from sql_Project_1
group by category



-- find the avg age of customers who purchased item from the 'Beauty'

select Round(avg(age),2) as average_age from sql_Project_1
where category = 'Beauty'

-- find all tansactions where the total_sale is greter then 1000
select transactions_id from sql_Project_1
where total_sale > 1000


-- find the total number of transactions made by each gender in each category.

select category, gender, count(transactions_id) from sql_Project_1
group by category, gender

-- calculate the avg sale for each month Find out best selling month in each year

select years, months, avg_sale from
(select 
	Extract (year from sale_date) as years, 
	Extract(Month from sale_date) as months, 
	avg(total_sale) as avg_sale,
	Rank() over(partition by Extract (year from sale_date) order by avg(total_sale) desc) as rank
from sql_Project_1
group by years, months) as t1
where rank = 1





-- find the top 5 customers based on the highest total sales

select customer_id, sum(total_sale) as revenue
from sql_Project_1
group by customer_id
order by sum(total_sale) desc limit 5


-- find the no. of unique customer who purchase items from each category

select category, count(Distinct customer_id) from sql_Project_1
group by category



select *,
	case
	 when Extract(hour from sale_time) < 12 then 'Morning'
	 when Extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	 else 'Evening'
	 end as shift
	
from sql_Project_1






















