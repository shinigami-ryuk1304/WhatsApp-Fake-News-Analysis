-- Query to build the prevalence score (how common fake academic news is)
-- Answers are on a 1 to 5 scale: 1 = strongly disagree, 5 = strongly agree

SELECT
    respondent_id,  -- Unique identifier for each student
    b1, b2, b3, b4, b5, b6, b7,  -- The seven prevalence statements
    ROUND((b1 + b2 + b3 + b4 + b5 + b6 + b7) / 7.0, 2) AS PrevalenceScore,  -- Average of the seven items
    CASE  -- Groups the score into levels for the dashboard
        WHEN (b1 + b2 + b3 + b4 + b5 + b6 + b7) / 7.0 >= 4 THEN 'High'
        WHEN (b1 + b2 + b3 + b4 + b5 + b6 + b7) / 7.0 >= 3 THEN 'Moderate'
        ELSE 'Low'
    END AS PrevalenceLevel,
    CASE WHEN b2 >= 4 THEN 1 ELSE 0 END AS ReceivedFakeNews,  -- Agreed they have received false academic info
    c2_q8 AS AlwaysCrossChecks,  -- Verification habits (1 to 5)
    c2_q9 AS ReliesOnWhatsAppOverOfficial,
    c2_q10 AS ActedOnFakeNews,
    c2_q11 AS StudentsShouldVerify
FROM
    dbo.survey_responses;
