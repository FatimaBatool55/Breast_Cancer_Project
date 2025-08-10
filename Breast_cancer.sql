CREATE TABLE breast_cancer (
    patient_id VARCHAR(50),
    age INT,
    region VARCHAR(50),
    city VARCHAR(50),
    marital_status VARCHAR(20),
    education_level VARCHAR(50),
    family_history INT,
    genetic_mutation INT,
    bmi DOUBLE PRECISION,
    physical_activity_level VARCHAR(20),
    dietary_habits VARCHAR(50),
    smoking INT,
    alcohol_consumption INT,
    menarche_age INT,
    menopause_status VARCHAR(20),
    pregnancies INT,
    breastfeeding_history INT,
    hormone_therapy INT,
    contraceptive_use INT,
    radiation_exposure INT,
    diabetes INT,
    hypertension INT,
    tumor_size_cm DOUBLE PRECISION,
    tumor_location VARCHAR(50),
    tumor_stage VARCHAR(20),
    histology_type VARCHAR(50),
    lymph_node_status INT,
    metastasis INT,
    er_status VARCHAR(20),
    pr_status VARCHAR(20),
    her2_status VARCHAR(20),
    treatment_type VARCHAR(50),
    treatment_response VARCHAR(20),
    survival_status VARCHAR(20),
    follow_up_years INT
);

SELECT * FROM breast_cancer;


-- Replace NULL values
UPDATE breast_cancer
SET family_history = COALESCE(family_history, 0),
    genetic_mutation = COALESCE(genetic_mutation, 0),
    smoking = COALESCE(smoking, 0),
    alcohol_consumption = COALESCE(alcohol_consumption, 0),
    pregnancies = COALESCE(pregnancies, 0),
    breastfeeding_history = COALESCE(breastfeeding_history, 0),
    hormone_therapy = COALESCE(hormone_therapy, 0),
    contraceptive_use = COALESCE(contraceptive_use, 0),
    radiation_exposure = COALESCE(radiation_exposure, 0),
    diabetes = COALESCE(diabetes, 0),
    hypertension = COALESCE(hypertension, 0),
    tumor_size_cm = COALESCE(tumor_size_cm, 0),
    lymph_node_status = COALESCE(lymph_node_status, 0),
    metastasis = COALESCE(metastasis, 0),
    follow_up_years = COALESCE(follow_up_years, 0);

UPDATE breast_cancer
SET region = COALESCE(region, 'Unknown'),
    city = COALESCE(city, 'Unknown'),
    marital_status = COALESCE(marital_status, 'Unknown'),
    education_level = COALESCE(education_level, 'Unknown'),
    physical_activity_level = COALESCE(physical_activity_level, 'Unknown'),
    dietary_habits = COALESCE(dietary_habits, 'Unknown'),
    menopause_status = COALESCE(menopause_status, 'Unknown'),
    tumor_location = COALESCE(tumor_location, 'Unknown'),
    histology_type = COALESCE(histology_type, 'Unknown'),
    er_status = COALESCE(er_status, 'Unknown'),
    pr_status = COALESCE(pr_status, 'Unknown'),
    her2_status = COALESCE(her2_status, 'Unknown'),
    treatment_type = COALESCE(treatment_type, 'Unknown'),
    treatment_response = COALESCE(treatment_response, 'Unknown'),
    survival_status = COALESCE(survival_status, 'Unknown');

-- Remove records with critical NULL values
DELETE FROM breast_cancer
WHERE patient_id IS NULL OR age IS NULL;

-- Step 4: Standardize tumor stage
UPDATE breast_cancer
SET tumor_stage = CASE
                    WHEN tumor_stage IN ('iv', 'IV') THEN 'IV'
                    WHEN tumor_stage IN ('iii', 'III') THEN 'III'
                    ELSE tumor_stage
                  END;

--  Remove rows with invalid age or BMI values
DELETE FROM breast_cancer
WHERE age < 0 OR age > 120;

DELETE FROM breast_cancer
WHERE bmi < 10 OR bmi > 50;

-- Step 6: Trim spaces
UPDATE breast_cancer
SET region = TRIM(region),
    city = TRIM(city),
    marital_status = TRIM(marital_status),
    education_level = TRIM(education_level),
    physical_activity_level = TRIM(physical_activity_level),
    dietary_habits = TRIM(dietary_habits),
    menopause_status = TRIM(menopause_status),
    tumor_location = TRIM(tumor_location),
    histology_type = TRIM(histology_type),
    er_status = TRIM(er_status),
    pr_status = TRIM(pr_status),
    her2_status = TRIM(her2_status),
    treatment_type = TRIM(treatment_type),
    treatment_response = TRIM(treatment_response),
    survival_status = TRIM(survival_status);

