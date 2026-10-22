-- Q8: Age of ratings (snapshot 1 Oct 2026).
-- Snapshot date fixed at 1 Oct 2026 (not CURRENT_DATE) 
-- so results are reproducible.

-- Result : 9,809 of 13,448 (72.9%) older than 2 years; 
-- 			oldest rating 14 Apr 2016
--			while 3,639 of 13,448 (27.1%) are within 2 years
-- 			from the 9,809 with published rating older than 2 years
-- 			87.0% are rated good or outstanding
--          from the 3,639 rating within 2 years 70.8% are rated good or 
--			outstanding.
-- Prediction : (old ratings will have a higher % Good or Outstanding, because 
--				Good homes are re-inspected less often.)
--				I was correct.
-- Interpretation: selection bias - CQC re-inspects weaker homes sooner,
-- 				   so recent ratings skew low and old Good ratings may be 
--				   out of date.
-- Caveat : publication date does not equal visit date	

-- Step 1: how many ratings are older than 2 years
SELECT COUNT(*) AS rated_homes,
       COUNT(*) FILTER (WHERE rating_published 
	   < DATE '2026-10-01' - INTERVAL '2 years') AS older_than_2y,
       		ROUND(100.0 * COUNT(*) FILTER 
			   (WHERE rating_published < DATE '2026-10-01' - 
	   		INTERVAL '2 years') / COUNT(*), 1) AS pct_older_than_2y
FROM v_care_homes
WHERE overall IN ('Outstanding','Good','Requires improvement','Inadequate');

-- Step 2: % Good/Outstanding by rating age
SELECT CASE WHEN rating_published < DATE '2026-10-01' - INTERVAL '2 years'
            THEN '2: older than 2 years'
            ELSE '1: within 2 years'
       END AS rating_age_band,
       COUNT(*) AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
             / COUNT(*), 1) AS pct_good_or_outstanding
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')
GROUP BY rating_age_band
ORDER BY rating_age_band;