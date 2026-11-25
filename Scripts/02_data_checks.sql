-- Checks after loading

SELECT COUNT(*) AS students FROM survey_responses;

-- students who do not use WhatsApp (kept in, but worth knowing)
SELECT uses_whatsapp, COUNT(*) FROM survey_responses GROUP BY uses_whatsapp;

-- any missing scale answers?
SELECT
    SUM(CASE WHEN b1 IS NULL OR b2 IS NULL OR b7 IS NULL THEN 1 ELSE 0 END) AS missing_prevalence,
    SUM(CASE WHEN d1 IS NULL OR d7 IS NULL THEN 1 ELSE 0 END) AS missing_impact
FROM survey_responses;