--Remove duplicate pateint id
WITH duplicates AS (
    SELECT patient_id, COUNT(*) 
    FROM breast_cancer
    GROUP BY patient_id
    HAVING COUNT(*) > 1
)
DELETE FROM breast_cancer
WHERE patient_id IN (SELECT patient_id FROM duplicates);


SELECT * FROM breast_cancer WHERE patient_id IS NULL OR age IS NULL;


-- Age Distribution (Histogram) ok
--Goal: You want to show the distribution of age in the dataset. This can be achieved by creating age bins and counting the number of patients in each bin.

SELECT
    CASE
        WHEN age BETWEEN 20 AND 30 THEN '20-30'
        WHEN age BETWEEN 31 AND 40 THEN '31-40'
        WHEN age BETWEEN 41 AND 50 THEN '41-50'
        WHEN age BETWEEN 51 AND 60 THEN '51-60'
        WHEN age BETWEEN 61 AND 70 THEN '61-70'
        WHEN age BETWEEN 71 AND 80 THEN '71-80'
        ELSE '81+'
    END AS age_group,
    COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY age_group
ORDER BY age_group;


--Tumor Size Distribution (Histogram) ok
--Goal: You want to show the distribution of tumor size.

SELECT
    CASE
        WHEN tumor_size_cm BETWEEN 0 AND 2 THEN '0-2 cm'
        WHEN tumor_size_cm BETWEEN 2.1 AND 5 THEN '2.1-5 cm'
        WHEN tumor_size_cm BETWEEN 5.1 AND 10 THEN '5.1-10 cm'
        ELSE '10+ cm'
    END AS tumor_size_group,
    COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY tumor_size_group
ORDER BY tumor_size_group;


--Tumor Stage Distribution (Bar Chart)
--Goal: You want to show the distribution of tumor stages (I, II, III, IV).


SELECT tumor_stage, COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY tumor_stage
ORDER BY tumor_stage;


--Survival Status vs. Treatment Type (Stacked Bar Chart)
--Goal: You want to compare survival status based on treatment type.

SELECT treatment_type, survival_status, COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY treatment_type, survival_status
ORDER BY treatment_type, survival_status;


-- Tumor Location vs. Tumor Stage (Clustered Bar Chart)
--You want to compare tumor location (Right/Left) and tumor stage (I, II, III, IV).

SELECT tumor_location, tumor_stage, COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY tumor_location, tumor_stage
ORDER BY tumor_location, tumor_stage;

--Correlation between Age and Tumor Size (Scatter Plot)ok
--You want to visualize the relationship between age and tumor size.

SELECT age, tumor_size_cm
FROM breast_cancer
WHERE age IS NOT NULL AND tumor_size_cm IS NOT NULL
ORDER BY age;

--Survival Status vs. Age Group (Bar Chart)ok
--Goal: You want to compare survival status by age group.

SELECT
    CASE
        WHEN age BETWEEN 20 AND 30 THEN '20-30'
        WHEN age BETWEEN 31 AND 40 THEN '31-40'
        WHEN age BETWEEN 41 AND 50 THEN '41-50'
        WHEN age BETWEEN 51 AND 60 THEN '51-60'
        WHEN age BETWEEN 61 AND 70 THEN '61-70'
        WHEN age BETWEEN 71 AND 80 THEN '71-80'
        ELSE '81+'
    END AS age_group,
    survival_status,
    COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY age_group, survival_status
ORDER BY age_group, survival_status;

--Family History vs. Tumor Stage (Stacked Bar Chart) ok
--You want to see how family history correlates with tumor stage.


SELECT family_history, tumor_stage, COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY family_history, tumor_stage
ORDER BY family_history, tumor_stage;

-- Radiation Exposure vs. Survival Status (Donut Chart) ok 
-- You want to see the relationship between radiation exposure and survival status.

SELECT radiation_exposure, survival_status, COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY radiation_exposure, survival_status
ORDER BY radiation_exposure, survival_status;

--Geographical Visualization (Map Chart) ok
--Goal: Visualize the geographical distribution of patients based on Region or City.

SELECT region, COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY region
ORDER BY patient_count DESC;

-- Treatment Effectiveness (Bar or Donut Chart) ok
--Goal: Compare Treatment Type with Survival Rate or Treatment Response.

SELECT treatment_type,
    SUM(CASE WHEN survival_status = 'Alive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS survival_rate
FROM breast_cancer
GROUP BY treatment_type
ORDER BY survival_rate DESC;

--Survival Status Breakdown (Pie Chart/Donut Chart) ok 
-- Show the overall distribution of Survival Status (Alive vs. Deceased).

SELECT survival_status, COUNT(*) AS patient_count
FROM breast_cancer
GROUP BY survival_status
ORDER BY patient_count DESC;

