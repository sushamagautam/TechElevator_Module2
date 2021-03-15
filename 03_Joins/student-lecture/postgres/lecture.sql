-- ********* INNER JOIN ***********

-- Let's find out who made payment 16666:

SELECT P.payment_id, C.*
FROM Payment as P
        INNER JOIN Customer as C
                ON P.customer_id = C.Customer_id
LIMIT 20;


-- Ok, that gives us a customer_id, but not the name. We can use the customer_id to get the name FROM the customer table

SELECT *
FROM Payment as P
        INNER JOIN Customer as C
                ON P.customer_id = C.Customer_id
WHERE P.payment_id = 16666;

-- We can see that the * pulls back everything from both tables. We just want everything from payment and then the first and last name of the customer:

SELECT P.*, C.first_name, C.last_name
FROM Payment as P
        INNER JOIN Customer as C
                ON P.customer_id = C.Customer_id
WHERE P.payment_id = 16666;

-- But when did they return the rental? Where would that data come from? From the rental table, so let’s join that.

SELECT P.*, C.first_name, C.last_name, R.*
FROM Payment as P
        INNER JOIN Customer as C
                ON P.customer_id = C.Customer_id
        INNER JOIN Rental as R
                ON P.rental_id = R.rental_id
WHERE P.payment_id = 16666;
//or
SELECT payment.*, customer.first_name, customer.last_name, rental.return_date 
FROM payment 
        JOIN customer 
                ON payment.customer_id = customer.customer_id
        JOIN rental 
                ON rental.rental_id = payment.rental_id
WHERE payment_id = 16666


-- What did they rent? Film id can be gotten through inventory.

SELECT P.*, C.first_name, C.last_name, R.rental_date, R.return_date, I.*
FROM Payment as P
        INNER JOIN Customer as C
                ON P.customer_id = C.Customer_id
        INNER JOIN Rental as R
                ON P.rental_id = R.rental_id
                INNER JOIN Inventory as I
                        ON R.inventory_id = I.inventory_id
                        
WHERE P.payment_id = 16666;

SELECT payment.*, customer.first_name, customer.last_name, rental.return_date, film.title 
FROM payment JOIN customer ON payment.customer_id = customer.customer_id
JOIN rental ON rental.rental_id = payment.rental_id
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film ON film.film_id = inventory.film_id
WHERE payment_id = 16666

-- What if we wanted to know who acted in that film?

SELECT P.*, C.first_name, C.last_name, R.rental_date, R.return_date, F.title, A.*
FROM Payment as P
        INNER JOIN Customer as C
                ON P.customer_id = C.Customer_id
        INNER JOIN Rental as R
                ON P.rental_id = R.rental_id
                INNER JOIN Inventory as I
                        ON R.inventory_id = I.inventory_id
                        INNER JOIN Film as F
                              ON I.film_id = F.film_id
                              INNER JOIN Film_Actor as FA
                                        ON F.film_id = FA.film_id
                                        INNER JOIN Actor as A
                                        ON FA.actor_id = A.actor_id
                        
WHERE P.payment_id = 16666;

-- What if we wanted a list of all the films and their categories ordered by film title

SELECT F.title,  C.name
FROM Film as F
        INNER JOIN Film_Category as FC
                ON F.film_id = FC.film_id
                INNER JOIN category as c
                        ON FC.category_id = C.category_id
ORDER BY
        F.title;
                        

-- Show all the 'Comedy' films ordered by film title

SELECT F.title, F.description, C.name
FROM Film as F
        INNER JOIN Film_Category as FC
                ON F.film_id = FC.film_id
                INNER JOIN category as C
                        ON FC.category_id = C.category_id
WHERE
        C.name = 'Comedy'
ORDER BY
        F.title;


-- Finally, let's count the number of films under each category

SELECT C.name, COUNT(C.name)
FROM Film as F
        JOIN FILM_Category as FC
                ON F.film_id = FC.film_id
                JOIN category as C
                        ON FC.category_id = C.category_id
GROUP BY
        C.name
ORDER BY 
        C.name;

-- ********* LEFT JOIN ***********

-- (There aren't any great examples of left joins in the "dvdstore" database, so the following queries are for the "world" database)

-- A Left join, selects all records from the "left" table and matches them with records from the "right" table if a matching record exists.

-- Let's display a list of all countries and their capitals, if they have some.

-- Only 232 rows
-- But we’re missing entries:

-- There are 239 countries. So how do we show them all even if they don’t have a capital?
-- That’s because if the rows don’t exist in both tables, we won’t show any information for it. If we want to show data FROM the left side table everytime, we can use a different join:

-- *********** UNION *************

-- Back to the "dvdstore" database...

-- Gathers a list of all first names used by actors and customers
-- By default removes duplicates

-- Gather the list, but this time note the source table with 'A' for actor and 'C' for customer
