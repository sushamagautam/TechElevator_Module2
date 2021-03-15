-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The
-- countrycode is 'USA', and population of 45001.
BEGIN TRANSACTION;

INSERT INTO city (name, district, countrycode, population)
        VALUES ('Smallville', 'Kansas', 'USA', 45001);

ROLLBACK;
  
--SELECT * FROM city WHERE name = 'Smallville';
        
-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.
BEGIN TRANSACTION;

INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ('USA', 'Kryptonese', false, 0.0001);

ROLLBACK;

--SELECT * FROM countrylanguage WHERE language = 'Kryptonese';

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble." Change
-- the appropriate record accordingly.

BEGIN TRANSACTION;

UPDATE countrylanguage
        SET language = 'Krypto-babble'
        WHERE language = 'Kryptonese';

ROLLBACK;
        
--SELECT * from countrylanguage WHERE countrycode = 'USA';      

-- 4. Set the US capital to Smallville, Kansas in the country table.

UPDATE country
        SET capital = 4080
        WHERE code = 'USA';
        
--SELECT name FROM city WHERE id = 4080;

-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

--DELETE FROM city
--WHERE name = 'Smallville'
--        AND city = 'Kansas';
        
--It doesn't succeed. IT violates the foreign key constraint

-- 6. Return the US capital to Washington.

UPDATE country
        SET capital = (SELECT id FROM city WHERE name = 'Washington' AND district = 'District of Columbia')
WHERE code = 'USA';

--SELECT * FROM country WHERE code = 'USA';

-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

BEGIN TRANSACTION;

DELETE FROM city
WHERE name = 'Smallville'
        AND district = 'Kansas';

COMMIT;
        
--SELECT name FROM city WHERE name = 'Smallville' AND district = 'Kansas';

-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972
-- (exclusive).
-- (590 rows affected)

--Check before
--SELECT c.name, cl.language, cl.isofficial 
--        FROM countrylanguage as cl
--                INNER JOIN country as c
--                ON cl.countrycode = c.code
--WHERE c.indepyear BETWEEN 1800 AND 1972
--        ORDER BY c.indepyear
--    LIMIT 5;
--    
--reverses the isofficial
UPDATE countrylanguage
        SET isofficial = NOT isofficial
        WHERE countrycode IN (SELECT code FROM country WHERE indepyear BETWEEN 1800 and 1972);    
        
--check after reversing
--SELECT c.name, cl.language, cl.isofficial 
--        FROM countrylanguage as cl
--                INNER JOIN country as c
--                ON cl.countrycode = c.code
--WHERE c.indepyear BETWEEN 1800 AND 1972
--        ORDER BY cl.countrycode
--    LIMIT 10;

-- 9. Convert population so it's expressed in 1,000s for all cities. (Round up to
-- the nearest integer value.)
-- (4079 rows affected)

BEGIN TRANSACTION;
SELECT population, name FROM city ORDER BY population DESC;
       


UPDATE city SET population = ROUND(population / 1000);
   
       
SELECT population , name FROM city ORDER BY population DESC;
     


ROLLBACK;


-- 10. Assuming a country's surfacearea is expressed in square miles, convert it to
-- square meters for all countries where French is spoken by more than 20% of the
-- population.
-- (7 rows affected)

BEGIN TRANSACTION;
/*SELECT l.countrycode, co.surfacearea, l.language, l.percentage
        FROM countrylanguage l
        INNER JOIN country co
                ON co.code = l.countrycode
WHERE language = 'French'
        AND percentage > 20
        ORDER BY co.surfacearea DESC;*/

UPDATE country
        SET surfacearea = surfacearea * (2.59)
WHERE code IN (SELECT countrycode FROM countrylanguage WHERE language = 'French' AND percentage > 20);

/*SELECT l.countrycode, co.surfacearea, l.language, l.percentage
        FROM countrylanguage l
        INNER JOIN country co
                ON co.code = l.countrycode
WHERE language = 'French'
        AND percentage > 20
        ORDER BY co.surfacearea DESC;
        */
ROLLBACK;
