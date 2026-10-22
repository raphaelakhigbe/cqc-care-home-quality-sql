-- Preview: classify each home using CQC's definition
SELECT CASE
           WHEN with_nursing = 'Y'    THEN 'Nursing'
           WHEN without_nursing = 'Y' THEN 'Residential'
           ELSE 'Unknown'
       END        AS home_type,
       COUNT(*)   AS homes
FROM care_homes
GROUP BY home_type
ORDER BY homes DESC;