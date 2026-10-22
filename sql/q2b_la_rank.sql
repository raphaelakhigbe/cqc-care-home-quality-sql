-- Q2b: Rank local authorities by the proportion of their rated care homes
-- that are Good or Outstanding (councils with >= 20 rated homes: 140 of 152)
-- Method: RANK() window function; tied councils share a rank
-- Result: West Sussex ranks 69 of 140 (84.1%), vs England 82.6%
-- Caveat: mid-table is tightly packed; ranks 60-72 span only 1.7 points,
-- so report the % first and treat the rank as context.
SELECT local_authority,
       COUNT(*)                                                     AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
                   / COUNT(*), 1)                                  AS pct_good_or_outstanding,
					 RANK() OVER (ORDER BY  ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
                   / COUNT(*), 1) DESC) AS rank_position
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
GROUP BY local_authority
HAVING COUNT(*) >= 20
ORDER BY rank_position ASC;