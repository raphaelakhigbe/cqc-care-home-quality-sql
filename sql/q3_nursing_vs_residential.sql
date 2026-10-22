-- Q3: Nursing vs Residential Homes (Rated Good or Outstanding)
-- England vs West Sussex (rated homes only)
-- England:
--   Residential: 83.7%
--   Nursing:     80.0%
--   Gap:         3.7 percentage points
-- West Sussex:
--   Residential: 84.5%
--   Nursing:     83.3%
--   Gap:         1.2 percentage points
-- Caveat:
-- West Sussex nursing homes (83.3%) score 3.3 points above
--   nursing homes nationally (80.0%).
-- Caveat:
--   West Sussex gap is negligible: with only 108 nursing homes,
--   1.2 points is about 1 home's rating.
--   Shows nursing homes are rated lower, not that nursing causes it:
--   nursing-home residents have more complex needs..

SELECT 'England' AS area,
       home_type,                       
       COUNT(*) AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
             / COUNT(*), 1) AS pct_good_or_outstanding
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
GROUP BY home_type

UNION ALL

SELECT 'West Sussex' AS area,
       home_type,                  
       COUNT(*),
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
             / COUNT(*), 1)
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
  AND local_authority = 'West Sussex'
GROUP BY home_type
ORDER BY area, pct_good_or_outstanding DESC;     