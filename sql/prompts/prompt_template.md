# Deepfake Misinformation — AI Analysis Prompt Template

**Author:** Imtiaz Laskar  
**Project:** Deepfake Misinformation Data Analysis Pipeline  
**Phase:** AI-Assisted Analysis (Phase 8)  
**Date:** June 2026

---

## Overview

This prompt template was used to run AI-assisted policy analysis on 1,200 deepfake misinformation cases. Each case was analysed by Claude (Anthropic) acting as a Trust & Safety policy analyst, generating structured enforcement recommendations.

**Output fields:**
- `AI_PRIORITY` — High / Medium / Low enforcement priority
- `AI_RECOMMENDED_ACTION` — One sentence enforcement recommendation
- `AI_RISK_FACTOR` — One sentence key risk factor

---

## System Prompt (Context Engineering)

```
You are a Trust & Safety policy analyst reviewing deepfake misinformation cases.

Analyse this case and respond in exactly this format:
PRIORITY: [High/Medium/Low]
ACTION: [one sentence recommended action]
RISK: [one sentence key risk factor]

Case details:
Content Type: [CONTENT_TYPE]
Manipulation: [MANIPULATION_METHOD]
Topic: [TOPIC]
Platform: [PLATFORM]
Region: [GEOGRAPHICAL_REGION]
Veracity: [VERACITY_CLEAN]
Detection Lag: [DETECTION_LAG] days
```

---

## How to Use

1. Copy the prompt template above
2. Replace all `[PLACEHOLDER]` values with actual case data from the dataset
3. Send to Claude or Gemini API
4. Parse the response and populate `AI_PRIORITY`, `AI_RECOMMENDED_ACTION`, `AI_RISK_FACTOR` columns

### Example — Filled Prompt

```
You are a Trust & Safety policy analyst reviewing deepfake misinformation cases.

Analyse this case and respond in exactly this format:
PRIORITY: [High/Medium/Low]
ACTION: [one sentence recommended action]
RISK: [one sentence key risk factor]

Case details:
Content Type: audio
Manipulation: VoiceConversion
Topic: Sports
Platform: YouTube
Region: Latin America
Veracity: mostly-false
Detection Lag: 63 days
```

### Example — AI Response

```
PRIORITY: High
ACTION: Remove content immediately and escalate to YouTube's audio deepfake 
detection pipeline for retroactive scanning of similar VoiceConversion content 
in the Latin America region.
RISK: Sports misinformation spreads virally through fan communities — a 63-day 
undetected window means significant audience exposure and potential reputational 
harm to athletes.
```

---

## Priority Logic (Observed Patterns)

| Condition | Typical Priority |
|---|---|
| LABEL_BINARY = 0 (Authentic) | Low — no action needed |
| Topic = War/Conflict + Fake | High |
| Topic = Health/Medical + Fake | High |
| Topic = Politics + Detection Lag > 90 days | High |
| Topic = Entertainment + Fake | Medium |
| Topic = Sports + Fake | Medium |
| Detection Lag > 150 days | Escalate regardless of topic |

---

## Sample Results (18 Cases)

| Priority | Count | % |
|---|---|---|
| 🔴 High | 8 | 42% |
| 🟡 Medium | 5 | 26% |
| 🟢 Low | 6 | 32% |

**Key Finding:** 42% of sampled cases require immediate High priority enforcement 
action. War/Conflict, Health/Medical, and Political deepfakes consistently flag 
as High regardless of platform or region.

All 6 Low priority cases were confirmed Authentic (LABEL_BINARY = 0), validating 
that the prompt correctly identifies non-actionable content.

---

## Prompt Engineering Notes

- **Role framing** — Assigning the "Trust & Safety policy analyst" role produces 
  more operationally relevant responses than generic analysis prompts
- **Structured output** — Specifying exact format (PRIORITY/ACTION/RISK) ensures 
  consistent parsing across all cases
- **Context richness** — Including Detection Lag alongside content metadata 
  significantly improves priority calibration
- **Veracity scale** — Including VERACITY_CLEAN helps the model distinguish 
  between pants-fire (clear fake) and mostly-true (borderline) cases

---

## Tools Used

- **AI Model:** Claude (Anthropic) — claude-sonnet-4-6
- **Data Source:** BigQuery — deepfake_analysis.deepfake_clean
- **Analysis Sheet:** Google Sheets — Deepfake_AI_Analysis
- **Dataset Size:** 1,200 cases (18 analysed in sample)
