Select Sum(new_cases) as total_cases, sum(cast(new_deaths as numeric)) as total_deaths, sum(cast(new_deaths as int))/Sum(new_cases)*100
as DeathPercentage
From Project..CovidDeaths
where continent is not null 
order by 1,2


Select location, sum(cast(new_deaths as numeric)) as TotalDeathCount 
From project..CovidDeaths 
where continent is null
and location not in ('World','European Union','International')
Group by location
order by TotalDeathCount desc

Select location, population, MAX(total_cases)as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From Project..CovidDeaths 
Group by location, Population
order by PercentPopulationInfected desc

Select location, population, date, MAX(total_cases)as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From Project..CovidDeaths 
Group by location, Population, date
order by PercentPopulationInfected desc