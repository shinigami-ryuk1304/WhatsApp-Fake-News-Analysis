-- Query to build the solutions score (how much students support each fix)

SELECT
    respondent_id,  -- Unique identifier for each student
    e1, e2, e3, e4, e5, e6, e7,  -- The seven proposed solutions (1 to 5)
    ROUND((e1 + e2 + e3 + e4 + e5 + e6 + e7) / 7.0, 2) AS SolutionsScore,  -- Average of the seven items
    CASE WHEN e1 >= 4 THEN 1 ELSE 0 END AS WantsBroadcastList,  -- Official university WhatsApp broadcast list
    CASE WHEN e5 >= 4 THEN 1 ELSE 0 END AS WantsDigitalLiteracy,  -- Digital literacy in orientation
    CASE WHEN e7 >= 4 THEN 1 ELSE 0 END AS WantsRepsToVerify  -- Course reps verify before sharing
FROM
    dbo.survey_responses;
