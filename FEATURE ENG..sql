create database amazon;
create table amazondata(
invoice_id VARCHAR(30),
branch VARCHAR(5),
city VARCHAR(30),
customer_type VARCHAR(30),
gender VARCHAR(10),
product_line VARCHAR(100),
unit_price DECIMAL(10,2),
quantity INT,
VAT FLOAT(6,4),
total DECIMAL(10,2),
date DATE,
time TIME,
payment_method VARCHAR(200),
cogs DECIMAL(10,2),
gross_margin_percentage FLOAT(11,9),
gross_income DECIMAL(10,2),
rating FLOAT(2,1)
);
SELECT * FROM amazondata;

# Add a new column named timeofday to give insight of sales in the Morning,
#Afternoon and Evening. This will help answer the question on which part of the day most sales are made.

ALTER TABLE amazondata
ADD COLUMN timeofday VARCHAR(10);

UPDATE amazondata
SET timeofday =
  IF(HOUR(time) >= 0 AND HOUR(time) < 12, 'Morning',
    IF(HOUR(time) >= 12 AND HOUR(time) < 18, 'Afternoon', 'Evening'));

#Add a new column named dayname that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). 
#This will help answer the question on which week of the day each branch is busiest.

ALTER TABLE amazondata
ADD COLUMN dayname VARCHAR(10);

UPDATE amazondata
SET dayname = DAYNAME(date);

#Add a new column named monthname that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). 
#Help determine which month of the year has the most sales and profit.

ALTER TABLE amazondata
ADD COLUMN monthname VARCHAR(10);

UPDATE amazondata
SET monthname = MONTHNAME(date);
