import pandas as pd
from scipy.stats import ttest_1samp

# Define a function to fetch the survey data from SQL Server
def fetch_data_from_sql():
    import pyodbc  # only needed when reading from SQL Server
    conn_str = (
        "Driver={SQL Server};"
        "Server=localhost\\SQLEXPRESS;"  # Change this to your own SQL Server instance
        "Database=KwasuSurveyDB;"
        "Trusted_Connection=yes;"
    )
    conn = pyodbc.connect(conn_str)
    df = pd.read_sql("SELECT * FROM dbo.survey_responses", conn)
    conn.close()
    return df

# If SQL Server is not available, read the same data from the CSV
try:
    survey = fetch_data_from_sql()
except Exception:
    survey = pd.read_csv("../Data/survey_responses.csv")

# Average score for each section (same formulas as the SQL scripts)
survey["prevalence_score"] = survey[[f"b{i}" for i in range(1, 8)]].mean(axis=1)
survey["impact_score"] = survey[[f"d{i}" for i in range(1, 8)]].mean(axis=1)
survey["solutions_score"] = survey[[f"e{i}" for i in range(1, 8)]].mean(axis=1)

# One-sample t-test: is the average different from 3 (the neutral point)?
results = []
for scale in ["prevalence_score", "impact_score", "solutions_score"]:
    t = ttest_1samp(survey[scale], 3)
    results.append({
        "Scale": scale,
        "Mean": round(survey[scale].mean(), 2),
        "T": round(t.statistic, 2),
        "DegreesOfFreedom": len(survey) - 1,
        "PValue": "< 0.001" if t.pvalue < 0.001 else round(t.pvalue, 3),
    })
results = pd.DataFrame(results)
print(results)

# Scores by level of study, for the table on the dashboard
by_level = survey.groupby("level")[["prevalence_score", "impact_score", "solutions_score"]].mean().round(2)
print(by_level)

results.to_csv("t_test_results.csv", index=False)
by_level.to_csv("scores_by_level.csv")
