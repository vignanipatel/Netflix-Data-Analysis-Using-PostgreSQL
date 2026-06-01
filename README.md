# Netflix-Data-Analysis-Using-PostgreSQL
Performed end-to-end Netflix content analysis using PostgreSQL, including data cleaning, exploratory data analysis, and business insights generation from 8,800+ records.

# Project Overview

This project analyzes Netflix's content catalog using PostgreSQL to uncover trends in content distribution, genre popularity, audience targeting, country-wise contributions, and Netflix's global expansion strategy.

Dataset Size: 8,807 Titles

# Tools Used:
- PostgreSQL
- SQL
- GitHub
- Data Cleaning
- Standardized Country Names

## Dataset

The data for this project is sourced from the Kaggle dataset.

Dataset Link: [Netflix Movies and TV Shows](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

# UPDATE netflix_clean
```sql
SET country = TRIM(country);
```
# Handled Missing Values
```sql
UPDATE netflix_clean
SET country = 'Unknown'
WHERE country IS NULL;
```
# Created Analysis Table
```sql
CREATE TABLE netflix_clean AS
SELECT *
FROM netflix;
```
# Business Questions
# 1: Movies vs TV Shows Distribution
SQL Query
```sql
SELECT
    type,
    COUNT(*) AS total_content
FROM netflix_clean
GROUP BY type;
```
Result
Type	   Total Content
Movie	      6131
TV Show	    2676

# Insight
Netflix's catalog is dominated by movies, which account for approximately 70% of all content.

Business Question 2: Top Content Producing Countries
SQL Query
SELECT
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name,
    COUNT(*) AS total_titles
FROM netflix_clean
WHERE country IS NOT NULL
GROUP BY country_name
ORDER BY total_titles DESC
LIMIT 10;
Result
Country	Titles
United States	3689
India	1046
United Kingdom	806
Insight

The United States is Netflix's largest content-producing country, while India is the second-largest contributor.

Business Question 3: Most Popular Genres
SQL Query
SELECT
    TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) AS genre,
    COUNT(*) AS total_titles
FROM netflix_clean
GROUP BY genre
ORDER BY total_titles DESC
LIMIT 10;
Result
Genre	Titles
International Movies	2752
Dramas	2427
Comedies	1674
Insight

Netflix focuses heavily on international content and drama-based entertainment.

Business Question 4: Rating Distribution
SQL Query
SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_clean
GROUP BY rating
ORDER BY total_titles DESC;
Result
Rating	Titles
TV-MA	3207
TV-14	2160
Insight

Netflix primarily targets mature and teenage audiences.

Business Question 5: Documentary Content Analysis
SQL Query
SELECT
    COUNT(*) AS documentaries
FROM netflix_clean
WHERE type = 'Movie'
AND listed_in ILIKE '%Documentaries%';
Result

869 Documentary Movies

Insight

Netflix maintains a strong documentary portfolio to attract educational and knowledge-focused viewers.

Business Question 6: Top Directors
SQL Query
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_clean
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;
Insight

A small number of directors contribute a significant portion of Netflix's content.

Business Question 7: India Market Analysis
SQL Query
SELECT
    COUNT(*) AS india_titles
FROM netflix_clean
WHERE country ILIKE '%India%';
Result

1046 Titles

Insight

India is Netflix's second-largest content-producing market, demonstrating strong investment in regional content.

Business Question 8: Content Added Per Year
SQL Query
SELECT
    EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) AS added_year,
    COUNT(*) AS total_titles
FROM netflix_clean
GROUP BY added_year
ORDER BY added_year;
Insight

Netflix experienced rapid content growth after 2016 as the platform expanded globally.

Business Question 9: Longest Movie on Netflix
SQL Query
SELECT
    title,
    duration
FROM netflix_clean
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration,' ',1)::INT DESC
LIMIT 1;
Result

Black Mirror: Bandersnatch — 312 min

Insight

Netflix offers content with diverse durations to satisfy different viewing preferences.

Business Question 10: COVID-19 Impact Analysis
SQL Query
SELECT
    EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) AS added_year,
    COUNT(*) AS total_titles
FROM netflix_clean
WHERE EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) BETWEEN 2018 AND 2021
GROUP BY added_year
ORDER BY added_year;
Insight

Netflix maintained strong content additions during the pandemic period, reflecting increased streaming demand.

Key Findings
Movies dominate Netflix's catalog (6,131 titles).
United States is the largest content producer (3,689 titles).
India is the second-largest market (1,046 titles).
International Movies is the most popular genre (2,752 titles).
TV-MA is the dominant content rating (3,207 titles).
Netflix hosts 869 documentary movies.
The platform's strategy strongly emphasizes global and regional content expansion.
Skills Demonstrated
PostgreSQL
SQL
Data Cleaning
Exploratory Data Analysis (EDA)
Data Transformation
Business Insight Generation
Data Storytelling
Analytical Thinking
Author

Vignani Erram

Aspiring Data Analyst | SQL | PostgreSQL | Excel | Power BI

This format looks professional, shows your SQL skills, and is exactly the kind of README recruiters are likely to review.


