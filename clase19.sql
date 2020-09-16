-- 1. Create a user data_analyst
-- 2. Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
-- 3. Login with this user and try to create a table. Show the result of that operation.
-- 4. Try to update a title of a film. Write the update script.
-- 5. With root or any admin user revoke the UPDATE permission. Write the command
-- 6. Login again with data_analyst and try again the update done in step 4. Show the result.

-- 1

create user data_analyst@'%' identified by 'root';

-- 2

grant select, update, delete on sakila.* to data_analyst@'%'

-- 3

create table movie_year;
-- Error: CREATE command denied to user 'data_analyst'@'localhost' fot table 'movie_year'

-- 4

update film
set title='ACADEMY DINOSAURrrr'
where film_id=1;

-- 5

revoke update on sakila.* from data_analyst;

-- 6

update film
set title='ACADEMY DINOSAUR'
where film_id=1;

-- Acá no entiendo por qué no me dió ningún error, me sigue dejando actualizar las tablas.