---Sql Retail Sales Analysis - P1
CREATE DATABASE Sql_project_p2;


----Create Table
DROP TABLE IF EXISTS Retail_Sales;
CREATE TABLE Retail_Sales 
        (
          transactions_id INT PRIMARY KEY,	
          sale_date	DATE,
		  sale_time	TIME,
          customer_id INT,
          gender VARCHAR(25),
		  age INT,	
          category VARCHAR(25),
          quantiy INT,
          price_per_unit FLOAT,	
          cogs FLOAT,	
          total_sale FLOAT
         );

		 SELECT * FROM retail_sales
		 Limit 10
		 
		 SELECT  
		 Count(*)
		 FROM retail_sales

		 ----- Data Cleaning
		 SELECT * FROM retail_sales
		 WHERE transactions_id IS NULL 

		 SELECT * FROM retail_sales
		 WHERE sale_date IS NULLtransactions_id IS NULL  

		 SELECT * FROM retail_sales
		 WHERE sale_time IS NULL 

		 SELECT * FROM retail_sales
		 WHERE customer_id IS NULL 

		 SELECT * FROM retail_sales
		 WHERE gender IS NULL 

		 SELECT * FROM retail_sales
		 WHERE age IS NULL 


        SELECT * FROM retail_sales
		WHERE 
		     transactions_id IS NULL 
			 or
			 transactions_id IS NULL 
			 or
			 sale_time IS NULL 
			 or
			 gender IS NULL 
			 or
			 category IS NULL
			 or
			 quantiy IS NULL
			 or
			 cogs IS NULL
			 or
			 total_sale IS NULL;

			 ----
			 DELETE FROM retail_sales
			 WHERE
			 transactions_id IS NULL 
			 or
			 transactions_id IS NULL 
			 or
			 sale_time IS NULL 
			 or
			 gender IS NULL 
			 or
			 category IS NULL
			 or
			 quantiy IS NULL
			 or
			 cogs IS NULL
			 or
			 total_sale IS NULL;

			 ----- Data Exploration

-----How many sales we have?
SELECT COUNT (*) total_sale FROM retail_sales

----How many unique customers are there?
SELECT COUNT (DISTINCT customer_id)as total_sale FROM retail_sales

SELECT COUNT (DISTINCT category)as total_sale FROM retail_sales

SELECT DISTINCT category FROM retail_sales

-----Data analysis & Business key problems & Answers
----1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-----**Write a SQL query to retrieve all transactions where the category is
'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

SELECT
  *   
FROM retail_sales
WHERE 
  category = 'Clothing'
  AND 
  TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
  AND 
  quantiy >=4

-----3. **Write a SQL query to calculate the total sales 
(total_sale) for each category.**:

SELECT
      category,
	  SUM(total_sale) as net_sale,
	  COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

---4. **Write a SQL query to find the average age of customers
who purchased items from the 'Beauty' category.**:

SELECT 
      ROUND(AVG(age),2) as avg_age
	  FROM retail_sales
	  WHERE category = 'Beauty'

----5. **Write a SQL query to find all transactions where the total_sale 
is greater than 1000.**:

SELECT * FROM retail_sales 
WHERE total_sale >1000

----
6. **Write a SQL query to find the total number of transactions 
(transaction_id) made by each gender in each category.**:

SELECT 
     category,
	 gender,
	 COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1

----7. **Write a SQL query to calculate the average sale for each month. 
Find out best selling month in each year**:

SELECT 
       year,
	   month,
	   avg_sale
FROM
(
SELECT
      EXTRACT(YEAR FROM sale_date) as year,
	  EXTRACT(MONTH FROM sale_date) as month,
	  Avg(total_sale) as avg_sale,
	  RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG (total_sale)DESC)as RANK
      FROM retail_sales
	  GROUP BY 1 ,2
	  )AS t1
WHERE rank = 1 
---ORDER BY 1, 3 DESC
	
----
8. **Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT
     customer_id,
	 SUM(total_sale)as total_sales
	 FROM retail_sales
	 GROUP BY 1
	 ORDER BY 2 DESC
	 LIMIT 5

----9. **Write a SQL query to find the number of unique customers who
purchased items from each category.**:

SELECT
     category,
    COUNT(DISTINCT customer_id)as cnt_unique_cs 
FROM retail_sales
GROUP BY category	 

----10. **Write a SQL query to create each shift and number of orders 
(Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

WITH hourly_table
AS
(
SELECT *,
       CASE
	   WHEN EXTRACT(HOUR FROM sale_time)< 12 THEN 'MORNING'
	   WHEN EXTRACT(HOUR FROM sale_time)BETWEEN 12 AND 17 THEN 'AFTERNOON'
	   ELSE 'EVENING'
    END as shift
FROM retail_sales
)
SELECT 
      shift,
      COUNT(*) as total_orders
	  FROM hourly_table
      GROUP BY shift

 ----End of project 





	  
	  


	  
  




