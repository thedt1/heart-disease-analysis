-- Heart Disease Risk Factors: SQL analysis (SQLite)
-- Dataset: Heart Failure Prediction (Kaggle), 918 patients
-- Table: heart | HeartDisease: 1 = disease, 0 = no disease

-- 0. Overall: patient count and disease rate
SELECT
  COUNT(*) AS patients,
  ROUND(100.0 * SUM(HeartDisease) / COUNT(*), 1) AS pct_disease
FROM heart;

-- 1. Disease rate by exercise-induced angina (Y/N)
SELECT
  ExerciseAngina,
  COUNT(*) AS patients,
  ROUND(100.0 * SUM(HeartDisease) / COUNT(*), 1) AS pct_disease
FROM heart
GROUP BY ExerciseAngina;

-- 2. Disease rate by chest pain type
SELECT
  CASE ChestPainType
    WHEN 'ASY' THEN 'ASY: Asymptomatic'
    WHEN 'ATA' THEN 'ATA: Atypical angina'
    WHEN 'NAP' THEN 'NAP: Non-anginal pain'
    WHEN 'TA'  THEN 'TA: Typical angina'
  END AS chest_pain_type,
  COUNT(*) AS patients,
  ROUND(100.0 * SUM(HeartDisease) / COUNT(*), 1) AS pct_disease
FROM heart
GROUP BY ChestPainType
ORDER BY pct_disease DESC;

-- 3. Disease rate and average max heart rate by age band
SELECT
  CASE
    WHEN Age < 40 THEN 'Under 40'
    WHEN Age < 50 THEN '40-49'
    WHEN Age < 60 THEN '50-59'
    ELSE '60+'
  END AS age_band,
  COUNT(*) AS patients,
  ROUND(100.0 * SUM(HeartDisease) / COUNT(*), 1) AS pct_disease,
  ROUND(AVG(MaxHR), 1) AS avg_max_hr
FROM heart
GROUP BY age_band;

-- 4. Average max heart rate by age band and disease status
SELECT
  CASE
    WHEN Age < 40 THEN 'Under 40'
    WHEN Age < 50 THEN '40-49'
    WHEN Age < 60 THEN '50-59'
    ELSE '60+'
  END AS age_band,
  HeartDisease AS has_disease,
  COUNT(*) AS patients,
  ROUND(AVG(MaxHR), 1) AS avg_max_hr
FROM heart
GROUP BY age_band, HeartDisease
ORDER BY age_band, HeartDisease;
