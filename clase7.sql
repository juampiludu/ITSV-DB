# 1. Find the films with less duration, show the title and rating.


SELECT title, rating 
FROM film f 
WHERE `length` <= ALL (SELECT `length` 
						FROM film f2)	


# 2. Write a query that returns the tiltle of the film which duration is the lowest. 
#    If there are more than one film with the lowest duration, the query returns an empty resultset.


SELECT title
FROM film f 
WHERE `length` < ALL (SELECT `length` 
						FROM film f2)
						

# 3. Generate a report with list of customers showing the lowest payments done by each of them. 
#    Show customer information, the address and the lowest amount, 
#    provide both solution using ALL and/or ANY and MIN.
						

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

# Quede acá, el count de menores pagos me da 24, pero al hacer las 2 querys de arriba me tira 8,
# y no se cómo seguir.








