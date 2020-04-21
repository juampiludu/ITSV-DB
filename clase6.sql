-- 1. List all the actors that share the last name. Show them in order

SELECT first_name, last_name 
FROM actor a 
WHERE EXISTS (SELECT last_name 
				FROM actor a2 
			  WHERE a.last_name = a2.last_name
			  AND a.actor_id <> a2.actor_id)
ORDER BY last_name ASC 

-- 5. List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'

SELECT actor_id
FROM film f2, film_actor fa
WHERE actor_id = fa.actor_id
AND fa.film_id = f2.film_id
AND f2.title = 'BETRAYED REAR'

SELECT a.actor_id, f2.title 
FROM actor a, film f2, film_actor fa
WHERE a.actor_id IN (SELECT a.actor_id 
					FROM film_actor fa2, film f3, actor a2
				   WHERE a2.actor_id = a.actor_id 
				   AND a2.actor_id = fa2.actor_id
				   AND fa2.film_id = f3.film_id
				   AND f3.title = 'BETRAYED REAR')
AND a.actor_id = fa.actor_id
AND fa.film_id = f2.film_id
AND f2.title = 'CATCH AMISTAD'

-- 6. List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'

-- 7. List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'