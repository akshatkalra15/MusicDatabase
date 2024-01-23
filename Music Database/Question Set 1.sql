-- Q1. Who is the senior most employee on the basis of Job Title.

SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;
-- OR 
SELECT * FROM employee
WHERE levels = (SELECT MAX(levels) FROM employee);

-- Q2. Which country have the most invoices.

SELECT billing_country ,COUNT(*)
FROM invoice  GROUP BY billing_country
HAVING COUNT(*) = (SELECT MAX(num) FROM (SELECT COUNT(*) as num FROM invoice  GROUP BY billing_country)  as MAXNUM);

-- Q3. What are total values of top 3 invoices?

SELECT * FROM invoice
ORDER BY total DESC
LIMIT 3;

-- Q4 Which city has the best customers. Give city name and total invoice value of all invoice combined of the top city.

SELECT billing_city , SUM(total)
FROM INVOICE 
GROUP BY billing_city
ORDER BY 2 DESC LIMIT 1;

-- Q5. Best Customer. Who has spent the most money?

SELECT customer_id ,customer.*,  SUM(total) 
FROM invoice JOIN customer
ON customer.id = invoice.customer_id
GROUP BY customer_id
ORDER BY SUM(total) DESC LIMIT 1;