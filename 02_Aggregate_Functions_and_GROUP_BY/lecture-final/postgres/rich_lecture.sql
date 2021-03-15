-- ORDERING RESULTS

-- Populations of all countries in descending order

SELECT name, population FROM country ORDER BY population DESC;

--Names of countries and continents in ascending order

SELECT name, continent FROM country ORDER BY  name ASC, continent ASC;

-- LIMITING RESULTS
-- The name and average life expectancy of the countries with the 10 highest life expectancies.

SELECT 
        name, 
        lifeexpectancy 
FROM 
        country 
WHERE 
        lifeexpectancy IS NOT null 
ORDER BY 
        lifeexpectancy DESC 
LIMIT 10;

/******************************************************************************************************************************/
-- SPECIAL EXAMPLE FOR JASMINE... AND EVERYONE ELSE ... SAME RESULTS TWO DIFFERENT IMPLICATIONS BASED ON THE NUMBER OF CONDITIONS. 
/******************************************************************************************************************************/

SELECT * FROM city WHERE countrycode = 'GBR' AND district IN ('Wales', 'Scotland', 'North Ireland');

SELECT * FROM city WHERE countrycode = 'GBR' AND (district = 'Wales' or district = 'Scotland' or district = 'North Ireland');

/******************************************************************************************************************************/

-- CONCATENATING OUTPUTS

-- The name & state of all cities in California, Oregon, or Washington.
-- "city, state", sorted by state then city

SELECT name || ', ' || district AS citystate FROM city WHERE district IN ('California', 'Oregon', 'Washington');

-- AGGREGATE FUNCTIONS
-- Average Life Expectancy in the World

SELECT AVG(lifeexpectancy) AS average_Life_Ex FROM country;

-- Total population in Ohio

SELECT SUM(population) as ohio_pop FROM city WHERE district = 'Ohio';

-- The surface area of the smallest country in the world

/* METHOD 1 */
SELECT name, surfacearea FROM country ORDER BY surfacearea LIMIT 1;

/* METHOD 2 */
SELECT MIN(surfacearea) FROM country;

/**** A "SUB QUERY" or "SUB SELECT" APPROACH TO METHOD #1 *****/

SELECT name, surfacearea FROM country WHERE surfacearea = (SELECT MIN(surfacearea) FROM country);

-- The 10 largest countries in the world

SELECT name, surfacearea FROM country ORDER BY surfacearea DESC LIMIT 1;

-- The number of countries who declared independence in 1991

/* COUNT(*) explicity shows we intend to count the number of rows */
SELECT * FROM country WHERE indepyear = 1991;

SELECT COUNT(*) as _1991_Countries FROM country WHERE indepyear = 1991;

/* HOW MANY UNIQUE or *DISTINCT* CONTINENTS HAD COUNTRIES DECLARED INDEP IN 1991? */
SELECT COUNT(DISTINCT continent) as _1991_Cont FROM country WHERE indepyear = 1991;


-- GROUP BY
-- Count the number of countries where each language is spoken, ordered from most countries to least

SELECT language, COUNT(countrycode) as countriesSpoken FROM countrylanguage GROUP BY language ORDER BY countriesSpoken DESC LIMIT 10;

-- Average life expectancy of each continent ordered from highest to lowest

SELECT continent, AVG(COALESCE(lifeexpectancy, 0)) AS avg_life_exp FROM country GROUP BY continent ORDER BY avg_life_exp DESC;

-- Exclude Antarctica from consideration for average life expectancy

SELECT continent, AVG(lifeexpectancy) AS avg_life_exp FROM country WHERE continent <> 'Antarctica' GROUP BY continent ORDER BY avg_life_exp DESC;

-- Sum of the population of cities in each state in the USA ordered by state name

SELECT district, SUM(population) AS tot_pop FROM city WHERE countrycode = 'USA' GROUP BY district ORDER BY district;

-- The average population of cities in each state in the USA ordered by state name

SELECT district, AVG(population) AS avg_pop FROM city WHERE countrycode = 'USA' GROUP BY district ORDER BY district;

-- HOW ABOUT BOTH??

SELECT district, SUM(population) AS tot_pop, AVG(population) AS avg_pop FROM city WHERE countrycode = 'USA' GROUP BY district ORDER BY district;

-- SUBQUERIES
-- Find the names of cities under a given government leader

SELECT name FROM city WHERE countrycode IN (SELECT code FROM country WHERE headofstate = 'Elisabeth II');

-- Find the names of cities whose country they belong to has not declared independence yet

SELECT name FROM city WHERE countrycode IN (SELECT code FROM country WHERE indepyear IS NULL);

-- /* BONUS FROM DENNIS */ Where under a head of state and speaks Welsh

SELECT * FROM countrylanguage WHERE language = 'Spanish'

SELECT 
        name 
FROM 
        city 
WHERE 
        countrycode IN 
                (SELECT code FROM country WHERE headofstate = 'Elisabeth II') 
        AND 
        countrycode IN 
                (SELECT countrycode FROM countrylanguage WHERE language = 'Spanish') ;

/***************************************/
/*        BONUS ADDITIONAL QUERIES     */
/***************************************/

-- Additional samples
-- You may alias column and table names to be more descriptive

-- Alias can also be used to create shorthand references, such as "c" for city and "co" for country.

-- Ordering allows columns to be displayed in ascending order, or descending order (Look at Arlington)

-- Limiting results allows rows to be returned in 'limited' clusters,where LIMIT says how many, and OFFSET (optional) specifies the number of rows to skip

-- Most database platforms provide string functions that can be useful for working with string data. In addition to string functions, string concatenation is also usually supported, which allows us to build complete sentences if necessary.

-- Aggregate functions provide the ability to COUNT, SUM, and AVG, as well as determine MIN and MAX. Only returns a single row of value(s) unless used with GROUP BY.

-- Counts the number of rows in the city table

-- Also counts the number of rows in the city table

-- Gets the SUM of the population field in the city table, as well as
-- the AVG population, and a COUNT of the total number of rows.

-- Gets the MIN population and the MAX population from the city table.

-- Using a GROUP BY with aggregate functions allows us to summarize information for a specific column. For instance, we are able to determine the MIN and MAX population for each countrycode in the city table.
