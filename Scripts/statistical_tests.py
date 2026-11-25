# One-sample t-tests: is each scale score different from neutral (3)?
import pandas as pd
from scipy.stats import ttest_1samp

df = pd.read_csv("Data/cleaned_survey_responses.csv")

for scale in ["prevalence_score", "impact_score", "solutions_score"]:
    t = ttest_1samp(df[scale], 3)
    print(f"{scale}: mean = {df[scale].mean():.2f}, t({len(df) - 1}) = {t.statistic:.2f}, p = {t.pvalue:.3g}")
