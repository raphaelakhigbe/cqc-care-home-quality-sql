-- care_homes: one row per active care home in England (clean layer)
-- Source: stg_locations (CQC HSCA Active Locations, 1 Oct 2026)
DROP TABLE IF EXISTS care_homes;

CREATE TABLE care_homes AS
SELECT location_id,
       location_name,
       provider_id,
       provider_name,
       location_local_authority                   AS local_authority,
       location_region                            AS region,
       care_homes_beds::INTEGER                   AS beds,
       st_care_home_service_with_nursing          AS with_nursing,
       st_care_home_service_without_nursing       AS without_nursing,
-- Home type per CQC definition: any home registered for nursing
-- (including the 17 that offer both services) is a nursing home
       CASE
           WHEN st_care_home_service_with_nursing = 'Y'    THEN 'Nursing'
           WHEN st_care_home_service_without_nursing = 'Y' THEN 'Residential'
           ELSE 'Unknown'
       END                                        AS home_type,
       sub_dementia                               AS dementia,
       location_latest_overall_rating             AS overall_rating,
       TO_DATE(publication_date, 'DD/MM/YYYY')    AS rating_published
FROM stg_locations
WHERE care_home = 'Y'
  AND dormant_yn = 'N'
  AND (primary_id_dual_reg IS NULL OR primary_id_dual_reg = 'Y')
  -- Bourley Grange: CQC pairs 1-7727490663 (2019) and 1-19897102978 (2024)
  -- as dual registration but flags BOTH as Primary. Applying CQC's own rule
  -- (earliest registration = Primary), the 2024 record is excluded.
  -- Analyst decision; not marked by CQC.
  AND location_id <> '1-19897102978'
  -- 0 beds = not operating as a care home (2 NHS units excluded).
  -- Missing beds (NULL) kept: home still rated, just not size-banded.
  AND (care_homes_beds IS NULL OR care_homes_beds::INTEGER > 0);