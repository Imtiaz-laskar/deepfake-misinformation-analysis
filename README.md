# 🔍 Deepfake Misinformation Analysis Pipeline

An end-to-end data analysis project analysing 1,200 deepfake misinformation cases across platforms, regions, and content types — using BigQuery SQL, AI-assisted prompt engineering, and a live Looker Studio dashboard.

---

## 📊 Live Dashboard
👉 ** https://datastudio.google.com/s/v8yqmzr8e2g (#)** 

---

## 🧰 Tech Stack

| Tool | Purpose |
|---|---|
| Google Sheets | Data cleaning & transformation |
| BigQuery | Cloud SQL analysis |
| Looker Studio | Interactive dashboard |
| Claude API | AI-assisted enforcement analysis |
| GitHub | Version control & portfolio |

---

## 📁 Project Structure

```
deepfake-misinformation-analysis/
│
├── data/
│   └── Deepfake_Misinformation_Dataset.csv   # Raw dataset (Kaggle)
│
├── sql/
│   └── deepfake_all_queries.sql              # All 4 BigQuery SQL queries
│
├── prompts/
│   └── prompt_template.md                    # AI analysis prompt template
│
├── docs/
│   └── Deepfake_Project_Handbook_v3.docx     # Full project handbook
│
└── README.md
```

---

## 🔄 Pipeline Overview

```
Kaggle CSV → Google Sheets → BigQuery → Looker Studio
                                ↓
                        AI-Assisted Analysis
                        (Claude Prompt Engineering)
```

---

## 📋 Step-by-Step Process

### Step 1 — Data Sourcing
- Downloaded Deepfake Misinformation Dataset from Kaggle
- 1,200 records spanning 2019–2023

### Step 2 — Data Cleaning (Google Sheets)
- Found mixed formats in `VERACITY_SCALE` column (descriptive labels + boolean TRUE/FALSE)
- Fixed using `=IF(G2=TRUE,"true",IF(G2=FALSE,"false",G2))` formula
- Verified with `=UNIQUE()` — all 6 values consistent

### Step 3 — Analysis Columns Added
- `DETECTION_LAG_DAYS` → `=DAYS(C2,B2)` — days between publish and detection
- `DETECTION_SPEED` → `=IF(K2<=30,"Fast",IF(K2<=90,"Medium","Slow"))`

### Step 4 — BigQuery Setup
- Created dataset: `deepfake_analysis` (region: asia-south1)
- Uploaded cleaned CSV as table: `deepfake_cases`
- Created view: `deepfake_clean` (renamed columns, added calculated fields)

### Step 5 — SQL Analysis
4 queries written and saved in BigQuery:

```sql
-- Detection lag by platform
SELECT `PLATFORM`,
  COUNT(*) AS total_cases,
  ROUND(AVG(DATE_DIFF(`DETECTION DATE`, `PUBLICATION DATE`, DAY)), 1) AS avg_lag
FROM `deepfake_analysis.deepfake_cases`
GROUP BY `PLATFORM`
ORDER BY avg_lag DESC;
```
> Full queries in `/sql/deepfake_all_queries.sql`

### Step 6 — Data Validation
| Check | Result |
|---|---|
| Total rows | ✅ 1,200 |
| Missing dates | ✅ 0 |
| Negative lags | ✅ 0 |

### Step 7 — Looker Studio Dashboard
Connected BigQuery → Looker Studio. Built 7 components:
- 3 Scorecards (Total Cases, Fake Cases, Avg Detection Lag)
- Bar chart — Cases by Platform
- Pie chart — Content Type Breakdown
- Horizontal bar — Cases by Region
- Pie chart — Detection Speed (Fast/Medium/Slow)

### Step 8 — AI-Assisted Analysis
Used Claude as a T&S policy analyst to review 18 sample cases:

```
You are a Trust & Safety policy analyst reviewing deepfake misinformation cases.
Analyse this case and respond in exactly this format:
PRIORITY: [High/Medium/Low]
ACTION: [one sentence recommended action]
RISK: [one sentence key risk factor]
```

Results across 18 cases:
- 🔴 High Priority: 8 cases (42%)
- 🟡 Medium Priority: 5 cases (26%)
- 🟢 Low Priority: 6 cases (32%)

> Full prompt template in `/prompts/prompt_template.md`

---

## 🔑 Key Findings

| Finding | Insight |
|---|---|
| Avg detection lag | 90.32 days across all cases |
| Slowest platform | WhatsApp Forward — 100.6 days avg |
| Fastest platform | News Websites — 80.7 days avg |
| Hardest content type | Audio — 96.5 days avg detection lag |
| Highest fake ratio | South Asia — 88% of flagged cases are fake |
| Detection speed | 50.2% of cases classified as Slow (>90 days) |
| Fake content volume | 984 out of 1,200 cases confirmed fake (82%) |

---

## 📂 Dataset

- **Source:** [Kaggle — Deepfake Misinformation Dataset](https://www.kaggle.com)
- **Size:** 1,200 rows × 10 columns
- **Period:** 2019–2023
- **Platforms:** YouTube, TikTok, Facebook, Twitter/X, Instagram, WhatsApp, Reddit, Telegram, Weibo, News Websites
- **Regions:** 9 geographical regions globally

---

## 👤 Author

**Imtiaz Hussain Laskar**  
LinkedIn: https://www.linkedin.com/in/imtiazhlaskar/
---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
