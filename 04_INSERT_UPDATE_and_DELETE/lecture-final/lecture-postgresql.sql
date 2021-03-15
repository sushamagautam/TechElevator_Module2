-- INSERT

-- 1. Add Klingon as a spoken language in the USA
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ('USA', 'Klingon', false, 0.01);

-- 2. Add Klingon as a spoken language in Great Britain (GBR)
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ('GBR', 'Klingon', false, 0.01);


-- UPDATE

-- 1. Update the capital of the USA to Houston
UPDATE country SET capital = 3796 WHERE code = 'USA';

-- 2. Update the capital of the USA to Washington DC and the head of state
UPDATE country SET capital = 3813, headofstate = 'Harry Potter' WHERE code = 'USA';


-- DELETE

-- 1. Delete English as a spoken language in the USA
DELETE FROM countrylanguage WHERE countrycode = 'USA' AND language = 'English';

-- 2. Delete all occurrences of the Klingon language 
DELETE FROM countrylanguage WHERE language = 'Klingon';


-- REFERENTIAL INTEGRITY

-- 1. Try just adding Elvish to the country language table.
INSERT INTO countrylanguage (language)
VALUES ('Elvish');

-- 2. Try inserting English as a spoken language in the country ZZZ. What happens?
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ('ZZZ', 'English', false, 0.01);

-- 3. Try deleting the country USA. What happens?
DELETE FROM country WHERE code = 'USA';


-- CONSTRAINTS

-- 1. Try inserting English as a spoken language in the USA
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ('USA', 'English', true, 86.2);

-- 2. Try again. What happens?
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ('USA', 'English', true, 86.2);

-- 3. Let's relocate the USA to the continent - 'Outer Space'
UPDATE country SET continent = 'Outer Space' WHERE code = 'USA';


-- How to view all of the constraints

SELECT pg_constraint.*
FROM pg_catalog.pg_constraint
INNER JOIN pg_catalog.pg_class ON pg_class.oid = pg_constraint.conrelid
INNER JOIN pg_catalog.pg_namespace ON pg_namespace.oid = connamespace;


-- TRANSACTIONS

-- 1. Try deleting all of the rows from the country language table and roll it back.
START TRANSACTION;
DELETE FROM countrylanguage;
ROLLBACK;

-- 2. Try updating all of the cities to be in the USA and roll it back
START TRANSACTION;
UPDATE city SET countrycode = 'USA';
ROLLBACK TRANSACTION;


-- 3. Demonstrate two different SQL connections trying to access the same table where one happens to be inside of a transaction but hasn't committed yet.

/*
--run in a separate query tab/window
START TRANSACTION;
INSERT INTO city (name, countrycode, district, population) VALUES ('Schrodinger''s City', 'USA', 'Quantum State', 1);
--notice there's no COMMIT or ROLLBACK
*/

/* this statement won't return anything until COMMITed */
SELECT * FROM city WHERE name = 'Schrodinger''s City'
