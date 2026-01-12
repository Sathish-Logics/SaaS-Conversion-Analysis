# SaaS Behavioral Analysis: The Conversion Paradox

## 📌 Project Summary
This project analyzes the "Aha! Moment" for a SaaS startup. Using **SQL** to aggregate user logs and **Python** to calculate conversion probabilities, I investigated which user actions lead to paid subscriptions.

# 🛠️ Technical Process
1. **SQL (PostgreSQL):** Performed data joins and used CTEs to aggregate total user activity.
2. **Python (Pandas):** Grouped users by activity level to calculate mean conversion rates.
3. **Visualization:** Plotted the user journey to identify friction points in the sales funnel.

## 📊 Findings: Activity vs. Conversion
The analysis revealed a "Conversion Paradox." While we expected higher activity to drive more sales, we found that conversion rates dropped as users interacted more with the "Upload" feature.

| Total User Uploads | Conversion Rate (Probability) |
| :--- | :--- |
| **0 Uploads** | **61%** |
| **1 Upload** | **53%** |
| **2 Uploads** | **28%** |



## 💡 Strategic Recommendations
* **Identify Friction:** The drop from 61% to 28% suggests that users who actually *use* the product are encountering obstacles (bugs or poor UI).
* **UX Audit:** I recommend a technical review of the "Upload" flow to prevent "Active User Churn."
* **Marketing Pivot:** Focus on the "Immediate Value" of the Pro plan, as users are currently converting before even using the core features.
