-- Q9: Each local authority vs its regional average

-- Step 1 (South East only):
-- 19 South East local authorities
-- 2,530 rated homes (reconciles to Q2c total)

-- Performance vs Regional Average (81.9%):
-- 9 of 19 authorities are above the regional average
-- West Sussex ranks 8th at 84.1%

-- Prediction Check:
-- Prediction that "more than half would be above average" is incorrect.
-- Kent (456 homes at 78.9%) does pull the regional average down,
-- but not enough to put most authorities above it.

-- Caveat:
-- Small authorities (e.g., Slough with 14 homes) shift 7 percentage points 
-- per home, making their percentages highly volatile.

-- Step 2a:  (all England, counts per authority):
--   153 rows, 13,423 rated homes (13,448 minus 25 'Unspecified')
--   Row check: 153 rows vs 152 distinct authorities -> Harrow split 
--   (see data notes)
--   Prediction (153 rows): correct, but my reason (a NULL authority) was 
--   wrong IS NULL check returned 0 rows

-- Step 2b (all England, authorities with 20+ rated homes):
--   West Sussex 84.1% vs South East 81.9% = gap +2.2, rank 51 of 140
--   Prediction (+2.2): correct
--
-- Interpretation: gap = better than its neighbours, not "best in England".
--   3 of the top 4 are in East of England (avg 79.7), an easier benchmark.
--
-- Data notes:
--   25 rated homes with region 'Unspecified' excluded (13,448 -> 13,423)
--   Harrow: 47 homes London, 1 East of England (left as published);
--     found because 153 rows vs 152 distinct authorities
--   20-home minimum filters the display only; regional averages use all homes
--
-- Caveats: regional averages are pooled (weighted by homes);
--   small authorities swing about 5 points per home

-- Step 1: South East local authorities by % Good/Outstanding.
SELECT local_authority,    
		COUNT(*) AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
                   / COUNT(*), 1) AS pct_good_or_outstanding
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate') 
AND region = 'South East'
GROUP BY local_authority
ORDER BY pct_good_or_outstanding DESC;


-- Step 2a: rated and Good/Outstanding counts per local authority (excl. Unspecified region)
SELECT region, local_authority,
       COUNT(*) AS rated_homes,
       COUNT(*) FILTER (WHERE overall IN ('Outstanding','Good')) AS good_homes
FROM v_care_homes
WHERE overall IN ('Outstanding','Good','Requires improvement','Inadequate')
  AND region <> 'Unspecified'
GROUP BY region, local_authority
ORDER BY region, local_authority;

-- Step 2b : Is each local authority better or worse than its own region
WITH la_stats AS (SELECT region, local_authority,
       COUNT(*) AS rated_homes,
       COUNT(*) FILTER (WHERE overall IN ('Outstanding','Good')) AS good_homes
FROM v_care_homes
WHERE overall IN ('Outstanding','Good','Requires improvement','Inadequate')
  AND region <> 'Unspecified'
GROUP BY region, local_authority
),
region_stats 
AS (SELECT region,
       ROUND(100.0 * SUM(good_homes)
             / SUM(rated_homes), 1) AS region_pct
FROM la_Stats
			 GROUP BY region)
			 
SELECT  l.region, l.local_authority, l.rated_homes,
		ROUND(100.0 * l.good_homes / l.rated_homes, 1) AS la_pct,
		r.region_pct,
		ROUND(100.0 * l.good_homes / l.rated_homes, 1) - r.region_pct AS gap 
FROM la_stats l JOIN region_stats r ON r.region = l.region
WHERE l.rated_homes >= 20
ORDER BY gap DESC;
