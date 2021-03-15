-- The following queries utilize the "dvdstore" database.

-- 1. All of the films that Nick Stallone has appeared in
-- (30 rows)

SELECT f.title
        FROM film as f
        INNER JOIN film_actor as fa
                ON f.film_id = fa.film_id
                        INNER JOIN actor a
                        ON fa.actor_id = a.actor_id
WHERE a.first_name = 'NICK' AND a.last_name = 'STALLONE';

-- 2. All of the films that Rita Reynolds has appeared in
-- (20 rows)

SELECT f.title
        FROM film as f
        INNER JOIN film_actor as fa
                ON f.film_id = fa.film_id
                        INNER JOIN actor a
                        ON fa.actor_id = a.actor_id
WHERE a.first_name = 'RITA' AND a.last_name = 'REYNOLDS';

-- 3. All of the films that Judy Dean or River Dean have appeared in
-- (46 rows)


SELECT f.title
        FROM film as f
        INNER JOIN film_actor as fa
                ON f.film_id = fa.film_id
                        INNER JOIN actor a
                        ON fa.actor_id = a.actor_id
WHERE (a.first_name = 'JUDY' AND a.last_name = 'DEAN')
        OR (a.first_name = 'RIVER' AND a.last_name = 'DEAN');

-- 4. All of the the ‘Documentary’ films
-- (68 rows)

SELECT f.title, c.name
        FROM category c
                INNER JOIN film_category fc
                ON c.category_id = fc.category_id
                        INNER JOIN film f
                        ON fc.film_id = f.film_id
WHERE c.name = 'Documentary';

-- 5. All of the ‘Comedy’ films
-- (58 rows)

SELECT f.title, c.name
        FROM category c
                INNER JOIN film_category fc
                ON c.category_id = fc.category_id
                        INNER JOIN film f
                        ON fc.film_id = f.film_id
WHERE c.name = 'Comedy';

-- 6. All of the ‘Children’ films that are rated ‘G’
-- (10 rows)

SELECT f.title as title_of_children_movie
        FROM film f
        INNER JOIN film_category fc
                ON f.film_id = fc.film_id
        INNER JOIN category c
                ON fc.category_id = c.category_id
WHERE c.name = 'Children' AND f.rating = 'G';
                 

-- 7. All of the ‘Family’ films that are rated ‘G’ and are less than 2 hours in length
-- (3 rows)

SELECT f.title as title_of_family_movie
        FROM film f
        INNER JOIN film_category fc
                ON f.film_id = fc.film_id
        INNER JOIN category c
                ON fc.category_id = c.category_id
WHERE c.name = 'Family' 
        AND f.rating = 'G'
        AND f.length < 120;

-- 8. All of the films featuring actor Matthew Leigh that are rated ‘G’
-- (9 rows)

SELECT f.title as matthew_leigh_movies
        FROM film f
        INNER JOIN film_actor as fa
                ON f.film_id = fa.film_id
        INNER JOIN actor a
                ON fa.actor_id = a.actor_id
WHERE a.first_name = 'MATTHEW' 
        AND a.last_name = 'LEIGH' 
        AND f.rating = 'G';

-- 9. All of the ‘Sci-Fi’ films released in 2006
-- (61 rows)

SELECT f.title, c.name
        FROM category c
                INNER JOIN film_category fc
                ON c.category_id = fc.category_id
                        INNER JOIN film f
                        ON fc.film_id = f.film_id
WHERE c.name = 'Sci-Fi';

-- 10. All of the ‘Action’ films starring Nick Stallone
-- (2 rows)

SELECT f.title, c.name
        FROM category c
                INNER JOIN film_category fc
                        ON c.category_id = fc.category_id
                INNER JOIN film f
                        ON fc.film_id = f.film_id
                INNER JOIN film_actor as fa
                         ON f.film_id = fa.film_id
                INNER JOIN actor a
                        ON fa.actor_id = a.actor_id
WHERE c.name = 'Action'
        AND a.first_name || ' ' || a.last_name = 'NICK STALLONE';
   

-- 11. The address of all stores, including street address, city, district, and country
-- (2 rows)

SELECT a.address, c.city, co.country
        FROM address a
                INNER JOIN store s
                        ON a.address_id = s.address_id
                INNER JOIN city c
                        ON a.city_id = c.city_id
                INNER JOIN country co
                        ON c.country_id = co.country_id
WHERE a.address_id = s.address_id;

-- 12. A list of all stores by ID, the store’s street address, and the name of the store’s manager
-- (2 rows)

SELECT a.address, staff.last_name ||', '|| staff.first_name
        FROM store s
                INNER JOIN address as a
                        ON s.address_id = a.address_id
                INNER JOIN staff 
                        ON s.store_id = staff.store_id
WHERE a.address_id = s.address_id
        AND s.manager_staff_id = staff.staff_id;
        
