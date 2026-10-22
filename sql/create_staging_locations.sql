-- create_staging_locations.sql
-- Staging (raw) table for the CQC HSCA Active Locations file, 1 Oct 2026 release.
-- Every column is TEXT on purpose: the raw layer accepts the file exactly as published,
-- so the import never fails on a bad date or number. Types are fixed later in the clean layer.
-- Column order matches the CSV exactly (122 columns). Prefixes: ra_ = Regulated activity,
-- st_ = Service type, sub_ = Service user band. Original CQC header shown in each comment.

DROP TABLE IF EXISTS stg_locations;

CREATE TABLE stg_locations (
    location_id                                                  TEXT,  -- Location ID
    location_hsca_start_date                                     TEXT,  -- Location HSCA start date
    dormant_yn                                                   TEXT,  -- Dormant (Y/N)
    care_home                                                    TEXT,  -- Care home?
    location_name                                                TEXT,  -- Location Name
    location_ods_code                                            TEXT,  -- Location ODS Code
    location_telephone_number                                    TEXT,  -- Location Telephone Number
    registered_manager                                           TEXT,  -- Registered manager
    location_web_address                                         TEXT,  -- Location Web Address
    care_homes_beds                                              TEXT,  -- Care homes beds
    location_type_sector                                         TEXT,  -- Location Type/Sector
    location_inspection_directorate                              TEXT,  -- Location Inspection Directorate
    location_primary_inspection_category                         TEXT,  -- Location Primary Inspection Category
    location_latest_overall_rating                               TEXT,  -- Location Latest Overall Rating
    publication_date                                             TEXT,  -- Publication Date
    inherited_rating_yn                                          TEXT,  -- Inherited Rating (Y/N)
    location_region                                              TEXT,  -- Location Region
    location_nhs_region                                          TEXT,  -- Location NHS Region
    location_local_authority                                     TEXT,  -- Location Local Authority
    location_onspd_ccg_code                                      TEXT,  -- Location ONSPD CCG Code
    location_onspd_ccg                                           TEXT,  -- Location ONSPD CCG
    location_commissioning_ccg_code                              TEXT,  -- Location Commissioning CCG Code
    location_commissioning_ccg                                   TEXT,  -- Location Commissioning CCG
    location_street_address                                      TEXT,  -- Location Street Address
    location_address_line_2                                      TEXT,  -- Location Address Line 2
    location_city                                                TEXT,  -- Location City
    location_county                                              TEXT,  -- Location County
    location_postal_code                                         TEXT,  -- Location Postal Code
    location_paf_id                                              TEXT,  -- Location PAF ID
    location_uprn_id                                             TEXT,  -- Location UPRN ID
    location_latitude                                            TEXT,  -- Location Latitude
    location_longitude                                           TEXT,  -- Location Longitude
    location_parliamentary_constituency                          TEXT,  -- Location Parliamentary Constituency
    brand_id                                                     TEXT,  -- Brand ID
    brand_name                                                   TEXT,  -- Brand Name
    provider_companies_house_number                              TEXT,  -- Provider Companies House Number
    provider_charity_number                                      TEXT,  -- Provider Charity Number
    provider_id                                                  TEXT,  -- Provider ID
    provider_name                                                TEXT,  -- Provider Name
    provider_hsca_start_date                                     TEXT,  -- Provider HSCA start date
    provider_type_sector                                         TEXT,  -- Provider Type/Sector
    provider_inspection_directorate                              TEXT,  -- Provider Inspection Directorate
    provider_primary_inspection_category                         TEXT,  -- Provider Primary Inspection Category
    provider_ownership_type                                      TEXT,  -- Provider Ownership Type
    provider_telephone_number                                    TEXT,  -- Provider Telephone Number
    provider_web_address                                         TEXT,  -- Provider Web Address
    provider_street_address                                      TEXT,  -- Provider Street Address
    provider_address_line_2                                      TEXT,  -- Provider Address Line 2
    provider_city                                                TEXT,  -- Provider City
    provider_county                                              TEXT,  -- Provider County
    provider_postal_code                                         TEXT,  -- Provider Postal Code
    provider_paf_id                                              TEXT,  -- Provider PAF ID
    provider_uprn_id                                             TEXT,  -- Provider UPRN ID
    provider_local_authority                                     TEXT,  -- Provider Local Authority
    provider_region                                              TEXT,  -- Provider Region
    provider_nhs_region                                          TEXT,  -- Provider NHS Region
    provider_latitude                                            TEXT,  -- Provider Latitude
    provider_longitude                                           TEXT,  -- Provider Longitude
    provider_parliamentary_constituency                          TEXT,  -- Provider Parliamentary Constituency
    provider_nominated_individual_name                           TEXT,  -- Provider Nominated Individual Name
    provider_main_partner_name                                   TEXT,  -- Provider Main Partner Name
    ra_accommodation_for_persons_who_require_nursing_or_personal TEXT,  -- Regulated activity - Accommodation for persons who require nursing or personal care
    ra_accommodation_for_persons_who_require_treatment_for_subst TEXT,  -- Regulated activity - Accommodation for persons who require treatment for substance misuse
    ra_assessment_or_medical_treatment_for_persons_detained_unde TEXT,  -- Regulated activity - Assessment or medical treatment for persons detained under the Mental Health Act 1983
    ra_diagnostic_and_screening_procedures                       TEXT,  -- Regulated activity - Diagnostic and screening procedures
    ra_family_planning                                           TEXT,  -- Regulated activity - Family planning
    ra_management_of_supply_of_blood_and_blood_derived_products  TEXT,  -- Regulated activity - Management of supply of blood and blood derived products
    ra_maternity_and_midwifery_services                          TEXT,  -- Regulated activity - Maternity and midwifery services
    ra_nursing_care                                              TEXT,  -- Regulated activity - Nursing care
    ra_personal_care                                             TEXT,  -- Regulated activity - Personal care
    ra_services_in_slimming_clinics                              TEXT,  -- Regulated activity - Services in slimming clinics
    ra_surgical_procedures                                       TEXT,  -- Regulated activity - Surgical procedures
    ra_termination_of_pregnancies                                TEXT,  -- Regulated activity - Termination of pregnancies
    ra_transport_services_triage_and_medical_advice_provided_rem TEXT,  -- Regulated activity - Transport services, triage and medical advice provided remotely
    ra_treatment_of_disease_disorder_or_injury                   TEXT,  -- Regulated activity - Treatment of disease, disorder or injury
    st_acute_services_with_overnight_beds                        TEXT,  -- Service type - Acute services with overnight beds
    st_acute_services_without_overnight_beds_listed_acute_servic TEXT,  -- Service type - Acute services without overnight beds / listed acute services with or without overnight beds
    st_ambulance_service                                         TEXT,  -- Service type - Ambulance service
    st_blood_and_transplant_service                              TEXT,  -- Service type - Blood and Transplant service
    st_care_home_service_with_nursing                            TEXT,  -- Service type - Care home service with nursing
    st_care_home_service_without_nursing                         TEXT,  -- Service type - Care home service without nursing
    st_community_based_services_for_people_who_misuse_substances TEXT,  -- Service type - Community based services for people who misuse substances
    st_community_based_services_for_people_with_a_learning_disab TEXT,  -- Service type - Community based services for people with a learning disability
    st_community_based_services_for_people_with_mental_health_ne TEXT,  -- Service type - Community based services for people with mental health needs
    st_community_health_care_services_independent_midwives       TEXT,  -- Service type - Community health care services - Independent Midwives
    st_community_health_care_services_nurses_agency_only         TEXT,  -- Service type - Community health care services - Nurses Agency only
    st_community_healthcare_service                              TEXT,  -- Service type - Community healthcare service
    st_dental_service                                            TEXT,  -- Service type - Dental service
    st_diagnostic_and_or_screening_service                       TEXT,  -- Service type - Diagnostic and/or screening service
    st_diagnostic_and_or_screening_service_single_handed_session TEXT,  -- Service type - Diagnostic and/or screening service - single handed sessional providers
    st_doctors_consultation_service                              TEXT,  -- Service type - Doctors consultation service
    st_doctors_treatment_service                                 TEXT,  -- Service type - Doctors treatment service
    st_domiciliary_care_service                                  TEXT,  -- Service type - Domiciliary care service
    st_extra_care_housing_services                               TEXT,  -- Service type - Extra Care housing services
    st_hospice_services                                          TEXT,  -- Service type - Hospice services
    st_hospice_services_at_home                                  TEXT,  -- Service type - Hospice services at home
    st_hospital_services_for_people_with_mental_health_needs_lea TEXT,  -- Service type - Hospital services for people with mental health needs, learning disabilities and problems with substance misuse
    st_hyperbaric_chamber                                        TEXT,  -- Service type - Hyperbaric Chamber
    st_long_term_conditions_services                             TEXT,  -- Service type - Long term conditions services
    st_mobile_doctors_service                                    TEXT,  -- Service type - Mobile doctors service
    st_prison_healthcare_services                                TEXT,  -- Service type - Prison Healthcare Services
    st_rehabilitation_services                                   TEXT,  -- Service type - Rehabilitation services
    st_remote_clinical_advice_service                            TEXT,  -- Service type - Remote clinical advice service
    st_residential_substance_misuse_treatment_and_or_rehabilitat TEXT,  -- Service type - Residential substance misuse treatment and/or rehabilitation service
    st_shared_lives                                              TEXT,  -- Service type - Shared Lives
    st_specialist_college_service                                TEXT,  -- Service type - Specialist college service
    st_supported_living_service                                  TEXT,  -- Service type - Supported living service
    st_urgent_care_services                                      TEXT,  -- Service type - Urgent care services
    sub_children_0_18_years                                      TEXT,  -- Service user band - Children 0-18 years
    sub_dementia                                                 TEXT,  -- Service user band - Dementia
    sub_learning_disabilities_or_autistic_spectrum_disorder      TEXT,  -- Service user band - Learning disabilities or autistic spectrum disorder
    sub_mental_health                                            TEXT,  -- Service user band - Mental Health
    sub_older_people                                             TEXT,  -- Service user band - Older People
    sub_people_detained_under_the_mental_health_act              TEXT,  -- Service user band - People detained under the Mental Health Act
    sub_people_who_misuse_drugs_and_alcohol                      TEXT,  -- Service user band - People who misuse drugs and alcohol
    sub_people_with_an_eating_disorder                           TEXT,  -- Service user band - People with an eating disorder
    sub_physical_disability                                      TEXT,  -- Service user band - Physical Disability
    sub_sensory_impairment                                       TEXT,  -- Service user band - Sensory Impairment
    sub_whole_population                                         TEXT,  -- Service user band - Whole Population
    sub_younger_adults                                           TEXT,  -- Service user band - Younger Adults
    location_dual_registered                                     TEXT,  -- Location Dual Registered
    primary_id_dual_reg                                          TEXT   -- Primary ID (Dual registration locations)
);