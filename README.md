# WhatsApp Fake News Analysis (Kwara State University)

At KWASU most academic updates move through WhatsApp class groups, and so does a lot of false information: fake exam dates, fake fee deadlines, strike rumours. Students act on these messages and some of them miss classes or tests because of it. I designed the analysis for a survey of 400 students and analysed it to measure how common the problem is, how it affects students and what they think would fix it.

Key Points:
* WhatsApp is the main channel: almost every student gets academic news from class groups.
* False updates spread fast: fake dates and rumours reach most students.
* Real effects: missed classes, stress and bad decisions.
* Official channels are slow, so students fall back on whatever is forwarded to them.

Tools I used: Python (pandas, SciPy), SQL, SPSS, Excel, Power BI

Data: 400 students across six faculties, all levels, collected in 2025. Most questions use a 5-point scale (1 = strongly disagree, 5 = strongly agree).

## Objectives
1. Measure how common fake academic news is on WhatsApp
2. Find the most common types
3. See how it affects students' studies, stress levels and decisions
4. Find out which solutions students support

## Dashboard
![WhatsApp Fake News Dashboard](Dashboard/dashboard.png)

## What I found
* 97.5% of the students use WhatsApp, and 68% agreed they have received false academic information on it.
* Roughly 4 in 5 students have seen wrong calendar dates, strike or resumption rumours, or false exam dates.
* 59% missed a class, test or assignment because of fake news, and 56% said it caused them stress or anxiety.
* Only 38% always cross-check what they receive.
* All three scale scores are clearly above neutral (one-sample t-tests, all p < .001): how common it is (3.90 out of 5), its impact (3.56) and support for solutions (4.01).

## Recommendations
* An official university WhatsApp broadcast list for verified updates (77% support it)
* Digital literacy as part of student orientation (77%)
* Course reps should confirm information before sharing it in class groups
* Lecturers and departments should post updates faster, so rumours have less room

## Repo structure
```
Data/
  raw_survey_responses.csv        original export
  cleaned_survey_responses.csv    after data_cleaning.py
  codebook.csv                    what each column means
Scripts/
  data_cleaning.py
  01_create_table.sql
  02_data_checks.sql
  03_analysis_queries.sql
  statistical_tests.py
Dashboard/
  dashboard.png / dashboard.html
  Excel workbook (dashboard, charts, data, tests)
```

## How to run it
1. Run `python Scripts/data_cleaning.py` to create the cleaned file in the Data folder.
2. Create the table with `Scripts/01_create_table.sql`, load `Data/cleaned_survey_responses.csv` into it, then run `02_data_checks.sql` and `03_analysis_queries.sql`. I wrote them in standard SQL, so they run in SQL Server, PostgreSQL, MySQL 8 or SQLite.
3. Run `python Scripts/statistical_tests.py` for the hypothesis tests.
4. Open the Excel workbook in the Dashboard folder, or load it into Power BI (Get data > Excel workbook).

Researcher and analyst: Daniel Oluwaseun David. The data is anonymised, students are identified only by a number.
