-- =============================================
-- DEEPFAKE MISINFORMATION ANALYSIS - SQL QUERIES
-- Author: Imtiaz Laskar | June 2026
-- =============================================

-- Query 1: Platform Analysis
SELECT 
  `PLATFORM`,
  COUNT(*) AS total_cases,
  ROUND(AVG(DATE_DIFF(`DETECTION DATE`, `PUBLICATION DATE`, DAY)), 1) AS avg_detection_lag,
  MIN(DATE_DIFF(`DETECTION DATE`, `PUBLICATION DATE`, DAY)) AS fastest_detection,
  MAX(DATE_DIFF(`DETECTION DATE`, `PUBLICATION DATE`, DAY)) AS slowest_detection
FROM `deepfake_analysis.deepfake_cases`
GROUP BY `PLATFORM`
ORDER BY avg_detection_lag DESC;

-- Query 2: Region Analysis
SELECT 
  `GEOGRAPHICAL REGION`,
  COUNT(*) AS total_cases,
  ROUND(AVG(DATE_DIFF(`DETECTION DATE`, `PUBLICATION DATE`, DAY)), 1) AS avg_lag_days,
  COUNTIF(`LABEL BINARY` = 1) AS fake_count,
  COUNTIF(`LABEL BINARY` = 0) AS authentic_count
FROM `deepfake_analysis.deepfake_cases`
GROUP BY `GEOGRAPHICAL REGION`
ORDER BY total_cases DESC;

-- Query 3: Content Type Analysis
SELECT 
  `CONTENT TYPE`,
  COUNT(*) AS total_cases,
  ROUND(AVG(DATE_DIFF(`DETECTION DATE`, `PUBLICATION DATE`, DAY)), 1) AS avg_lag_days,
  COUNTIF(`LABEL BINARY` = 1) AS fake_count,
  ROUND(COUNTIF(`LABEL BINARY` = 1) * 100.0 / COUNT(*), 1) AS fake_percentage
FROM `deepfake_analysis.deepfake_cases`
GROUP BY `CONTENT TYPE`
ORDER BY total_cases DESC;

-- Query 4: Detection Lag Overview
SELECT 
  `RECORD ID`,
  `PUBLICATION DATE`,
  `DETECTION DATE`,
  DATE_DIFF(`DETECTION DATE`, `PUBLICATION DATE`, DAY) AS DETECTION_LAG_DAYS,
  CASE 
    WHEN DATE_DIFF(`DETECTION DATE`, `PUBLICATION DATE`, DAY) <= 30 THEN 'Fast'
    WHEN DATE_DIFF(`DETECTION DATE`, `PUBLICATION DATE`, DAY) <= 90 THEN 'Medium'
    ELSE 'Slow'
  END AS DETECTION_SPEED
FROM `deepfake_analysis.deepfake_cases`
ORDER BY DETECTION_LAG_DAYS DESC;
