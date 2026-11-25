-- Queries behind the dashboard

-- KPI cards
SELECT
    COUNT(*) AS students,
    ROUND(100.0 * AVG(CASE WHEN uses_whatsapp = 'Yes' THEN 1 ELSE 0 END), 1) AS pct_use_whatsapp,
    ROUND(100.0 * AVG(CASE WHEN b2 >= 4 THEN 1 ELSE 0 END), 1) AS pct_received_fake_news,
    ROUND(100.0 * AVG(CASE WHEN d1 >= 4 THEN 1 ELSE 0 END), 1) AS pct_missed_class,
    ROUND(AVG(prevalence_score), 2) AS avg_prevalence_score,
    ROUND(100.0 * AVG(CASE WHEN e1 >= 4 THEN 1 ELSE 0 END), 1) AS pct_want_broadcast_list
FROM survey_responses;

-- types of fake news seen (% of students)
SELECT 'Wrong calendar or event dates' AS type, ROUND(100.0 * AVG(c1_type_6), 1) AS pct FROM survey_responses
UNION ALL SELECT 'Strike or resumption rumours', ROUND(100.0 * AVG(c1_type_4), 1) FROM survey_responses
UNION ALL SELECT 'False exam dates', ROUND(100.0 * AVG(c1_type_1), 1) FROM survey_responses
UNION ALL SELECT 'Fake fee deadlines', ROUND(100.0 * AVG(c1_type_2), 1) FROM survey_responses
UNION ALL SELECT 'Timetable changes', ROUND(100.0 * AVG(c1_type_3), 1) FROM survey_responses
ORDER BY pct DESC;

-- how it affects students (% agree)
SELECT 'Missed class, test or assignment' AS effect, ROUND(100.0 * AVG(CASE WHEN d1 >= 4 THEN 1 ELSE 0 END), 1) AS pct FROM survey_responses
UNION ALL SELECT 'Stress or anxiety', ROUND(100.0 * AVG(CASE WHEN d2 >= 4 THEN 1 ELSE 0 END), 1) FROM survey_responses
UNION ALL SELECT 'Poor academic decisions', ROUND(100.0 * AVG(CASE WHEN d3 >= 4 THEN 1 ELSE 0 END), 1) FROM survey_responses
UNION ALL SELECT 'Lost trust in WhatsApp news', ROUND(100.0 * AVG(CASE WHEN d4 >= 4 THEN 1 ELSE 0 END), 1) FROM survey_responses;

-- scale scores by level (table on the dashboard)
SELECT level,
       COUNT(*) AS students,
       ROUND(AVG(prevalence_score), 2) AS prevalence,
       ROUND(AVG(impact_score), 2) AS impact,
       ROUND(AVG(solutions_score), 2) AS solutions,
       ROUND(100.0 * AVG(CASE WHEN b2 >= 4 THEN 1 ELSE 0 END), 1) AS pct_got_fake_news
FROM survey_responses
GROUP BY level
ORDER BY level;

-- respondents by faculty
SELECT faculty, COUNT(*) AS students,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM survey_responses
GROUP BY faculty
ORDER BY students DESC;
