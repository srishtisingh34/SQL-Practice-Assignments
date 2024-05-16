#------------- PART2 ---------------

# Created new schema "finalproject" to load new 3 CSV files.
create schema finalproject;

Use finalproject;
# Altering the table "dim_member" and adding Primary Key `member_id`
ALTER TABLE `finalproject`.`dim_member` 
CHANGE COLUMN `member_id` `member_id` INT NOT NULL ,
CHANGE COLUMN `member_first_name` `member_first_name` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `member_last_name` `member_last_name` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `member_gender` `member_gender` CHAR(1) NULL DEFAULT NULL ,
ADD PRIMARY KEY (`member_id`);

# Altering the column "member_birth_date" of table "dim_member"
SET SQL_SAFE_UPDATES = 0;
UPDATE dim_member
SET member_birth_date = STR_TO_DATE(member_birth_date,'%m/%d/%Y');
SET SQL_SAFE_UPDATES = 1;


ALTER TABLE `finalproject`.`dim_member` 
CHANGE COLUMN `member_birth_date` `member_birth_date` DATE NULL DEFAULT NULL ;

# Altering the table "dim_drug" and adding Primary Key `drug_ndc`
ALTER TABLE `finalproject`.`dim_drug` 
CHANGE COLUMN `drug_ndc` `drug_ndc` INT NOT NULL ,
CHANGE COLUMN `drug_name` `drug_name` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `drug_form_code` `drug_form_code` CHAR(2) NULL DEFAULT NULL ,
CHANGE COLUMN `drug_form_desc` `drug_form_desc` VARCHAR(100) NULL DEFAULT NULL ,
CHANGE COLUMN `drug_brand_generic_desc` `drug_brand_generic_desc` VARCHAR(10) NULL DEFAULT NULL ,
ADD PRIMARY KEY (`drug_ndc`);

# Altering the table "fact_prescription" and adding Foriegn Key `member_id`
ALTER TABLE fact_prescription
ADD FOREIGN KEY (member_id) REFERENCES dim_member(member_id);

# Altering the table "fact_prescription" and adding Foriegn Key `drug_ndc`
ALTER TABLE fact_prescription
ADD FOREIGN KEY (drug_ndc) REFERENCES dim_drug(drug_ndc);


#------------- PART4 ---------------

# 1st 
SELECT drug_name, COUNT(*) AS prescription_count
FROM dim_drug
JOIN fact_prescription ON dim_drug.drug_ndc = fact_prescription.drug_ndc
GROUP BY drug_name;

# 2nd 
SELECT
    CASE WHEN dm.member_age >= 65 THEN 'age 65+'
         ELSE '< 65'
    END AS age_group,
    COUNT(DISTINCT fp.member_id) AS unique_members,
    COUNT(*) AS total_prescriptions,
    SUM(fp.copay) AS total_copay,
    SUM(fp.insurancepaid) AS total_insurance_paid
FROM
    fact_prescription fp
    INNER JOIN dim_member dm ON fp.member_id = dm.member_id
GROUP BY
    age_group;
    

# 3rd 
SELECT
  dm.member_id,
  dm.member_first_name,
  dm.member_last_name,
  dd.drug_name,
  fp.fill_date,
  fp.insurancepaid AS most_recent_insurance_paid
FROM
  dim_member AS dm
JOIN
  fact_prescription AS fp ON dm.member_id = fp.member_id
JOIN
  dim_drug AS dd ON fp.drug_ndc = dd.drug_ndc
WHERE
  (fp.member_id, fp.fill_date) IN (
    SELECT
      member_id,
      MAX(fill_date)
    FROM
      fact_prescription
    GROUP BY
      member_id
  )