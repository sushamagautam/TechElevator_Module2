-- INSERT

//SELECT * FROM countrylanguage;

-- 1. Add Klingon as a spoken language in the USA

--SELECT COUNT(*) FROM countrylanguage;

INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ( 'USA', 'Klingon', false, 0.1);

--SELECT COUNT(*) FROM countrylanguage;

-- 2. Add Klingon as a spoken language in Great Britain (GBR)

INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ( 'GBR', 'Klingon', false, 0.3);

--SELECT COUNT(*) FROM countrylanguage;

-- UPDATE

-- 1. Update the capital of the USA to Houston

--SELECT * FROM city WHERE name = 'Houston';

UPDATE country
SET capital = 3796
WHERE code = 'USA';

--SELECT * FROM country WHERE capital = 3796;

// ALTERNATE FORM: NO HARD CODING OF ID VALUES
// LIABILITY: WILL FAIL IF THERE IS MORE THAN ONE "Houston"!

UPDATE country
SET capital = (SELECT id FROM city WHERE name = 'Houston')
WHERE code = 'USA';

--SELECT * FROM country WHERE capital = 3796;

-- 2. Update the capital of the USA to Washington DC and the head of state to ????

SELECT * FROM country WHERE capital = 3813;

UPDATE country
SET 
        capital = 3813,
        headofstate = 'Princess Peach'
WHERE code = 'USA';

SELECT * FROM country WHERE capital = 3813;

-- DELETE

-- 1. Delete English as a spoken language in the USA

--SELECT * FROM countrylanguage WHERE countrycode = 'USA';

DELETE FROM countrylanguage
WHERE 
        countrycode = 'USA'
        AND
        language = 'English';
        
SELECT * FROM countrylanguage WHERE countrycode = 'USA';        

-- 2. Delete all occurrences of the Klingon language 

--SELECT * FROM countrylanguage WHERE language = 'Klingon';    

DELETE FROM countrylanguage
WHERE 
        language = 'Klingon';
        
--SELECT * FROM countrylanguage WHERE language = 'Klingon';            

/***********************************************************************************/
/* Referential Integrity                                                           */
/***********************************************************************************/
--We learned that databases can have relationships established between tables using primary and foreign keys.
--Referential integrity ensures that relationships between tables remain consistent.

--We enforce referential integrity and other rules by applying constraints to our tables.
--Table Constraints
--A constraint is associated with a table and defines properties that the column data must comply with.

--Types of Constraints
--NOT NULL
--UNIQUE
--PRIMARY KEY - allows FKs to establish a relationship, and enforces NOT NULL and UNIQUE,
--FOREIGN KEY - enforces valid PK values, and limits deletion of the PK row if FK row exists
--CHECK - specifies acceptable values that can be entered in the column
--DEFAULT - provides a default value for the column
/***********************************************************************************/


-- REFERENTIAL INTEGRITY

-- 1. Try just adding Elvish to the country language table.

/* FAILS */
INSERT INTO countrylanguage ( language ) VALUES ('Elvish');

-- 2. Try inserting English as a spoken language in the country ZZZ. What happens?

/* FAILS */
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage) VALUES ('ZZZ', 'English', false, 0.0);

-- 3. Try deleting the country USA. What happens?

DELETE FROM country WHERE code = 'USA';


-- CONSTRAINTS

-- 1. Try inserting English as a spoken language in the USA

INSERT INTO countrylanguage (countrycode, language, isofficial, percentage) VALUES ('USA', 'English', true, 82.6);

-- 2. Try again. What happens?

INSERT INTO countrylanguage (countrycode, language, isofficial, percentage) VALUES ('USA', 'English', true, 82.6);

-- 3. Let's relocate the USA to the continent - 'Outer Space'

SELECT * FROM country WHERE code = 'USA';

UPDATE country SET continent = 'Outer Space' WHERE code = 'USA';

-- How to view all of the constraints

SELECT pg_constraint.*
FROM pg_catalog.pg_constraint
INNER JOIN pg_catalog.pg_class ON pg_class.oid = pg_constraint.conrelid
INNER JOIN pg_catalog.pg_namespace ON pg_namespace.oid = connamespace;


-- TRANSACTIONS

-- 1. Try deleting all of the rows from the country language table and roll it back.

BEGIN TRANSACTION;

        SELECT COUNT(*) AS starting_point FROM countrylanguage;

        DELETE FROM countrylanguage;

        SELECT COUNT(*) AS post_delete FROM countrylanguage;

ROLLBACK;

SELECT COUNT(*) AS post_rollback FROM countrylanguage;


-- 2. Try updating all of the cities to be in the USA and roll it back

BEGIN TRANSACTION;

        SELECT countrycode, COUNT(*) FROM city GROUP BY countrycode;

        UPDATE city SET countrycode = 'USA';
        
        SELECT countrycode, COUNT(*) FROM city GROUP BY countrycode;

ROLLBACK;

        SELECT countrycode, COUNT(*) FROM city GROUP BY countrycode;

-- 3. Demonstrate two different SQL connections trying to access the same table where one happens to be inside of a transaction but hasn't committed yet.

BEGIN TRANSACTION;

        SELECT countrycode, COUNT(*) FROM city GROUP BY countrycode;

        UPDATE city SET countrycode = 'USA';
        
        SELECT countrycode, COUNT(*) FROM city GROUP BY countrycode;

ROLLBACK;

        SELECT countrycode, COUNT(*) FROM city GROUP BY countrycode;









