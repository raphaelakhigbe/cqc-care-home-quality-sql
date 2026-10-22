--Q2C.
--rank region by the proportion of their rated care homes
--that are Good or Outstanding
--(Unspecified excluded: CQC label for homes with no assigned region, 
--not a real region.)
--Method: RANK() window function; tied regions share a rank
--Result: South East ranks 4 of 9 (81.9%), below England 82.6%;
--Key Findings: West Sussex 84.1% > England 82.6% > South East 81.9%
SELECT region,
       COUNT(*)                                                     AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
                   / COUNT(*), 1)                                  AS pct_good_or_outstanding,
					 RANK() OVER (ORDER BY  ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
                   / COUNT(*), 1) DESC) AS rank_position
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
AND region <> 'Unspecified'
GROUP BY region
ORDER BY  rank_position ASC;