-- 13. The first and last name of the top ten customers ranked by number of rentals
-- (#1 should be “ELEANOR HUNT�? with 46 rentals, #10 should have 39 rentals)

SELECT c.first_name || ' ' || c.last_name as full_name, count(*)
        FROM customer as c
        INNER JOIN rental r
                ON c.customer_id = r.customer_id
        INNER JOIN payment p
                ON r.rental_id = p.rental_id
GROUP BY c.customer_id
ORDER BY count(*) DESC
LIMIT 10;


-- 14. The first and last name of the top ten customers ranked by dollars spent
-- (#1 should be “KARL SEAL�? with 221.55 spent, #10 should be “ANA BRADLEY�? with 174.66 spent)

SELECT c.first_name || ' ' || c.last_name as customer_name, SUM(p.amount)
        FROM customer as c
        INNER JOIN rental r
                ON c.customer_id = r.customer_id
        INNER JOIN payment p
                ON r.rental_id = p.rental_id
GROUP BY c.customer_id
ORDER BY SUM(amount) DESC
LIMIT 10;
 

-- 15. The store ID, street address, total number of rentals, total amount of sales (i.e. payments), and average sale of each store.
-- (NOTE: Keep in mind that while a customer has only one primary store, they may rent from either store.)
-- (Store 1 has 7928 total rentals and Store 2 has 8121 total rentals)

SELECT s.store_id, a.address, COUNT(p.rental_id) AS number_of_rentals, SUM(p.amount) AS total_amount_of_sales,  round(SUM(p.amount)/ COUNT(p.rental_id),2) AS average_sale
        FROM store s
        INNER JOIN address a
                ON s.address_id = a.address_id
        INNER JOIN inventory i
                ON s.store_id = i.store_id
        INNER JOIN rental r
                ON i.inventory_id = r.inventory_id
        INNER JOIN payment p
                ON r.rental_id = p.rental_id
GROUP BY a.address, s.store_id;


-- 16. The top ten film titles by number of rentals
-- (#1 should be “BUCKET BROTHERHOOD�? with 34 rentals and #10 should have 31 rentals)

SELECT f.title, COUNT(rental_id) AS number_rented
        FROM film f
        INNER JOIN inventory i
                ON f.film_id = i.film_id
        INNER JOIN rental r
                ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY COUNT(rental_id) DESC
LIMIT 10;

-- 17. The top five film categories by number of rentals
-- (#1 should be “Sports�? with 1179 rentals and #5 should be “Family�? with 1096 rentals)

SELECT c.name, COUNT(r.rental_id) AS number_rented
        FROM category c
        INNER JOIN film_category fc
                ON c.category_id = fc.category_id
        INNER JOIN film f
                ON fc.film_id = f.film_id
        INNER JOIN inventory i
                ON f.film_id = i.film_id
        INNER JOIN rental r
                ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY number_rented DESC
LIMIT 5;

-- 18. The top five Action film titles by number of rentals
-- (#1 should have 30 rentals and #5 should have 28 rentals)

SELECT f.title, count(rental_id) as number_rented
        FROM category c
        INNER JOIN film_category fc
                ON c.category_id = fc.category_id
        INNER JOIN film f
                ON fc.film_id = f.film_id
        INNER JOIN inventory i
                ON f.film_id = i.film_id
        INNER JOIN rental r
                ON i.inventory_id = r.inventory_id
WHERE c.name = 'Action'
GROUP BY f.title
ORDER BY number_rented DESC
LIMIT 5;

-- 19. The top 10 actors ranked by number of rentals of films starring that actor
-- (#1 should be “GINA DEGENERES�? with 753 rentals and #10 should be “SEAN GUINESS�? with 599 rentals)

SELECT a.first_name || ' ' || a.last_name, count(r.rental_id) as times_rented
        FROM actor a
        INNER JOIN film_actor fa
                ON a.actor_id = fa.actor_id
        INNER JOIN film f
                ON fa.film_id = f.film_id
        INNER JOIN inventory i
                ON f.film_id = i.film_id
        INNER JOIN rental r
                ON i.inventory_id = r.inventory_id
GROUP BY a.actor_id
ORDER BY times_rented DESC
LIMIT 10;               

-- 20. The top 5 “Comedy�? actors ranked by number of rentals of films in the “Comedy�? category starring that actor
-- (#1 should have 87 rentals and #5 should have 72 rentals)

SELECT a.first_name || ' ' || a.last_name, count(r.rental_id) as times_rented
        FROM actor a
        INNER JOIN film_actor fa
                ON a.actor_id = fa.actor_id
        INNER JOIN film f
                ON fa.film_id = f.film_id
        INNER JOIN film_category fc
                ON f.film_id = fc.film_id
        INNER JOIN category c
                ON fc.category_id = c.category_id       
        INNER JOIN inventory i
                ON f.film_id = i.film_id
        INNER JOIN rental r
                ON i.inventory_id = r.inventory_id
WHERE c.name = 'Comedy'
GROUP BY a.actor_id
ORDER BY times_rented DESC
LIMIT 5;
