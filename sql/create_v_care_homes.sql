-- v_care_homes: analysis-ready view, one row per clean care home with its ratings.
-- LEFT JOIN keeps the 831 unrated homes (rating columns NULL).
DROP VIEW IF EXISTS v_care_homes;

CREATE VIEW v_care_homes AS
SELECT c.location_id,
       c.location_name,
       c.provider_id,
       c.provider_name,
       c.local_authority,
       c.region,
       c.beds,
       c.home_type,
       c.dementia,
       c.rating_published,
       r.safe,
       r.effective,
       r.caring,
       r.responsive,
       r.well_led,
       r.overall
FROM care_homes c
LEFT JOIN home_ratings r
       ON r.location_id = c.location_id;