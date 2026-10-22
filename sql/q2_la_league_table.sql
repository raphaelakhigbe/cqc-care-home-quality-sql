-- Q2: Local authority league table, % rated Good or Outstanding
-- Only councils with >= 20 rated homes (140 of 152); smaller councils excluded as
-- one home can swing their % to 0 or 100. England row added as benchmark.
SELECT 'England'                                                    AS area,
       COUNT(*)                                                     AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
                   / COUNT(*), 1)                                   AS pct_good_or_outstanding
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')

UNION ALL

SELECT local_authority,     
       COUNT(*),
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
                   / COUNT(*), 1)
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
Group by local_authority
Having count(*) >= 20
ORDER BY pct_good_or_outstanding DESC;