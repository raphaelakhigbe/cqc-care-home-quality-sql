-- Q7: Dementia specialist homes vs the rest
-- Result : England Dementia	rating was 79.6% (7,548)	
--		    while others was rated 86.4% (5,900). that is 6.8pts lower
--          West Sussex Dementia	rating was 84.8% (165)	
--		    while others was rated 83.3% (150)	1.5 pts higher
--			West Sussex dementia homes (84.8%) score 5.2 pts above dementia
--          homes nationally (79.6%).
-- Prediction : (dementia homes will score lower, because dementia care 
--				is harder to manage.) was correct nationally; reversed in 
--			    West Sussex (but only ~2 homes).
--Caveat:  The not dementia group includes those small learning-disability 
--		   homes that score very high, and that inflates the gap. 
--         Like-for-like (older-people homes only): 79.6% vs 83.9%, gap ~4.3 pts
--		   (checked in CQC source file, not in this query).

SELECT 'England' AS area,  
	   CASE WHEN dementia = 'Y'  THEN 'dementia'
			 ELSE 'not dementia'                    
       END AS dementia_group,
	   COUNT(*) AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
             / COUNT(*), 1) AS pct_good_or_outstanding
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
GROUP BY dementia_group

UNION ALL

SELECT 'West Sussex' AS area, 
	   CASE WHEN dementia = 'Y'  THEN 'dementia'
			 ELSE 'not dementia'
			 END AS dementia_group,
			 COUNT(*) AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
             / COUNT(*), 1)
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
  AND local_authority = 'West Sussex'
GROUP BY dementia_group
ORDER BY area,pct_good_or_outstanding DESC