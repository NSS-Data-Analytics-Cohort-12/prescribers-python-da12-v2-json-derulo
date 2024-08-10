-- In this project, you will be working with a database created from the 2017 Medicare Part D Prescriber Public Use File to answer the following questions:  
-- * Which Tennessee counties had a disproportionately high number of opioid prescriptions?
-- With op AS	
-- 	(SELECT f.county, pop.population as population, SUM(total_claim_count) as most_opioids
-- 	FROM drug as d
-- 	JOIN prescription as p
-- 	using(drug_name)
-- 	JOIN prescriber as pres
-- 	using(npi)
-- 	JOIN zip_fips as zip
-- 	on pres.nppes_provider_zip5 = zip.zip
-- 	JOIN fips_county as f
-- 	on zip.fipscounty = f.fipscounty
-- 	JOIN population pop
-- 	on zip.fipscounty = pop.fipscounty
-- 	where d.opioid_drug_flag = 'Y'
-- 	group by f.county, pop.population
-- 	order by most_opioids desc)
-- SELECT county, ROUND((most_opioids/population)*100,2)||'%' as perc
-- FROM op
-- order by ROUND((most_opioids/population)*100,2) desc

-- * Who are the top opioid prescibers for the state of Tennessee?
SELECT pres.nppes_provider_first_name ||' '|| pres.nppes_provider_last_org_name as name, sum(p.total_claim_count) as most_prescribed
FROM prescriber as pres
LEFT JOIN prescription as p
using(npi)
LEFT JOIN drug as d
using(drug_name)
where d.opioid_drug_flag = 'Y'
group by name
order by most_prescribed desc
limit 5;

-- * What did the trend in overdose deaths due to opioids look like in Tennessee from 2015 to 2018?
-- SELECT
-- 	year
-- 	, SUM(overdose_deaths)
-- FROM overdose_deaths od
-- JOIN fips_county fp
-- 	ON od.fipscounty = fp.fipscounty::integer
-- WHERE fp.state = 'TN'
-- GROUP BY year
-- ORDER BY 1
-- * Is there an association between rates of opioid prescriptions and overdose deaths by county?
-- * Is there any association between a particular type of opioid and number of overdose deaths?