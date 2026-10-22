-- home_ratings: one row per care home with its 5 key-question ratings + overall
-- Source: stg_ratings (CQC Latest Ratings, 2 Oct 2026)
-- Pivots the long format (one row per domain) into one row per home.
-- Domains CQC did not rate for a home are left NULL (30 gaps across 13,721 homes).
DROP TABLE IF EXISTS home_ratings;

CREATE TABLE home_ratings AS
SELECT location_id,
       MAX(latest_rating) FILTER (WHERE domain = 'Safe')        AS safe,
       MAX(latest_rating) FILTER (WHERE domain = 'Effective')   AS effective,
       MAX(latest_rating) FILTER (WHERE domain = 'Caring')      AS caring,
       MAX(latest_rating) FILTER (WHERE domain = 'Responsive')  AS responsive,
       MAX(latest_rating) FILTER (WHERE domain = 'Well-led')    AS well_led,
       MAX(latest_rating) FILTER (WHERE domain = 'Overall')     AS overall
FROM stg_ratings
WHERE care_home = 'Y'
  AND service_population_group = 'Overall'
GROUP BY location_id;