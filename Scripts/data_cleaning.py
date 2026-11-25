# Cleans the KWASU fake news survey.
# Input:  Data/raw_survey_responses.csv
# Output: Data/cleaned_survey_responses.csv
# Likert items: 1 = strongly disagree ... 5 = strongly agree. c1_type items: 1 = seen, 0 = not seen.

import pandas as pd

df = pd.read_csv("Data/raw_survey_responses.csv")

# snake_case column names
df.columns = (df.columns.str.strip().str.lower()
              .str.replace(" ", "_").str.replace("-", "_"))

# trim text columns
for col in ["gender", "age_range", "faculty", "department", "owns_smartphone", "uses_whatsapp"]:
    df[col] = df[col].str.strip()

# check every Likert answer is between 1 and 5
likert = [c for c in df.columns if c[0] in "bde" and c[1:].isdigit()] + [c for c in df.columns if c.startswith("c2_")]
bad = ((df[likert] < 1) | (df[likert] > 5)).sum().sum()
print("out-of-range Likert answers:", bad)

# scale scores (average of the seven items in each section)
df["prevalence_score"] = df[[f"b{i}" for i in range(1, 8)]].mean(axis=1).round(2)
df["impact_score"] = df[[f"d{i}" for i in range(1, 8)]].mean(axis=1).round(2)
df["solutions_score"] = df[[f"e{i}" for i in range(1, 8)]].mean(axis=1).round(2)

df.to_csv("Data/cleaned_survey_responses.csv", index=False)
print(len(df), "students saved")
