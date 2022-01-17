SELECT * from PortfoliaProject..covid_death order by 3,4

--SELECT * from PortfoliaProject..covid_vaccinations
--order by 3,4

SELECT location,date,total_cases,new_cases,total_deaths,population from PortfoliaProject..covid_death
order by 1,2

-- Looking at total cases vs total deaths
SELECT location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage from
PortfoliaProject..covid_death
where location like '%States'
order by 1,2


--Looking at total cases vs population
SELECT location,date,total_cases,population, (total_cases/population)*100 as WhatPercentagegotCOVID from
PortfoliaProject..covid_death
where location like '%Germany'
order by 1,2

-- Countries with highest infection rate compared to population
--Looking at total cases vs population
SELECT location,MAX(total_cases) as HighestInfection,population, MAX((total_cases/population))*100 as WhatPercentagegotCOVID from
PortfoliaProject..covid_death
Group by location,population
--where location like '%Germany'
order by WhatPercentagegotCOVID desc


--- Countries with the highest death rates per population
SELECT location,MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfoliaProject..covid_death
Where continent is not null
Group by location
--where location like '%Germany'
order by TotalDeathCount desc


----- Looking after the continent
SELECT continent,MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfoliaProject..covid_death
Where continent is not null
Group by continent
--where location like '%Germany'
order by TotalDeathCount desc


SELECT date,sum(new_cases),sum(cast(new_deaths as int)) as totaldeaths, (total_deaths/total_cases)*100 as deathpercentage
from PortfoliaProject..covid_death
Where continent is not null
Group by date
--where location like '%Germany'
order by 1,2

------Looking at total population vs vaccinations


select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.location)
from PortfoliaProject..covid_vaccinations vac
Join PortfoliaProject..covid_death dea
	ON dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not NULL
order by 1,2,3


