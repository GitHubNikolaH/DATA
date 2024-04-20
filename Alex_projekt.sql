SELECT *
	FROM Portfolio_Alex..Covid_population
Order by 3,4


ALTER TABLE [Covid_population] ALTER COLUMN [total_cases] [float]
ALTER TABLE [Covid_population] ALTER COLUMN [total_cases] [float]
ALTER TABLE [Vakcinisani] ALTER COLUMN [new_vaccinations] [float]


--SELECT *
--	FROM Portfolio_Alex..Vakcinisani
--	ORDER BY 3,4
-- Selecting the data we are going to be using

SELECT location, date,total_cases,total_deaths,population
	FROM Portfolio_Alex..Covid_population
ORDER BY 1,2
-- Total cases versus total deaths 

SELECT location, date, total_cases,new_cases, total_deaths, population
	FROM Portfolio_Alex..Covid_population
ORDER BY 1,2

--Total deaths by location
SELECT location, MAX(total_deaths) AS All_the_people_lost
	FROM Portfolio_Alex..Covid_population
	WHERE continent is not null
	Group by Location
ORDER BY All_the_people_lost desc

--By continent

SELECT continent, MAX(total_deaths) AS All_the_people_lost
	FROM Portfolio_Alex..Covid_population
	WHERE continent is not null
	Group by continent
ORDER BY All_the_people_lost desc

SELECT location, MAX(total_deaths) AS All_the_people_lost
	FROM Portfolio_Alex..Covid_population
	WHERE continent is null
	Group by location
ORDER BY All_the_people_lost desc

-- Showing continent with highest death count per population
SELECT continent, MAX(total_deaths) AS All_the_people_lost
	FROM Portfolio_Alex..Covid_population
	WHERE continent is not null
	Group by continent
ORDER BY All_the_people_lost desc

--GLOBAL NUMBERS

SELECT date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Percantage_of_people_lost
FROM Portfolio_Alex..Covid_population
	WHERE continent is not null
	Group by date
ORDER BY Percantage_of_people_lost desc

-- Joining tables together - Vaccinations and Infected ones and renaming them

SELECT *
	FROM Portfolio_Alex.. Covid_population cop
		JOIN Portfolio_Alex.. Vakcinisani vak
			ON cop.location = vak.location
			AND cop.date = vak.date 

-- Vaccinated people throught the world
With PopvsVac (continent, location, date, population,New_vaccinations, Total_vaccinated) as
(
	SELECT cop.continent,cop.location,cop.date, population, vak.new_vaccinations,
			SUM(vak.new_vaccinations) OVER (PARTITION BY cop.Location ORDER BY cop.location,cop.date) as Total_vaccinated
	FROM Portfolio_Alex.. Covid_population cop
	JOIN Portfolio_Alex.. Vakcinisani vak
		ON cop.location = vak.location
		AND cop.date = vak.date
	WHERE cop.continent is not null)
--ORDER BY 2,3
SELECT *,(Total_vaccinated/population)*100
FROM PopvsVac


