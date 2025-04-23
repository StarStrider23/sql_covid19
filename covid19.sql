USE covid19;

SELECT *
FROM covid19;

-- For some reason, as I've noticed by doing the project the world's population is the 
-- same as the population of Asia. This needs to be fixed and can be achieved pretty 
-- easily by summing the population of the 6 continents: Africa, Asia, Europe, North 
-- America, Oceania and South America. But first, let's duplicate the table and work 
-- with the copy. If anything goes wrong along the way, we always have the original left.

SET SQL_SAFE_UPDATES = 0;

CREATE TABLE covid19_copy
LIKE covid19;

INSERT covid19_copy
SELECT *
FROM covid19;

SELECT *
FROM covid19_copy;

-- However, notice also that the population of Asia is roughly 2.1 billion 
-- according to the table. However this is now even the population of China and India
-- combined! So something is definetely wrong here. Let's sum the population 
-- of all countries in the region and see what we'll get.

SELECT SUM(temp_table.population) AS Asia_population
FROM (SELECT DISTINCT country, population FROM covid19_copy 
      WHERE continent = 'Asia') AS temp_table;
      
-- Which is 2.2 times bigger. Let's correct the old value.

UPDATE covid19_copy
SET population = 4746327240
WHERE country = 'Asia';

-- Finally, population of the World = 
-- = population Africa + Asia + Europe + North America + Oceania + South America

SELECT SUM(temp_table.population) AS sum_people_6_continents
FROM (SELECT DISTINCT continent, country, population
FROM covid19_copy
WHERE country = 'Africa' OR country = 'Asia' OR country = 'Europe' OR
      country = 'North America' OR country = 'South America' OR 
      country = 'Oceania') AS temp_table;

UPDATE covid19_copy
SET population = 8021397003
WHERE country = 'World';

-- Now, the world's population should be correct.

-- Total infected vs deceased, infected vs population, deceased vs population (worldwide)

SELECT country, population, MAX(total_cases) AS total_cases, MAX(total_deaths) AS total_deaths,
       MAX(total_deaths)/MAX(total_cases) * 100 AS probability_dying_if_sick,
       MAX(total_cases)/population * 100 AS procent_infected, 
       MAX(total_deaths)/population * 100 AS procent_deceased
FROM covid19_copy
WHERE country = 'World'
GROUP BY country, population;

-- Total infected vs deceased, infected vs population, deceased vs population (per continent)

SELECT country AS continent, population, MAX(total_cases) AS total_cases, MAX(total_deaths) AS total_deaths,
       MAX(total_deaths)/MAX(total_cases) * 100 AS probability_dying_if_sick,
       MAX(total_cases)/population * 100 AS procent_infected, 
       MAX(total_deaths)/population * 100 AS procent_deceased
FROM covid19
WHERE country = 'Africa' OR country = 'Asia' OR country = 'Europe' OR
      country = 'North America' OR country = 'South America' OR country = 'Oceania'
GROUP BY country, population;

-- Total infected vs deceased, infected vs population, deceased vs population (per country)

SELECT country, population, MAX(total_cases) AS total_cases, MAX(total_deaths) AS total_deaths,
       MAX(total_deaths)/MAX(total_cases) * 100 AS probability_dying_if_sick,
       MAX(total_cases)/population * 100 AS procent_infected, 
       MAX(total_deaths)/population * 100 AS procent_deceased
FROM covid19
WHERE continent <> ''
GROUP BY country, population;
-- ORDER BY probability_dying_if_sick / procent_infected / procent__deceased ; 
-- If needed order by desired metric

-- Top 10 countries with highest infected vs deceased ratio per continent

-- CREATE VIEW inf_vs_dec AS
CREATE VIEW inf_vs_dec AS
WITH cte_inf_vs_dec AS (
     SELECT country, continent, MAX(total_cases) AS total_cases, 
     MAX(total_deaths) AS total_deaths, 
     MAX(total_deaths)/MAX(total_cases) * 100 AS probability_dying_if_sick,
	 ROW_NUMBER() OVER(PARTITION BY continent
     ORDER BY MAX(total_deaths)/MAX(total_cases) * 100 DESC) AS row_num
     FROM covid19
     WHERE continent <> ''
     GROUP BY continent, country
)
SELECT row_num, country, continent, probability_dying_if_sick, total_cases, total_deaths
FROM cte_inf_vs_dec
WHERE row_num <= 10;

-- Top 10 countries with highest infected vs population ratio per continent

