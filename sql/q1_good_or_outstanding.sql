-- Q1: % rated Good or Outstanding — England vs West Sussex
SELECT 'England'                                                    AS area,
       COUNT(*)                                                     AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
                   / COUNT(*), 1)                                   AS pct_good_or_outstanding
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')

UNION ALL

SELECT 'West Sussex',
       COUNT(*),
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
                   / COUNT(*), 1)
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
  AND local_authority = 'West Sussex';