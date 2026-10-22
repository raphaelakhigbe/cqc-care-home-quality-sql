-- Q5: Domain failures among homes rated below Good
-- Total homes rated below Good: 2,342

-- Result:
--   well_led failed in 2,299 homes (98.2%)
--   safe failed in 2,180 homes (93.1%)
--   effective failed in 1,057 homes (45.1%)
--   responsive failed in 724 homes (30.9%)
--   caring failed in 514 homes (21.9%)

-- Interpretation:
--   Below-Good homes almost always fail on leadership (Well-led) AND
--   frontline safety (Safe). Caring is rarely the problem.
-- Prediction: Well-led most (correct), Caring least (correct),
--   Effective second (wrong - Safe was second).
-- Caveat:
--   CQC builds the overall rating partly from the key-question ratings,
--   so some of this link is built into the rating system itself.



select COUNT(*) AS below_good_homes,
	COUNT(*) FILTER (WHERE safe IN ('Requires improvement', 'Inadequate'))
	AS safe_fail,
	COUNT(*) FILTER (WHERE effective IN ('Requires improvement', 'Inadequate'))
	AS effective_fail,
	COUNT(*) FILTER (WHERE caring IN ('Requires improvement', 'Inadequate'))
	AS caring_fail,
	COUNT(*) FILTER (WHERE responsive IN ('Requires improvement', 'Inadequate'))
	AS responsive_fail,
	COUNT(*) FILTER (WHERE well_led IN ('Requires improvement', 'Inadequate'))
	AS well_led_fail,
	ROUND(100.0 * COUNT(*) FILTER (WHERE safe IN ('Requires improvement', 'Inadequate'))
      / COUNT(*), 1) AS safe_fail_pct,
	  ROUND(100.0 * COUNT(*) FILTER (WHERE effective IN ('Requires improvement', 'Inadequate'))
      / COUNT(*), 1) AS effective_fail_pct,
	  ROUND(100.0 * COUNT(*) FILTER (WHERE caring IN ('Requires improvement', 'Inadequate'))
      / COUNT(*), 1) AS caring_fail_pct,
	  ROUND(100.0 * COUNT(*) FILTER (WHERE responsive IN ('Requires improvement', 'Inadequate'))
      / COUNT(*), 1) AS responsive_fail_pct,
	  ROUND(100.0 * COUNT(*) FILTER (WHERE well_led IN ('Requires improvement', 'Inadequate'))
      / COUNT(*), 1) AS well_led_fail_pct
FROM v_care_homes
 WHERE overall IN ('Requires improvement', 'Inadequate')
	