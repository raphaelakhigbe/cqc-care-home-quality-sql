-- Staging table for CQC Latest Ratings file (2 Oct 2026). All TEXT = raw layer.
DROP TABLE IF EXISTS stg_ratings;

CREATE TABLE stg_ratings (
    location_id                       TEXT,
    location_ods_code                 TEXT,
    location_name                     TEXT,
    care_home                         TEXT,
    location_type                     TEXT,
    location_primary_inspection_cat   TEXT,
    location_street_address           TEXT,
    location_address_line_2           TEXT,
    location_city                     TEXT,
    location_post_code                TEXT,
    location_local_authority          TEXT,
    location_region                   TEXT,
    location_nhs_region               TEXT,
    location_onspd_ccg_code           TEXT,
    location_onspd_ccg                TEXT,
    location_commissioning_ccg_code   TEXT,
    location_commissioning_ccg_name   TEXT,
    service_population_group          TEXT,
    domain                            TEXT,
    latest_rating                     TEXT,
    publication_date                  TEXT,
    report_type                       TEXT,
    inherited_rating_yn               TEXT,
    url                               TEXT,
    provider_id                       TEXT,
    provider_name                     TEXT,
    brand_id                          TEXT,
    brand_name                        TEXT
);