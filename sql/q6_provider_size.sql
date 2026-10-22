--Q6: % rated Good/Outstanding by provider size (homes the provider runs)
-----------------------------------------------------------------------
-- Result (rated homes, % Good+):
-- Exactly 1 home:  5123 homes, 79.0%
-- 2–5 homes:       3381 homes, 83.0%
-- 6–20 homes:      2648 homes, 85.0%
-- 21 or more:      2296 homes, 87.3%
-- Prediction: single-home owners best (wrong - they scored lowest).
-- Interpretation:
-- Larger providers achieve higher quality ratings — they likely replicate 
-- system (training, audits, policies) across homes, 
-- while single-home owners build them alone.
-- Caveat:
-- Correlation is not causation — large groups may sell or close failing homes.
With provider_size 
	AS (SELECT provider_id, COUNT(*) AS homes
	FROM v_care_homes
	GROUP BY provider_id)

SELECT CASE WHEN p.homes = 1   THEN '1: single home'
            WHEN p.homes <= 5  THEN '2: 2-5 homes'
            WHEN p.homes <= 20 THEN '3: 6-20 homes'
            WHEN p.homes >= 21 THEN '4: 21+ homes'
			 ELSE 'UNKNOWN'
       END AS provider_band,
COUNT(*) AS rated_homes,
ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
             / COUNT(*), 1) AS pct_good_or_outstanding
FROM v_care_homes v
JOIN provider_size p ON p.provider_id = v.provider_id
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
GROUP BY provider_band
ORDER BY provider_band