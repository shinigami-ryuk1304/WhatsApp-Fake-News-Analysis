-- Query to build the impact score (how fake news affects students)

SELECT
    respondent_id,  -- Unique identifier for each student
    d1, d2, d3, d4, d5, d6, d7,  -- The seven impact statements (1 to 5)
    ROUND((d1 + d2 + d3 + d4 + d5 + d6 + d7) / 7.0, 2) AS ImpactScore,  -- Average of the seven items
    CASE WHEN d1 >= 4 THEN 1 ELSE 0 END AS MissedClassOrTest,  -- Agreed fake news made them miss a class, test or assignment
    CASE WHEN d2 >= 4 THEN 1 ELSE 0 END AS FeltStressOrAnxiety,
    CASE WHEN d3 >= 4 THEN 1 ELSE 0 END AS MadePoorDecisions,
    CASE WHEN d4 >= 4 THEN 1 ELSE 0 END AS LostTrust
FROM
    dbo.survey_responses;
