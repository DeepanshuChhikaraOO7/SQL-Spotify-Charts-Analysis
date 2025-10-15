# 🎧 Data Analysis Project – Spotify Global Charts

## Project Overview
This project analyzes Spotify’s global and regional chart data to uncover music trends, artist performance, and streaming behavior. The analysis is designed to replicate a **real-world data analysis task** you might encounter as a Data Analyst at Spotify or any music streaming company.

The project demonstrates how to:

- Handle large datasets using **SQL**.
- Perform **Exploratory Data Analysis (EDA)** without visualization.
- Generate **business insights** from chart trends, streaming patterns, and artist performance.
- Provide **actionable recommendations** for playlist curation and regional promotion strategies.

---

## Dataset

**Source:** [Spotify Charts](https://www.kaggle.com/datasets/dhruvildave/spotify-charts/data)   
**Data Tracked:**

| Column      | Description |
|------------|-------------|
| title      | Song title |
| artist     | Artist(s) name |
| rank       | Position on chart |
| date_chart | Date of the chart |
| region     | Country or Global region |
| chart      | Chart type (Top200 / Viral50) |
| trend      | Movement vs previous day (up, down, new, re-entry, same) |
| streams    | Number of plays (NULL for Viral50) |

---

## Tools & Environment

- **PostgreSQL using Dbeaver**: SQL queries for all EDA and analysis.
- **SQL Queries**: Clean, commented, business-focused queries.
- **Markdown**: Findings and insights summarized for presentation.

**Project Creation Workflow:**

1. Imported raw CSV data into PostgreSQL.
2. Created a clean schema with the `spotify_chart` table.
3. Checked and cleaned missing values (streams NULL for Viral50 only).
4. Generated aggregated insights using SQL queries for each business question.
5. Summarized findings in this README to mimic a real-world deliverable.

---

## Key Business Questions & Insights

### 1️⃣ Popularity & Rankings
- **Most days at #1 globally:** *Dance Monkey* (131 days).  
- **Top 10 most-streamed songs:** *Shape of You*, *Blinding Lights*, *Dance Monkey*, and more with billions of streams.  
- **Artists with most #1 songs globally:** Ed Sheeran, Justin Bieber, Taylor Swift.  
- **Longest charting songs (Top200):** *Shape of You*, *Believer*, *Perfect* show extreme longevity across regions.

---

### 2️⃣ Regional & Global Trends
- **Regions with highest streams:** US leads, followed by Brazil, Mexico (excluding Global).  
- **Regional differences:** US artists have ~70% more average streams than Indian artists. Global artists outperform both US and Indian artists.  
- **Songs #1 regionally but not globally:** 1250+ songs, highlighting strong local preferences.  
- **Local vs International Artists:** International artists generally achieve better average ranks than local artists.

---

### 3️⃣ Streaming Patterns
- **Highest streaming day:** Saturday globally.  
- **Fastest rank climbs:** Using LAG() window function, detected songs that jump significantly overnight.  
- **Sudden drops:** Identified songs with the fastest declines in rank or streams.  
- **Strongest debut (new entries):** *Photograph* had the highest streams on release day.

---

### 4️⃣ Artist & Song Performance
- **Total streams per artist** and **average streams per song** calculated for Top200 chart.  
- **Artists dominating multiple regions:** Ed Sheeran leads globally.  
- **One-hit wonders:** Artists like Sia and Major Lazer with extremely high-streaming single tracks.

---

## Strategic Recommendations
1. **Playlist Curation for Indian Artists:**  
   - Focus on cross-regional promotion and inclusion in global playlists.
   - Create “fusion” playlists mixing Indian tracks with international hits.  
   - Encourage targeting audiences outside India to boost global reach.

2. **Artist Growth Metrics:**  
   - Track **average streams, peak rank, total weeks charted**.
   - Analyze retention: how long songs stay in Top50 to optimize promotional campaigns.

---

## Deliverables
- **SQL Queries:** Clean, commented queries answering each business question.  
- **EDA Summary Tables:** Top 10 songs, top 10 artists, streams by region, rank trends.  
- **Business Insights Report:** Summarized key takeaways and actionable strategies.

---

## Why This Project Matters
This project demonstrates to recruiters and hiring managers that you can:

- Handle large-scale datasets efficiently using SQL.
- Extract meaningful insights from real-world music streaming data.
- Think strategically and provide business recommendations based on data.
- Produce clean, professional documentation and deliverables for stakeholders.
