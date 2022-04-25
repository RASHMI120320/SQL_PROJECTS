SELECT * 
FROM Project_1.`covid deaths`
ORDER BY 3,4;


SELECT * 
FROM Project_1.covid_vaccinations
ORDER BY 3,4 ;

-- select the data that we are going to use --

SELECT location,date,population, total_cases,new_cases, total_deaths
FROM Project_1.`covid deaths`
ORDER BY 1,2;
-- looking at total cases vs total deaths--
SELECT location,population, total_cases,total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM Project_1.`covid deaths`
ORDER BY 1,2;

-- looking at total cases vs total deaths for india--
SELECT location,date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM Project_1.`covid deaths`
WHERE location ='India'
ORDER BY 1,2;

-- looking at Total cases vs population--
-- Shows what percentage of population got infected--
SELECT location,date, total_cases,population, (total_cases/population)*100 AS Infection_rate
FROM Project_1.`covid deaths`
WHERE continent <>''
ORDER BY 1,2;

-- Highest infection rate In India--
SELECT MAX(Infection_rate),date
FROM(
SELECT location,date, total_cases,population, (total_cases/population)*100 AS Infection_rate
FROM Project_1.`covid deaths`
WHERE location ='India'
ORDER BY 1,2) AS t1
GROUP BY date
ORDER BY 1 DESC
LIMIT 1;

-- shows what countries have the highest infection rate compared to the population--
SELECT location,population, MAX(total_cases) as HighestInfectionCount , MAX((total_cases/population))*100 as PercentPopulationInfected
FROM Project_1.`covid deaths`
WHERE continent <>''
GROUP BY 1,2
ORDER BY 4 DESC;

-- Showing countries with Highest Death Count Per Population--
SELECT location, MAX(CAST(total_deaths AS SIGNED)) as HighestDeathCount 
FROM Project_1.`covid deaths`
WHERE continent <>''
GROUP BY 1
ORDER BY 2 DESC;

-- Showing continents with highest death count per population--
SELECT continent, MAX(CAST(total_deaths AS SIGNED)) as HighestDeathCount 
FROM Project_1.`covid deaths`
WHERE continent <>''
GROUP BY 1
ORDER BY 2 DESC;

-- GLOBAL NUMBERS BY DAY--
SELECT date,SUM(new_cases) AS totalCases,SUM(CAST(new_deaths AS UNSIGNED)) AS DeathCount ,(SUM(CAST(new_deaths AS UNSIGNED))/SUM(new_cases))*100 AS DeathPercentage
FROM Project_1.`covid deaths`
WHERE continent<>''
GROUP BY 1
ORDER BY 1,2;

-- GLOBAL NUMBERS AGGREGATE--
SELECT SUM(new_cases) AS totalCases,SUM(CAST(new_deaths AS UNSIGNED)) AS DeathCount ,(SUM(CAST(new_deaths AS UNSIGNED))/SUM(new_cases))*100 AS DeathPercentage
FROM Project_1.`covid deaths`
WHERE continent<>''
ORDER BY 1,2;


-- looking at Total Population Vs Total Vaccinations
SELECT cd.continent, cd.location,cd.date, cd.population, cv.new_vaccinations,
SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (Partition by cd.location ORDER BY cd.location , cd.date) AS RollingCountOfPeopleVaccinated
FROM Project_1.`covid deaths` AS cd
JOIN Project_1.covid_vaccinations AS cv
ON cd.location=cv.location AND cd.date=cv.date
WHERE cd.continent <>''
ORDER BY 2,3;

-- USE CTE
WITH PopVsVac(Continent, location,date,population,New_Vaccinations, RollingCountOfPeopleVaccinated)
AS
( 
SELECT cd.continent, cd.location,cd.date, cd.population, cv.new_vaccinations,
SUM(CAST(cv.new_vaccinations AS UNSIGNED)) OVER (Partition by cd.location ORDER BY cd.location , cd.date) AS RollingCountOfPeopleVaccinated
FROM Project_1.`covid deaths` AS cd
JOIN Project_1.covid_vaccinations AS cv
ON cd.location=cv.location AND cd.date=cv.date
WHERE cd.continent <>''
ORDER BY 2,3
)
SELECT *,(RollingCountOfPeopleVaccinated/Population)*100
FROM PopVsVac;



