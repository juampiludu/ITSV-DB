DROP DATABASE IF EXISTS imdb;

-- Create a new database called imdb

CREATE DATABASE imdb;

-- Create tables: film (film_id, title, description, release_year); 
-- actor (actor_id, first_name, last_name) , 
-- film_actor (actor_id, film_id)
-- - Use autoincrement id
-- - Create PKs

USE imdb;

CREATE TABLE film (
film_id INT AUTO_INCREMENT, 
title VARCHAR(30) NOT NULL, 
description TEXT, 
release_year INT NOT NULL,
CONSTRAINT film_pk PRIMARY KEY (film_id)
);

CREATE TABLE actor(
actor_id INT AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
CONSTRAINT actor_pk PRIMARY KEY (actor_id)
);

CREATE TABLE film_actor (
film_id INT NOT NULL,
actor_id INT NOT NULL,
CONSTRAINT film_actor_pk PRIMARY KEY (film_id, actor_id)
);

-- Alter table add column last_update to film and actor

ALTER TABLE film ADD COLUMN last_update DATETIME;

ALTER TABLE film MODIFY last_update DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE actor ADD COLUMN last_update DATETIME;

ALTER TABLE actor MODIFY last_update DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Alter table add foreign keys to film_actor table

ALTER TABLE film_actor ADD CONSTRAINT film_pk FOREIGN KEY (film_id) REFERENCES film (film_id);

ALTER TABLE film_actor ADD CONSTRAINT actor_pk FOREIGN KEY (actor_id) REFERENCES actor (actor_id);

-- Insert some actors, films and who acted in each film

INSERT INTO film (title, description, release_year) VALUES ("JOKER", NULL, 2019);
INSERT INTO film (title, description, release_year) VALUES ("Once Upon a Time in Hollywood", NULL, 2019);
INSERT INTO actor (first_name, last_name) VALUES ("Joaquin", "Phoenix");
INSERT INTO actor (first_name, last_name) VALUES ("Robert", "De Niro");
INSERT INTO actor (first_name, last_name) VALUES ("Leonardo", "DiCaprio");
INSERT INTO actor (first_name, last_name) VALUES ("Brad", "Pitt");
INSERT INTO film_actor (film_id, actor_id) VALUES(1,1);
INSERT INTO film_actor (film_id, actor_id) VALUES(1,2);
INSERT INTO film_actor (film_id, actor_id) VALUES(2,3);
INSERT INTO film_actor (film_id, actor_id) VALUES(2,4);





