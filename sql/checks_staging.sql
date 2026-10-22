-- checks_staging.sql
-- Verification of the staging layer, 7 Oct 2026 (CQC 2 Oct 2026 release)

-- 1. Ratings: row count must match CSV (expect 327,397)
SELECT COUNT(*) AS total_rows FROM stg_ratings;

-- 2. Ratings: column alignment spot check
SELECT location_id, location_name, care_home,
       service_population_group, domain, latest_rating, publication_date
FROM stg_ratings
LIMIT 10;

-- 3. Locations: structure must match CSV (expect 122 columns)
SELECT COUNT(*) AS column_count
FROM information_schema.columns
WHERE table_name = 'stg_locations';

-- 4. Locations: row count must match CSV (expect 57,097)
SELECT COUNT(*) AS total_rows FROM stg_locations;

-- 5. Locations: last columns aligned (expect NULL 14,064 / Y 426 / N 424)
SELECT location_dual_registered, primary_id_dual_reg, COUNT(*) AS homes
FROM stg_locations
WHERE care_home = 'Y'
GROUP BY location_dual_registered, primary_id_dual_reg
ORDER BY homes DESC;