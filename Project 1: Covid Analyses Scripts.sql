
-- 1. Global numbers

select sum(new_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths, sum(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
-- where location like '%brazil%'
where continent is not null
order by 1,2


-- Just a double check based off the data provided
-- numbers are extremely close, so we will keep them - The second includes "International" Location

--select sum(new_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
--from PortfolioProject..CovidDeaths
---- where location like '%brazil%'
--where location = 'World'
--order by 1,2


-- 2. Total Death Count by Continent or Region

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
-- where location like '%brazil%'
where continent is null
and location not in ('World', 'European Union', 'International')
group by location
order by TotalDeathCount desc


-- 3.a. Highest Infected Countries by Percent of Population Infected

Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
-- where location like '%brazil%'
Group by location, population
order by PercentPopulationInfected desc

-- 3.b. Highest Infected Countries by Percent of Population Infected and by Date

Select Location, Population, date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
-- where location like '%brazil%'
Group by location, population, date
order by PercentPopulationInfected desc


-- 4. Looking at total population vs vaccinations daily per Country

select dea.continent, dea.location, dea.date, dea.population, 
MAX(vac.total_vaccinations) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
group by dea.continent, dea.location, dea.date, dea.population
order by 1,2,3



-- 5.a. Using CTE - Percent of People Vaccinated per Country and Date

with PopvsVac (continent, location, date, population, new_vaccinations, RollingPopulationVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPopulationVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

)
select *, (RollingPopulationVaccinated/population)*100 as PercentPopulationVaccinated
from PopvsVac



-- 5.b. Using TEMP TABLE - Percent of People Vaccinated per Country and Date

drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPopulationVaccinated numeric
)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPopulationVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select *, (RollingPopulationVaccinated/population)*100 as PercentPopulationVaccinated
from #PercentPopulationVaccinated
