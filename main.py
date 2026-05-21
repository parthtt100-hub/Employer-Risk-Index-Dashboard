import pandas as pd 
import numpy as np
df =  pd.read_csv("C:\\Employer Risk Index Fake Job\\fake job posting.csv")

A = df.head ()

B = df.info()

C = df.isnull().sum().sort_values(ascending=False)

D = df.shape

E = df.columns

text_cols =[
            "company_profile","description","requirements",
    "benefits","salary_range","location"

]

for col in text_cols:
    df[col] = df[col].fillna("")



V = df["short_description"] = df["description"].apply(lambda x: 1 if len(x)<200 else 0)
W = df["no_logo"] = np.where(df["has_company_logo"]==0,1,0)
X = df["no_requirements"] = np.where(df["requirements"]=="",1,0)
Y = df["missing_company_profile"] = np.where(df["company_profile"]=="",1,0)
Z = df["missing_salary"] = np.where(df["salary_range"]=="",1,0)

scam_words = [
"quick money","earn from home","no experience",
"urgent hiring","easy money","investment",
"click here","limited seats","work from home"
]

def keyword_count(text):
    text = str(text).lower()
    return sum(word in text for word in scam_words)

df["suspicious_keyword_count"] = df["description"].apply(keyword_count)


R = df["remote_high_salary"] = np.where(
    (df["telecommuting"]==1) & (df["salary_range"]!=""),
    1,0
)

I = df["risk_score"] = (
    df["missing_company_profile"]*20 +
    df["missing_salary"]*15 +
    df["short_description"]*10 +
    df["no_requirements"]*15 +
    df["no_logo"]*10 +
    df["remote_high_salary"]*25 +
    df["suspicious_keyword_count"]*5
)

def risk_category(score):
    if score <= 30:
        return "Low Risk"
    elif score <= 60:
        return "Medium Risk"
    else:
        return "High Risk"

df["risk_category"] = df["risk_score"].apply(risk_category)



from sqlalchemy import create_engine

df.to_csv("employer risk processed.csv", index=False)

engine = create_engine("mysql+mysqlconnector://root:liveptrak@127.0.0.1:3306/Employer_Risk_Index")

df.to_sql(
    name="data",
    con=engine,
    if_exists="replace",
    index=False
)

print (df.isnull().sum())

print("Data successfully loaded into MySQL!")