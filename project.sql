Select *
From PortfolioProject..CovidDeaths 
where continent 
order by 3,4



Select location, date, total_cases, new_cases, total_deaths,population 
From Project..CovidDeaths 
order by 1,2

--looking at Total Cases vs Total Deaths
Select location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as Death_Percentage 
From Project..CovidDeaths 
where location like '%states%'
order by 1,2

--looking at Total Cases vs Population
Select location, date, total_cases, population,(total_deaths/population)*100 as Death_Percentage 
From Project..CovidDeaths 
where location like '%states%'
order by 1,2

--looking at Countires with the Highest Infection Rate compared to Population
Select location, population, MAX(total_cases)as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From Project..CovidDeaths 
Group by location, Population
order by PercentPopulationInfected desc  


--showing Countries with Highest Death Count per population
Select location, Max(cast(Total_deaths as int)) as TotalDeathCount 
From Project..CovidDeaths
where continent is not null
Group by location
order by TotalDeathCount desc


--Let's break things down by continent 
Select continent, Max(cast(Total_deaths as int)) as TotalDeathCount 
From Project..CovidDeaths
where continent is not null
Group by continent
order by TotalDeathCount desc


--showing the continents with the highest death count per population
Select continent, Max(cast(Total_deaths as int)) as TotalDeathCount 
From Project..CovidDeaths
where continent is not null
Group by continent
order by TotalDeathCount desc

--Global numbers

Select date, Sum(new_cases) as total_cases, Sum(Cast(new_deaths as int))as total_deaths, Sum(Cast(new_deaths as int))/ Sum(new_cases)*100 as Death_Percentage 
From Project..CovidDeaths 
where continent is not null
Group by date
order by 1,2


Select Sum(new_cases) as total_cases, Sum(Cast(new_deaths as int))as total_deaths, Sum(Cast(new_deaths as int))/ Sum(new_cases)*100 as Death_Percentage 
From Project..CovidDeaths 
where continent is not null
order by 1,2

--Loooking at Total Population vs Vaccinations 

With PopvsVac(Continent, Locaiton, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as 
(
select CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date,  CovidDeaths.population,  CovidVaccinations.new_vaccinations
,SUM(Cast(CovidVaccinations.new_vaccinations as numeric)) over (Partition by CovidDeaths.location order by CovidDeaths.location, 
	CovidDeaths.date) as RollingPeopleVaccinated
from Project..CovidDeaths
Join Project..CovidVaccinations
	ON CovidDeaths.location = CovidVaccinations.location
	and CovidDeaths.date = CovidVaccinations.date
where CovidDeaths.continent is not null 
)

--Creating a temporary table for the percent of the population that is vaccinated 

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations bigint,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated 
select CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date,  CovidDeaths.population, CovidVaccinations.new_vaccinations
,SUM(Cast(CovidVaccinations.new_vaccinations as numeric)) over (Partition by CovidDeaths.location order by CovidDeaths.location, 
	CovidDeaths.date) as RollingPeopleVaccinated
from Project..CovidDeaths
Join Project..CovidVaccinations
	ON CovidDeaths.location = CovidVaccinations.location
	and CovidDeaths.date = CovidVaccinations.date
where CovidDeaths.continent is not null 

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


--Creating view to store data for later visualizations 

Create View PercentPopulationVaccinated as 
select CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date,  CovidDeaths.population, CovidVaccinations.new_vaccinations
,SUM(Cast(CovidVaccinations.new_vaccinations as numeric)) over (Partition by CovidDeaths.location order by CovidDeaths.location, 
	CovidDeaths.date) as RollingPeopleVaccinated
from Project..CovidDeaths
Join Project..CovidVaccinations
	ON CovidDeaths.location = CovidVaccinations.location
	and CovidDeaths.date = CovidVaccinations.date
where CovidDeaths.continent is not null 

