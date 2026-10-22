-- Q4: Size bands vs % rated Good or Outstanding
-- England (rated homes only)
-- Result: The 1–10 bed band scores 88.2%, but this band is mostly 
--		   learning-disability
--         and autism homes for younger adults. Among the mostly older-people bands,
--         the results are almost flat: 11–29 beds = 81.4%, 30–59 beds = 79.7%,
--         and 60+ beds = 80.1%.
-- Caveat: This pattern is driven by confounding. Client group influences both 
--		   home size
--         and rating, so 'small homes score better' is not a valid conclusion for
--         older-people services. The 1–10 band represents a different sector
--         entirely.
-- (87% of 1–10 bed homes are registered for learning disability/autism; 
--  checked directly
--  in the CQC source file, not shown in this query.)

SELECT CASE WHEN beds <= 10 THEN '1-10'
            WHEN beds <= 29 THEN '11-29'
            WHEN beds <= 59 THEN '30-59'
            WHEN beds >= 60 THEN '60 or more'
            ELSE 'UNKNOWN'
       END AS size_band,
       COUNT(*) AS rated_homes,
       ROUND(100.0 * COUNT(*) FILTER (WHERE overall IN ('Outstanding', 'Good'))
             / COUNT(*), 1) AS pct_good_or_outstanding
FROM v_care_homes
WHERE overall IN ('Outstanding', 'Good', 'Requires improvement', 'Inadequate')  -- the missing line
GROUP BY size_band
ORDER BY size_band ASC;