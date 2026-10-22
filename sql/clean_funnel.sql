--- Cleaning funnel: rows removed by each business rule
SELECT COUNT(*)                                          AS all_locations,
       COUNT(*) FILTER (WHERE care_home = 'Y')           AS care_homes,
       COUNT(*) FILTER (WHERE care_home = 'Y'
                          AND dormant_yn = 'N')          AS active_care_homes,    
       COUNT(*) FILTER (WHERE care_home = 'Y'
                          AND dormant_yn = 'N'
                          AND (primary_id_dual_reg IS NULL
                               OR primary_id_dual_reg = 'Y')) AS final_care_homes
FROM stg_locations;