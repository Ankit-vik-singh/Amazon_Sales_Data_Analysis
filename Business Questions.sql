
#1-What is the count of distinct cities in the dataset? ANSWER-3
SELECT 
    COUNT(DISTINCT city)
FROM
    amazondata;

#2-For each branch, what is the corresponding city?
SELECT DISTINCT
    branch,city
FROM
    amazondata
ORDER BY branch;


#3-What is the count of distinct product lines in the dataset?ANSWER-6
SELECT 
    COUNT(DISTINCT product_line)
FROM
    amazondata;

#4-Which payment method occurs most frequently?ANSWER=Cash
SELECT 
    payment_method, COUNT(*) AS count_pm
FROM
    amazondata
GROUP BY payment_method
ORDER BY count_pm DESC
LIMIT 1;

#5-Which product line has the highest sales?ANSWER=Fashion accessories
SELECT 
    product_line, COUNT(invoice_id) AS sales_count
FROM
    amazondata
GROUP BY product_line
ORDER BY sales_count desc
limit 1;

#6=How much revenue is generated each month?

SELECT 
    monthname, SUM(total) as revenue
FROM
    amazondata
GROUP BY monthname
ORDER BY SUM(total) DESC;

#7-In which month did the cost of goods sold reach its peak?
SELECT 
    monthname, SUM(cogs)
FROM
    amazondata
GROUP BY monthname
ORDER BY SUM(cogs) DESC
LIMIT 1;

#8-Which product line generated the highest revenue?
SELECT 
    product_line, SUM(total) AS revenue
FROM
    amazondata
GROUP BY product_line
ORDER BY SUM(total) DESC
LIMIT 1;

#9-In which city was the highest revenue recorded?
SELECT 
    city, SUM(total) as revenue
FROM
    amazondata
GROUP BY city
ORDER BY revenue DESC
LIMIT 1;

#10-Which product line incurred the highest Value Added Tax?
SELECT 
    product_line, SUM(vat) as VAT
FROM
    amazondata
GROUP BY product_line
ORDER BY VAT DESC
LIMIT 1;

#11-For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

SELECT 
    product_line,
    SUM(total) AS revenue,
    CASE
        WHEN
            SUM(total) < (SELECT AVG(total) FROM amazondata) THEN 'bad'
        ELSE 'good'
    END AS category_of_sales
FROM
    amazondata
GROUP BY product_line
ORDER BY revenue DESC;
  
#12-Identify the branch that exceeded the average number of products sold
SELECT 
    branch, SUM(quantity) AS total_quantity
FROM
    amazondata
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM amazondata);

#13-Which product line is most frequently associated with each gender?
WITH freq AS (
  SELECT
    product_line,
    gender,
    ROW_NUMBER() OVER (PARTITION BY gender ORDER BY COUNT(*) DESC) AS rank1
  FROM
    amazondata
  GROUP BY
    product_line, gender
)
SELECT
  product_line,
  gender
FROM
  freq
WHERE
  rank1 = 1;
  
#14-Calculate the average rating for each product line.
SELECT 
    product_line, AVG(rating) as avg_rating
FROM
    amazondata
GROUP BY product_line
ORDER BY avg_rating DESC;

#15-Count the sales occurrences for each time of day on every weekday.
SELECT 
    dayname,timeofday,COUNT(invoice_id) AS sales_occurence
FROM
    amazondata
WHERE dayname NOT IN ("saturday","sunday")
GROUP BY dayname,timeofday
ORDER BY dayname DESC,COUNT(invoice_id) DESC;

#16-Identify the customer type contributing the highest revenue.
SELECT 
    customer_type, SUM(total) as revenue
FROM
    amazondata
GROUP BY customer_type
ORDER BY revenue DESC
LIMIT 1;

#17-Determine the city with the highest VAT percentage.
SELECT 
    city, MAX(vat)
FROM
    amazondata
GROUP BY city
ORDER BY MAX(vat) DESC
LIMIT 1;

#18-Identify the customer type with the highest VAT payments.
SELECT 
    customer_type, MAX(vat)
FROM
    amazondata
GROUP BY customer_type
ORDER BY MAX(vat) DESC
LIMIT 1;

#19-What is the count of distinct customer types in the dataset?
SELECT 
    COUNT(DISTINCT customer_type) AS unique_customer_type
FROM
    amazondata;

#20-What is the count of distinct payment methods in the dataset?
SELECT 
    COUNT(DISTINCT payment_method) AS unique_payment_method
FROM
    amazondata;
    
#21-Which customer type occurs most frequently?
SELECT 
    COUNT(*) AS occurence, customer_type
FROM
    amazondata
GROUP BY customer_type
ORDER BY COUNT(*) DESC
LIMIT 1;

#22-Identify the customer type with the highest purchase frequency.
SELECT 
    customer_type, COUNT(invoice_id) as purchase_freq
FROM
    amazondata
GROUP BY customer_type
ORDER BY COUNT(invoice_id) DESC
LIMIT 1;



#24-Examine the distribution of genders within each branch.
SELECT 
    branch, gender, COUNT(*) AS gender_count
FROM
    amazondata
GROUP BY branch , gender
ORDER BY branch , gender_count DESC;

#25-Identify the time of day when customers provide the most ratings.
SELECT
  timeofday,
  COUNT(*) AS rating_count
FROM
  amazondata
GROUP BY
  timeofday
ORDER BY
  rating_count DESC
LIMIT 1;

#26-Determine the time of day with the highest customer ratings for each branch.
SELECT 
    branch, timeofday, COUNT(*) AS rating_count
FROM
    amazondata
GROUP BY branch , timeofday
ORDER BY branch , rating_count DESC;


#27-Identify the day of the week with the highest average ratings.
SELECT 
    dayname, AVG(rating) AS avg_rating
FROM
    amazondata
GROUP BY dayname
ORDER BY avg_rating DESC
LIMIT 1;

#28-Determine the day of the week with the highest average ratings for each branch.
WITH high_avg_r AS (
 SELECT 
   branch,timeofday,AVG(rating) AS avg_rating,
   row_number() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rownum
 FROM
   amazondata
 GROUP BY  
    branch,timeofday
)
SELECT 
   branch,timeofday,avg_rating FROM high_avg_r
WHERE 
   rownum=1
ORDER BY  
   branch;








