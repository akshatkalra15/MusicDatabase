-- Q1. Write a query to return email , first name, last name and genre of all rock music listeners.
-- List should be ordered by email alphabetically.alter

SELECT customer.email, customer.first_name, customer.last_name, genre.name 
FROM customer
JOIN invoice ON customer.id = invoice.customer_id
JOIN invoice_line ON invoice.id = invoice_line.invoice_id
JOIN TRACK ON invoice_line.track_id = track.id
JOIN genre ON track.genre_id = genre.id
WHERE genre.name LIKE 'Rock'
ORDER BY customer.email;

-- Q2. Write a query to return the Artist name and total track count of top 10 rock bands.

select artist.name , count(*) as TotalSongs from artist
JOIN album ON album.artist_id = artist.id
JOIN track ON album.id = track.album_id
JOIN genre ON genre.id = track.genre_id
where genre.name LIKE 'Rock'
GROUP BY artist.name
ORDER BY TotalSongs DESC LIMIT 10;

-- Q3. Return all track names , milliseconds with length more than average of all songs. 
-- Order by songh length in descending order.

SELECT name , milliseconds FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC;
;