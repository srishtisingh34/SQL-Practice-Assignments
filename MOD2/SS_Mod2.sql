
Use Hospital;


Select ims_org_id
 from Business
 group by ims_org_id
 having count(ims_org_id)=1   ;
 
 Select ims_org_id
 from bed_fact
 group by ims_org_id;

#Hospitals having an Intensive Care Unit (ICU bed_id = 4) bed or a Surgical Intensive Care Unit (SICU bed_id = 15) bed or both
SELECT DISTINCT b.business_name AS hospital_name
FROM bed_fact AS f
JOIN business AS b ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15);

#1
SELECT b.business_name AS hospital_name, SUM(f.license_beds) AS total_license_beds
FROM bed_fact AS f
JOIN business AS b ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
ORDER BY total_license_beds DESC
LIMIT 10;

#2

SELECT b.business_name AS hospital_name, SUM(f.census_beds) AS total_census_beds
FROM bed_fact AS f
JOIN business AS b ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
ORDER BY total_census_beds DESC
LIMIT 10;

#3
SELECT b.business_name AS hospital_name, SUM(f.staffed_beds) AS total_staffed_beds
FROM bed_fact AS f
JOIN business AS b ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
ORDER BY total_staffed_beds DESC
LIMIT 10;

#5 (a)
SELECT b.business_name AS hospital_name, SUM(f.census_beds) AS total_census_beds
FROM bed_fact f
JOIN business b ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
HAVING COUNT(DISTINCT f.bed_id) >= 2
ORDER BY total_census_beds DESC
LIMIT 10;

SELECT b.business_name AS hospital_name, SUM(f.license_beds) AS total_license_beds
FROM bed_fact f
JOIN business b ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
HAVING COUNT(DISTINCT f.bed_id) >= 2
ORDER BY total_license_beds DESC
LIMIT 10;

SELECT b.business_name AS hospital_name, SUM(f.staffed_beds) AS total_staffed_beds
FROM bed_fact f
JOIN business b ON f.ims_org_id = b.ims_org_id
WHERE f.bed_id IN (4, 15)
GROUP BY b.business_name
HAVING COUNT(DISTINCT f.bed_id) >= 2
ORDER BY total_staffed_beds DESC
LIMIT 10;