-- CREATE VIEW inf_vs_pop AS
WITH cte_inf_vs_pop AS (
     SELECT country, continent, MAX(total_cases) AS total_cases, 
     population, MAX(total_cases)/population * 100 AS procent_infected,
	 ROW_NUMBER() OVER(PARTITION BY continent
     ORDER BY MAX(total_cases)/population * 100 DESC) AS row_num
     FROM covid19
     WHERE continent <> ''
     GROUP BY continent, country, population
)
SELECT row_num, country, continent, procent_infected, population, total_cases
FROM cte_inf_vs_pop
WHERE row_num <= 10;

-- Top 10 countries with highest deceased vs population ratio per continent

-- CREATE VIEW dec_vs_pop AS
CREATE VIEW dec_vs_pop AS
WITH cte_dec_vs_pop AS (
     SELECT country, continent, MAX(total_deaths) AS total_deaths, 
     population, MAX(total_deaths)/population * 100 AS procent_deceased,
	 ROW_NUMBER() OVER(PARTITION BY continent
     ORDER BY MAX(total_deaths)/population * 100 DESC) AS row_num
     FROM covid19
     WHERE continent <> ''
     GROUP BY continent, country, population
)
SELECT row_num, country, continent, procent_deceased, population, total_deaths
FROM cte_dec_vs_pop
WHERE row_num <= 10; 

-- How many countries are in the top 10s in all categories?
-- Make sure to make views first!

SELECT dec_vs_pop.country, dec_vs_pop.continent
FROM dec_vs_pop
INTERSECT
SELECT inf_vs_pop.country, inf_vs_pop.continent
FROM inf_vs_pop
INTERSECT 
SELECT inf_vs_dec.country, inf_vs_dec.continent
FROM inf_vs_dec;

-- Vaccinations

-- World

SELECT country, MAX(people_vaccinated)/population * 100 AS procent_vaccinated, 
       MAX(people_fully_vaccinated)/population * 100 AS procent_fully_vaccinated
FROM covid19_copy
WHERE country = 'World'
GROUP BY country, population;

-- Continents

SELECT country AS continent, MAX(people_vaccinated)/population * 100 AS procent_vaccinated, 
       MAX(people_fully_vaccinated)/population * 100 AS procent_fully_vaccinated
FROM covid19_copy
WHERE country = 'Africa' OR country = 'Asia' OR country = 'Europe' OR
      country = 'North America' OR country = 'South America' OR country = 'Oceania'
GROUP BY country, population;

-- Countries

SELECT country, MAX(people_vaccinated)/population * 100 AS procent_vaccinated, 
       MAX(people_fully_vaccinated)/population * 100 AS procent_fully_vaccinated
FROM covid19_copy
WHERE continent <> ''
GROUP BY country, population;

-- Top 10 countries with highest vaccinated vs population ratio per continent

-- CREATE VIEW vac_vs_pop AS
WITH cte_vac_vs_pop AS (
SELECT country, continent, MAX(people_vaccinated) AS people_vaccinated, 
     population, MAX(people_vaccinated)/population * 100 AS procent_vaccinated,
	 ROW_NUMBER() OVER(PARTITION BY continent
     ORDER BY MAX(people_vaccinated)/population * 100 DESC) AS row_num
     FROM covid19
     WHERE continent <> '' AND people_vaccinated > 0
     GROUP BY continent, country, population
)
SELECT row_num, country, continent, procent_vaccinated, population
FROM cte_vac_vs_pop
WHERE row_num <= 5;

-- Top 10 countries with highest fully vaccinated vs population ratio per continent

-- CREATE VIEW vac_f_vs_pop AS
WITH cte_vac_vs_pop AS (
SELECT country, continent, MAX(people_fully_vaccinated) AS people_fully_vaccinated, 
     population, MAX(people_fully_vaccinated)/population * 100 AS procent_fully_vaccinated,
	 ROW_NUMBER() OVER(PARTITION BY continent
     ORDER BY MAX(people_fully_vaccinated)/population * 100 DESC) AS row_num
     FROM covid19
     WHERE continent <> '' AND people_vaccinated > 0
     GROUP BY continent, country, population
)
SELECT row_num, country, continent, procent_fully_vaccinated
FROM cte_vac_vs_pop
WHERE row_num <= 5;

-- In both tables, one can notice that Gibraltar, Nauru and Cook Islands have 
-- values greater than 100%. Other than that, the data seems to be fine.

