-- Q1b: full rating distribution, England vs West Sussex (% of rated homes)
SELECT overall,
       COUNT(*)                                                  AS england_homes,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1)        AS england_pct,
       COUNT(*) FILTER (WHERE local_authority = 'West Sussex')   AS wsx_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE local_authority = 'West Sussex')
                   / SUM(COUNT(*) FILTER (WHERE local_authority = 'West Sussex')) OVER (), 1)
                                                                 AS wsx_pct
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
GROUP BY overall
ORDER BY england_homes DESC;