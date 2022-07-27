-- SQL LAB 2
USE sakila;

-- 1. Select all the actors with the first name ‘Scarlett’.

SELECT * FROM sakila.actor
WHERE first_name = 'Scarlett';

-- 2. How many films (movies) are available for rent and how many films have been rented?

-- 2 OPTIONS:
-- Option 1: includes the total number of units of movies available for rent
SELECT count(DISTINCT(inventory_id)) as 'Movie units available for rent', 
count(rental_id) as 'Total number of movies rented' FROM sakila.rental;

-- Option 2: includes number of unique movies available for rent
SELECT max(film_id) as 'Movie titles available for rent', 
count(distinct(rental_id)) as 'Total number of movies rented' FROM sakila.film, sakila.rental;

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT max(length) as 'max_duration', min(length) as 'min_duration' FROM sakila.film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?

SELECT sec_to_time(avg(length*60)) as 'Avg length movie in hours' FROM sakila.film;

-- 5. How many distinct (different) actors last names are there?

SELECT count(distinct(last_name)) as 'Unique_last_names' FROM sakila.actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?

SELECT min(rental_date) as 'Operating since...' , 
DATEDIFF(max(last_update), min(rental_date)) AS 'Operating days' 
FROM sakila.rental;

-- 7. Show rental info with additional columns month and weekday. Get 20 results.

SELECT rental_id, customer_id, rental_date, 
date_format(rental_date, '%M') as 'rental_month', 
date_format(rental_date, '%W') as 'rental_day' 
FROM sakila.rental
LIMIT 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT rental_id, customer_id, rental_date, 
date_format(rental_date, '%M') as 'rental_month', 
date_format(rental_date, '%W') as 'rental_day', 
CASE
WHEN date_format(rental_date, '%W') in ('Saturday', 'Sunday') then 'Weekend'
ELSE 'workday'
END AS 'day_type'
FROM sakila.rental;

-- 9. Get release years.

SELECT title as 'movie', release_year FROM sakila.film;

-- 10. Get all films with ARMAGEDDON in the title.

SELECT title FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%';

-- 11. Get all films which title ends with APOLLO.

SELECT title FROM sakila.film
WHERE title LIKE '%APOLLO';

-- 12. Get 10 the longest films.

SELECT title, length FROM sakila.film
ORDER BY length DESC
LIMIT 10;

-- 13. How many films include Behind the Scenes content?

SELECT count(title) as 'Movies_with_behind_the_scenes_content' FROM sakila.film
WHERE special_features LIKE '%Behind the Scenes%';