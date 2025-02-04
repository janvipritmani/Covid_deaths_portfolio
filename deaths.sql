select * FROM public.deaths


SELECT country, date, total_cases, population, total_deaths
FROM public.deaths
WHERE total_cases >0 
  AND total_deaths IS NOT NULL
  AND continent IS NOT NULL
ORDER BY country, date;

--Death rate
SELECT country, date, total_cases, population, total_deaths, ROUND((total_deaths/total_cases)*100, 2) AS death_rate
FROM public.deaths
WHERE total_cases >0 
  AND total_deaths IS NOT NULL
  AND continent IS NOT NULL
ORDER BY country, date;

--Death rate for INDIA
SELECT country, date, total_cases, population, total_deaths, ROUND((total_deaths/total_cases)*100, 2) AS death_rate
FROM public.deaths
WHERE total_cases >0 
  AND total_deaths IS NOT NULL 
  AND continent IS NOT NULL
  AND country = 'India'
ORDER BY country, date;


-- Max Death rate 
SELECT country, MAX(ROUND((total_deaths/total_cases)*100, 2)) AS death_rate
FROM public.deaths
WHERE total_cases >0 
  AND total_deaths IS NOT NULL 
  AND continent IS NOT NULL
GROUP BY country
ORDER BY death_rate DESC;


--Max Death rate per continent
SELECT continent, MAX(ROUND((total_deaths/total_cases)*100, 2)) AS death_rate
FROM public.deaths
WHERE total_cases >0 
  AND total_deaths IS NOT NULL 
  AND continent IS NOT NULL
GROUP BY continent
ORDER BY death_rate DESC;

-- total_cases per population
SELECT country, date, total_cases, population, total_deaths, ROUND((total_cases/population)*100, 2) AS per_population
FROM public.deaths
WHERE total_cases >0 
  AND total_deaths IS NOT NULL 
  AND continent IS NOT NULL
  AND country = 'India'
ORDER BY country, date;

-- Max total cases . population for countries 
SELECT country, MAX(ROUND((total_cases/population)*100, 2)) AS per_population
FROM public.deaths
WHERE total_cases>0  
  AND continent IS NOT NULL
  AND population IS NOT NULL
GROUP BY country
ORDER BY per_population DESC;


-- Max total cases . population for continents 
SELECT continent, MAX(ROUND((total_cases/population)*100, 2)) AS per_population
FROM public.deaths
WHERE total_cases>0  
  AND continent IS NOT NULL
  AND population IS NOT NULL
GROUP BY continent
ORDER BY per_population DESC;

-- Max total cases . population for countries per gdp
SELECT country, MAX(ROUND((total_cases/population)*100, 2)) AS per_population, ROUND(gdp_per_capita, 2) AS gdp_per_capita
FROM public.deaths
WHERE total_cases>0  
  AND continent IS NOT NULL
  AND population IS NOT NULL
  AND gdp_per_capita IS NOT NULL
GROUP BY country, gdp_per_capita
ORDER BY per_population DESC;


--rate of new cases per month
SELECT country, 
EXTRACT(YEAR FROM date) AS year, 
EXTRACT(MONTH FROM date) AS month, 
SUM(new_cases) AS new_cases 
FROM public.deaths
WHERE total_cases>0  
  AND continent IS NOT NULL
GROUP BY country, year, month
ORDER BY country, year, month;