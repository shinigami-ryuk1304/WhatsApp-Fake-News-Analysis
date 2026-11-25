-- Query to turn the seven "have you seen this" columns into one long table
-- (one row per student per type), which is easier to chart in Power BI

SELECT respondent_id, 'False exam dates' AS MisinformationType, c1_type_1 AS Seen FROM dbo.survey_responses  -- 1 = seen, 0 = not seen

UNION ALL

SELECT respondent_id, 'Fake fee payment deadlines' AS MisinformationType, c1_type_2 AS Seen FROM dbo.survey_responses

UNION ALL

SELECT respondent_id, 'Incorrect lecture cancellations or timetable changes' AS MisinformationType, c1_type_3 AS Seen FROM dbo.survey_responses

UNION ALL

SELECT respondent_id, 'Misleading school resumption or strike information' AS MisinformationType, c1_type_4 AS Seen FROM dbo.survey_responses

UNION ALL

SELECT respondent_id, 'Fake course registration instructions' AS MisinformationType, c1_type_5 AS Seen FROM dbo.survey_responses

UNION ALL

SELECT respondent_id, 'Misstated academic calendar or event dates' AS MisinformationType, c1_type_6 AS Seen FROM dbo.survey_responses

UNION ALL

SELECT respondent_id, 'Other academic rumours or false memos' AS MisinformationType, c1_type_7 AS Seen FROM dbo.survey_responses;
