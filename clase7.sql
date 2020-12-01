-- 1. Find the films with less duration, show the title and rating.


SELECT title, rating 
FROM film f 
WHERE `length` <= ALL (SELECT `length` 
						FROM film f2)	


-- 2. Write a query that returns the tiltle of the film which duration is the lowest. 
--    If there are more than one film with the lowest duration, the query returns an empty resultset.


SELECT title
FROM film f 
WHERE `length` < ALL (SELECT `length` 
						FROM film f2)
						

-- 3. Generate a report with list of customers showing the lowest payments done by each of them. 
--    Show customer information, the address and the lowest amount, 
--    provide both solution using ALL and/or ANY and MIN.
						

SELECT first_name, last_name, address, amount
FROM payment p, customer c, address a
WHERE amount IN (SELECT MIN(amount)
					FROM payment p2)
AND p.customer_id = c.customer_id
AND c.address_id = a.address


SELECT first_name, last_name, address, amount
FROM payment p, customer c, address a
WHERE amount <= ALL (SELECT amount
					FROM payment p2)
AND p.customer_id = c.customer_id
AND c.address_id = a.address

-- Quede acá, el count de menores pagos me da 24, pero al hacer las 2 querys de arriba me tira 8,
-- y no se cómo seguir.

-- 4. Generate a report that shows the customer's information with the highest payment and the lowest payment
-- in the same row.

SELECT DISTINCT c.customer_id, c.first_name, c.last_name, a.address, p.amount AS 'min_amount', p3.amount AS "max_amount"
FROM customer c, address a, payment p, payment p3
WHERE c.address_id = a.address_id
AND p.customer_id = c.customer_id
AND p3.customer_id = c.customer_id
AND p.amount <= ALL (
	SELECT p2.amount
	FROM payment p2
	WHERE p2.customer_id = c.customer_id)
AND p3.amount >= ALL (
	SELECT p2.amount
	FROM payment p2
	WHERE p2.customer_id = c.customer_id)
ORDER BY min_amount;


