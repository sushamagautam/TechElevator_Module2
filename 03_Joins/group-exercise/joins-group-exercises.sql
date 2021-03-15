-- Write queries to return the following:
-- The following queries utilize the "world" database.

-- 1. The city name, country name, and city population of all cities in Europe with population greater than 1 million
-- (36 rows)

SELECT C.name as city_name, CO.name as Country_name, C.population
        FROM city as C
        INNER JOIN country as CO
                ON C.countrycode = CO.code
WHERE CO.continent = 'Europe' AND C.population > 1000000;

-- 2. The city name, country name, and city population of all cities in countries where French is an official language and the city population is greater than 1 million
-- (2 rows)

SELECT C.name as french_city_name, CO.name as country_name, C.population
        FROM city as C
        INNER JOIN country CO
        ON C.countrycode = CO.code
                INNER JOIN countrylanguage as CL
                ON CO.code = CL.countrycode
WHERE (CL.language = 'French' AND isofficial)
        AND C.population > 1000000;

-- 3. The name of the countries and continents where the language Javanese is spoken
-- (1 row)

SELECT CO.name, CO.continent
        FROM country CO
        INNER JOIN countrylanguage as CL
                ON CO.code = CL.countrycode
WHERE CL.language = 'Javanese';

-- 4. The names of all of the countries in Africa that speak French as an official language
-- (5 row)

SELECT CO.name 
        FROM country CO
        INNER JOIN countrylanguage as CL
        ON CO.code = CL.countrycode
WHERE CL.language = 'French'
        AND isofficial
        AND CO.continent = 'Africa';

-- 5. The average city population of cities in Europe
-- (average city population in Europe: 287,684)

SELECT floor(avg(C.population)) as avg_population_Europe
        FROM city C
        INNER JOIN country CO
                ON C.countrycode = CO.code
WHERE CO.continent = 'Europe';

-- 6. The average city population of cities in Asia
-- (average city population in Asia: 395,019)

SELECT round(avg(C.population)) as avg_population_Asia
        FROM city C
        INNER JOIN country CO
                ON C.countrycode = CO.code
WHERE CO.continent = 'Asia';

-- 7. The number of cities in countries where English is an official language
-- (number of cities where English is official language: 523)

SELECT COUNT(*)
        FROM city as C
        INNER JOIN country as CO
                ON C.countrycode = CO.code
        INNER JOIN countrylanguage as CL
        ON CO.code = CL.countrycode
WHERE CL.language = 'English' AND CL.isofficial;

-- 8. The average population of cities in countries where the official language is English
-- (average population of cities where English is official language: 285,809)

SELECT round(AVG(C.population)) as avg_population_of_eng_speaking_city
        FROM city as C
                INNER JOIN country as CO
                ON C.countrycode = CO.code
                        INNER JOIN countrylanguage as CL
                        ON CO.code = CL.countrycode
WHERE CL.language = 'English' AND CL.isofficial;
        

-- 9. The names of all of the continents and the population of the continent’s largest city
-- (6 rows, largest population for North America: 8,591,309)

SELECT CO.continent, MAX(C.population)
        FROM country CO
        INNER JOIN city as C
                ON C.countrycode = CO.code
GROUP BY CO.continent
      ORDER BY 2 DESC;

-- 10. The names of all of the cities in South America that have a population of more than 1 million people and the official language of each city’s country
-- (29 rows)

SELECT C.name, CL.language
        FROM city as C
        INNER JOIN country CO
                ON C.countrycode = CO.code
                INNER JOIN countrylanguage as CL        
                        ON CO.code = CL.countrycode
WHERE C.population > 1000000
        AND CO.continent = 'South America' AND CL.isofficial;