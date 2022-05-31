SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000.0
;



SELECT title, imdb_score
FROM films
JOIN reviews
ON films.id = reviews.film_id
WHERE title = 'To Kill a Mockingbird';

SELECT p1.country, p1.continent, prime_minister, president
FROM prime_ministers AS p1
INNER JOIN presidents AS p2
ON p1.country = p2.country;



-- Select name fields (with alias) and region 
SELECT cities.name AS city, countries.name AS country, countries.region
FROM cities 
  INNER JOIN countries
    ON cities.country_code = countries.code;


SELECT c.code AS country_code, name, e.year, e.inflation_rate
FROM countries AS c
INNER JOIN economies AS e
ON c.code = e.code;




SELECT c.code, name, region, e.year, p.fertility_rate, e.unemployment_rate
  FROM countries AS c
  INNER JOIN populations AS p
    ON c.code = p.country_code
  INNER JOIN economies AS e
    ON c.code = e.code;


SELECT c.code, name, region, e.year, p.fertility_rate, e.unemployment_rate
  FROM countries AS c
  INNER JOIN populations AS p
    ON c.code = p.country_code
  INNER JOIN economies AS e
    ON c.code = e.code AND e.year = p.year;

USING(column);



    SELECT c.name AS country, continent, l.name AS language, l.official
    FROM countries AS c
    INNER JOIN languages AS l
    USING (code);


SELECT p1.country AS country1, p2.country AS country2, p1.continent
FROM prime_ministers AS p1
INNER JOIN prime_minsters AS p2
ON p1.continent = p2.continent AND p1.country <> p2.country
LIMIT 13;

CASE WHEN THEN;

SELECT name, continent, indep_year,
	CASE WHEN indep_year < 1900 THEN 'before 1900'
		WHEN indep_year <= 1930 THEN 'between 1900 and 1930'
		ELSE 'after 1930' END
		AS indep_year_group
FROM states
ORDER BY indep_year_group;





SELECT 
  p1.country_code, p1.size AS size2010,
  p2.country_code, p2.size AS size2015 
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code



SELECT 
  p1.country_code, p1.size AS size2010,
  p2.size AS size2015,
  ((p2.size - p1.size)/p1.size * 100.0) AS growth_perc
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code AND p1.year = p2.year - 5;



SELECT name, continent, code, surface_area,
CASE WHEN surface_area > 2000000 THEN 'large'
WHEN surface_area > 350000 AND surface_area < 2000000 THEN 'medium'
ELSE 'small' END
AS geosize_group
FROM countries
ORDER BY name;


INTO FROM 



SELECT name, continent, code, surface_area,
    CASE WHEN surface_area > 2000000
            THEN 'large'
       WHEN surface_area > 350000
            THEN 'medium'
       ELSE 'small' END
       AS geosize_group
INTO countries_plus
FROM countries;


SELECT  country_code, size,
CASE WHEN size > 50000000 THEN 'large'
WHEN size > 1000000 AND size < 50000000 THEN 'medium'
ELSE 'small' END
AS popsize_group
FROM populations
WHERE year =  2015;



SELECT country_code, size,
    CASE WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' END
        AS popsize_group
INTO pop_plus
FROM populations
WHERE year = 2015;

SELECT * FROM pop_plus;



SELECT country_code, size,
  CASE WHEN size > 50000000
            THEN 'large'
       WHEN size > 1000000
            THEN 'medium'
       ELSE 'small' END
       AS popsize_group
INTO pop_plus       
FROM populations
WHERE year = 2015;
SELECT name, continent, geosize_group, popsize_group
FROM countries_plus AS c
INNER JOIN pop_plus AS p
ON c.code = p.country_code
ORDER BY geosize_group ASC; 
