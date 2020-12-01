-- 1. Get the amount of cities per country in the database. Sort them by country, country_id.

SELECT c2.country, COUNT(*) AS amount_of_cities
FROM city c, country c2
WHERE c.country_id = c2.country_id
GROUP BY c2.country

-- 2. Get the amount of cities per country in the database. Show only the countries with more than 10 cities,
-- order from the highest amount of cities to the lowest.

SELECT c2.country, COUNT(*) AS amount_of_cities
FROM city c, country c2
WHERE c.country_id = c2.country_id
GROUP BY c2.country
HAVING amount_of_cities > 10

-- 3. Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films.
--     	* Show the ones who spent more money first .

-- 4. Which film categories have the larger film duration (comparing average)?
--  	*Order by average in descending order

SELECT c.name, AVG(`length`) AS average
FROM film f, category c
GROUP BY c.name
HAVING average > (SELECT AVG(`length`) FROM film f2) 

-- (Seguro estan (muy) mal)

-- 5. Show sales per film rating.

SELECT f.rating, COUNT(p.payment_id) AS sales
FROM film f, payment p 
GROUP BY f.rating

-- (Seguro estan (muy) mal)
