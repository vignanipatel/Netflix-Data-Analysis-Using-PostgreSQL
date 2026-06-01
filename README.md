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


