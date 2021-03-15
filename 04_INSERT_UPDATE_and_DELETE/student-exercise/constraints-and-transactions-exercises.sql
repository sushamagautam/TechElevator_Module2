-- Write queries to return the following:
-- The following changes are applied to the "dvdstore" database.**

-- 1. Add actors, Hampton Avenue, and Lisa Byway to the actor table.

BEGIN TRANSACTION;

INSERT INTO actor (first_name, last_name)
        VALUES ('HAMPTON', 'AVENUE'), ('LISA', 'BYWAY');

--SELECT * FROM actor WHERE last_name = 'BYWAY' OR last_name = 'AVENUE';
    
ROLLBACK;



-- 2. Add "Euclidean PI", "The epic story of Euclid as a pizza delivery boy in
-- ancient Greece", to the film table. The movie was released in 2008 in English.
-- Since its an epic, the run length is 3hrs and 18mins. There are no special
-- features, the film speaks for itself, and doesn't need any gimmicks.

BEGIN TRANSACTION;
INSERT INTO film(title, description, release_year, language_id, length)
        VALUES ('Euclidean PI', 'The epic story of Euclid as a pizza delivery boy in ancient Greece', 2008, 1, 198);
        
--SELECT title, description, length, release_year, language_id 
  --      FROM film WHERE title = 'Euclidean PI';
        
ROLLBACK;

-- 3. Hampton Avenue plays Euclid, while Lisa Byway plays his slightly
-- overprotective mother, in the film, "Euclidean PI". Add them to the film.

BEGIN TRANSACTION;



INSERT INTO film_actor (actor_id, film_id)
     VALUES
        ((SELECT actor_id FROM actor WHERE first_name = 'HAMPTON'),
        (SELECT film_id FROM film WHERE title = 'EUCLIDEAN PI')),
        ((SELECT actor_id FROM actor WHERE last_name = 'BYWAY'),
        (SELECT film_id FROM film WHERE title = 'EUCLIDEAN PI'));

ROLLBACK;

/* THIS DATA WILL LINK THE ACTOR TABLE AND FILM TABLE USING THE ____TABLE_____ called _FILM_TABLE_____*/

-- 4. Add Mathmagical to the category table.

BEGIN TRANSACTION;
INSERT INTO category (name)
        VALUES ('Mathmagical');
   
--SELECT category_id, name FROM category;
            
ROLLBACK;

-- 5. Assign the Mathmagical category to the following films, "Euclidean PI",
-- "EGG IGBY", "KARATE MOON", "RANDOM GO", and "YOUNG LANGUAGE"

--SELECT film_id, title FROM film
  --      WHERE title = 'Euclidean PI' OR title = 'KARATE MOON' OR title ='RANDOM GO' OR title = 'YOUNG LANGUAGE';
        
--SELECT category_id, name FROM category WHERE name = 'Mathmagical';

BEGIN TRANSACTION;
        
UPDATE film_category
        SET category_id = 17
        WHERE film_id = 274 OR film_id = 494 OR film_id = 996 OR film_id = 1001 OR film_id = 1002;

--SELECT film_id, category_id FROM film_category WHERE category_id = 17;

ROLLBACK;

-- 6. Mathmagical films always have a "G" rating, adjust all Mathmagical films
-- accordingly.
-- (5 rows affected)

BEGIN TRANSACTION;
UPDATE film
        SET rating = 'G'
WHERE 
        film_id IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = 'Mathemagical'));
      
 
ROLLBACK;



-- 7. Add a copy of "Euclidean PI" to all the stores.

BEGIN TRANSACTION;

INSERT INTO inventory (store_id, film_id)
SELECT store_id, (SELECT film_id FROM film WHERE title = 'Euclidean PI')
        FROM store;
        
--SELECT inventory_id FROM inventory i INNER JOIN film f ON f.film_id = i.film_id
--WHERE f.title = 'Euclidean PI';

ROLLBACK;  

-- 8. The Feds have stepped in and have impounded all copies of the pirated film,
-- "Euclidean PI". The film has been seized from all stores, and needs to be
-- deleted from the film table. Delete "Euclidean PI" from the film table.
-- (Did it succeed? Why?)
-- <YOUR ANSWER HERE>

BEGIN TRANSACTION;

DELETE FROM film
WHERE title = 'Euclidean PI';

ROLLBACK;

--Will not delete because it violates the key constraint as it is referred in film_actor


-- 9. Delete Mathmagical from the category table.
-- (Did it succeed? Why?)
-- <YOUR ANSWER HERE>

BEGIN TRANSACTION;

DELETE FROM category
WHERE name = 'Mathmagical';

ROLLBACK;

--deleted because the key is referenced by film_category

-- 10. Delete all links to Mathmagical in the film_category tale.
-- (Did it succeed? Why?)
-- <YOUR ANSWER HERE>

BEGIN TRANSACTION;

DELETE FROM film_category
WHERE category_id IN (SELECT category_id FROM category WHERE name = 'Mathmagical');

COMMIT;



-- 11. Retry deleting Mathmagical from the category table, followed by retrying
-- to delete "Euclidean PI".
-- (Did either deletes succeed? Why?)
-- <YOUR ANSWER HERE>

BEGIN TRANSACTION;

DELETE FROM category
WHERE name = 'Euclidean PI';

COMMIT;


--It succeded because it is no longer key constrained by film_category

-- 12. Check database metadata to determine all constraints of the film id, and
-- describe any remaining adjustments needed before the film "Euclidean PI" can
-- be removed from the film table.

SELECT * 
FROM information_schema.referential_constraints
WHERE constraint_name = '%film_id%';





