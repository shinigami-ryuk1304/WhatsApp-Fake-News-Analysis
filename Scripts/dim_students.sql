-- Query to clean and standardise the student profile

SELECT
    respondent_id,  -- Unique identifier for each student
    LTRIM(RTRIM(gender)) AS Gender,  -- Removes stray spaces
    REPLACE(age_range, N'–', '-') AS AgeRange,  -- Replaces the long dash with a normal hyphen
    CASE faculty  -- Writes the short faculty names out in full
        WHEN 'ICT' THEN 'Information and Communication Technology'
        ELSE faculty
    END AS Faculty,
    department AS Department,
    CAST(level AS VARCHAR(3)) + ' Level' AS LevelOfStudy,  -- 100 becomes '100 Level'
    level AS LevelOrder,  -- Keeps the number so Power BI sorts 100 to 500 correctly
    owns_smartphone AS OwnsSmartphone,
    uses_whatsapp AS UsesWhatsApp
FROM
    dbo.survey_responses;  -- Raw survey table imported from Data/survey_responses.csv
