select *
from Project2..NumRisks

--looking at the maximum number in each category for each country 
select Country,max(cast(unsafe_water as numeric(10,2))) as UnsafeWater,
	max(cast(unsafe_sanitation as numeric(10,2)))as UnsafeSanitation,
	max(cast(no_handwashing_facility as numeric(10,2))) as NoHandwashingFacility,
	max(cast(household_air_pollution as numeric(10,2))) as HouseholdAirPollution,
	max(cast(child_wasting as numeric(10,2))) as Childwasting,
	max(cast(child_stunting as numeric(10,2))) as Child_stuning,
	max(cast(secondhand_smoke as numeric(10,2))) as SecondhandSmoke,
	max(cast(alcohol_use as numeric(10,2))) as AlcoholUse,
	max(cast(drug_use as numeric(10,2))) as Drug_use,
	max(cast(unsafe_sex as numeric(10,2))) as UnsafeSex,
	max(cast(low_physical_activity as numeric(10,2))) as LowPhysicalActivity,
	max(cast(smoking as numeric(10,2))) as Smoking,
	max(cast(iron_deficiency as numeric(10,2))) as IronDeficiency,
	max(cast(Vitamin_a_deficiency as numeric(10,2))) as VitaminADeficiency,
	max(cast(air_pollution as numeric(10,2))) as AirPollution,
	max(cast(outdoor_air_pollution as numeric(10,2))) as OutdoorAirPollution
from Project2..NumRisks
group by Country

--looking at the minimum number in each category for each country 
select Country,max(cast(unsafe_water as numeric(10,2))) as UnsafeWater,
	min(cast(unsafe_sanitation as numeric(10,2)))as UnsafeSanitation,
	min(cast(no_handwashing_facility as numeric(10,2))) as NoHandwashingFacility,
	min(cast(household_air_pollution as numeric(10,2))) as HouseholdAirPollution,
	min(cast(child_wasting as numeric(10,2))) as Childwasting,
	min(cast(child_stunting as numeric(10,2))) as Child_stuning,
	min(cast(secondhand_smoke as numeric(10,2))) as SecondhandSmoke,
	min(cast(alcohol_use as numeric(10,2))) as AlcoholUse,
	min(cast(drug_use as numeric(10,2))) as Drug_use,
	min(cast(unsafe_sex as numeric(10,2))) as UnsafeSex,
	min(cast(low_physical_activity as numeric(10,2))) as LowPhysicalActivity,
	min(cast(smoking as numeric(10,2))) as Smoking,
	min(cast(iron_deficiency as numeric(10,2))) as IronDeficiency,
	min(cast(Vitamin_a_deficiency as numeric(10,2))) as VitaminADeficiency,
	min(cast(air_pollution as numeric(10,2))) as AirPollution,
	min(cast(outdoor_air_pollution as numeric(10,2))) as OutdoorAirPollution
from Project2..NumRisks
group by Country

--comparing the numbers in developed countries
select Country,sum(cast(unsafe_water as numeric(10,2))) as UnsafeWater, sum(cast(unsafe_sanitation as numeric(10,2))) as UnsafeSanitation,
sum(cast(secondhand_smoke as numeric(10,2))) as SecondhandSmoking, sum(cast(alcohol_use as numeric(10,2))) as AlcoholUse, sum(cast(drug_use as numeric(10,2)))as Drug_Use,
sum(cast(air_pollution as numeric(10,2))) as AirPollution, sum(cast(outdoor_air_pollution as numeric(10,2))) as OutdoorAirPollution
from project2..NumRisks
where country = 'United kingdom' or country = 'Canada' or country ='Portugal' or country = 'Netherlands' or country = 'Australia'
or country = 'United States' or country  = 'Poland' or country = 'France' or country = 'Switzerland'
group by country
order by country asc

--comparing the numbers in developing countries 
select Country,sum(cast(unsafe_water as numeric(10,2))) as UnsafeWater, sum(cast(unsafe_sanitation as numeric(10,2))) as UnsafeSanitation,
sum(cast(secondhand_smoke as numeric(10,2))) as SecondhandSmoking, sum(cast(alcohol_use as numeric(10,2))) as AlcoholUse, sum(cast(drug_use as numeric(10,2)))as Drug_Use,
sum(cast(air_pollution as numeric(10,2))) as AirPollution, sum(cast(outdoor_air_pollution as numeric(10,2))) as OutdoorAirPollution
from project2..NumRisks
where country = 'Nigeria' or country = 'Afghanistan' or country ='Albania' or country = 'Bolivia' or country = 'Turkey'
or country = 'Ukrain' or country  = 'Mexico' or country = 'Kenya' or country = 'Zimbabwe'
group by country
order by country asc