-- Any countries that are in both top 5s?
-- Don't forget to create views first!

SELECT vac_vs_pop.country, vac_vs_pop.continent
FROM vac_vs_pop
INTERSECT
SELECT vac_f_vs_pop.country, vac_f_vs_pop.continent
FROM vac_f_vs_pop;

-- Let's investigate correlation between number of people infected and people dying 
-- each month throughtout the years 2020 - 2024 and total people vaccinated.

-- CREATE VIEW vac AS
WITH cte_vac AS (
     SELECT country, SUM(new_deaths) AS new_deaths_month,
            SUM(new_cases) AS new_cases_month,
            MAX(people_vaccinated) AS total_people_vaccinated,
            MONTH(date) AS month, YEAR(date) AS year
     FROM covid19_copy
     WHERE country = 'World' AND YEAR(date) < 2025
     GROUP BY MONTH(date), YEAR(date)
)
SELECT country, new_cases_month, new_deaths_month, 
       total_people_vaccinated, month, year
FROM cte_vac
GROUP BY month, year;

-- One could argue that there exists some correlation. But let's calucalte Pearson
-- correlation coefficient.

-- total people vaccinated vs new cases of people getting infected each month

SELECT 
    (COUNT(*) * SUM(new_cases_month * total_people_vaccinated) - SUM(new_cases_month) * SUM(total_people_vaccinated)) /
    (SQRT(COUNT(*) * SUM(POWER(new_cases_month, 2)) - POWER(SUM(new_cases_month), 2)) *
     SQRT(COUNT(*) * SUM(POWER(total_people_vaccinated, 2)) - POWER(SUM(total_people_vaccinated), 2)))
    AS correlation_coefficient
FROM vac;

-- total people vaccinated vs new cases of people deceased each month

SELECT 
    (COUNT(*) * SUM(new_deaths_month * total_people_vaccinated) - SUM(new_deaths_month) * SUM(total_people_vaccinated)) /
    (SQRT(COUNT(*) * SUM(POWER(new_deaths_month, 2)) - POWER(SUM(new_deaths_month), 2)) *
     SQRT(COUNT(*) * SUM(POWER(total_people_vaccinated, 2)) - POWER(SUM(total_people_vaccinated), 2)))
    AS correlation_coefficient
FROM vac_world;

-- What about other correlations?

-- How about correlation between HDI (Human Development Index) and procent infected/deceased?

SELECT country, MAX(total_deaths)/population * 100 AS procent_deceased, 
       human_development_index AS HDI,
       MAX(total_cases)/population * 100 AS procent_infected
FROM covid19_copy
WHERE continent <> '' AND human_development_index > 0 AND total_cases > 0
GROUP BY country, population, human_development_index
ORDER BY human_development_index;

-- Pearson correlation coefficient
-- Procent deceased vs HDI

SELECT 
    (COUNT(*) * SUM(procent_deceased * HDI) - SUM(procent_deceased) * SUM(HDI)) /
    (SQRT(COUNT(*) * SUM(POWER(procent_deceased, 2)) - POWER(SUM(procent_deceased), 2)) *
     SQRT(COUNT(*) * SUM(POWER(HDI, 2)) - POWER(SUM(HDI), 2)))
    AS correlation_coefficient
FROM (SELECT country, MAX(total_deaths)/population * 100 AS procent_deceased, 
       human_development_index AS HDI,
       MAX(total_cases)/population * 100 AS procent_infected
FROM covid19_copy
WHERE continent <> '' AND human_development_index > 0 AND total_cases > 0
GROUP BY country, population, human_development_index
ORDER BY human_development_index) AS temp_table;

-- Procent infected vs HDI

SELECT 
    (COUNT(*) * SUM(procent_infected * HDI) - SUM(procent_infected) * SUM(HDI)) /
    (SQRT(COUNT(*) * SUM(POWER(procent_infected, 2)) - POWER(SUM(procent_infected), 2)) *
     SQRT(COUNT(*) * SUM(POWER(HDI, 2)) - POWER(SUM(HDI), 2)))
    AS correlation_coefficient
FROM (SELECT country, MAX(total_deaths)/population * 100 AS procent_deceased, 
       human_development_index AS HDI,
       MAX(total_cases)/population * 100 AS procent_infected
FROM covid19_copy
WHERE continent <> '' AND human_development_index > 0 AND total_cases > 0
GROUP BY country, population, human_development_index
ORDER BY human_development_index) AS temp_table;