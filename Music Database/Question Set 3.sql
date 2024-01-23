-- Q1. How much amount isspent by each customer on artists.
-- Retuen customer name, artist name , total spent.

SELECT 
    CONCAT(customer.first_name,
            ' ',
            customer.last_name) AS FullName,
    artist.name,
    SUM(invoice_line.unit_price * invoice_line.quantity) AS totalAmount
FROM
    customer
        JOIN
    invoice ON customer.id = invoice.customer_id
        JOIN
    invoice_line ON invoice.id = invoice_line.invoice_id
        JOIN
    track ON invoice_line.track_id = track.id
        JOIN
    album ON track.album_id = album.id
        JOIN
    artist ON album.artist_id = artist.id
GROUP BY FullName , artist.name;


-- Q2. Find out the most famous genres of all countries.

WITH famous_genre AS (
SELECT genre.*, invoice.billing_country, COUNT(*) , RANK() OVER(PARTITION BY invoice.billing_country ORDER BY COUNT(*) DESC) AS num
FROM invoice 
JOIN invoice_line ON invoice.id = invoice_line.invoice_id
JOIN TRACK ON invoice_line.track_id = track.id
JOIN genre ON track.genre_id = genre.id
GROUP BY genre.id , invoice.billing_country
)
SELECT * FROM famous_genre
WHERE num = 1;


-- Q3. Query to return the customer who has spent the most on music for each country.
WITH max_spent AS (
SELECT CONCAT(customer.first_name, ' ',customer.last_name)  AS FullName ,invoice.billing_country , SUM(invoice.total) , 
RANK() OVER(PARTITION BY invoice.billing_country ORDER BY SUM(invoice.total) DESC ) as num
FROM customer JOIN invoice ON customer.id = invoice.customer_id
GROUP BY 1,2
)
SELECT * FROM max_spent
WHERE num = 1;