Project Title

*Netflix Content Analysis Using SQL*
--------------------------------------------------
1. What type of content dominates Netflix?
SQL

SELECT type, COUNT(*) AS total_content
FROM netflix_clean
GROUP BY type;

Result
Type	Count
Movie	6131
TV Show	2676

Business Insight

Netflix is heavily movie-focused, with approximately 70% of its catalog consisting of movies.

Recommendation

Continue investing in movies while expanding TV shows that improve viewer retention.
-------------------------------------------------------------------------------------
2. Which countries contribute the most content?
SQL

SELECT
TRIM(UNNEST(STRING_TO_ARRAY(country,','))) AS country,
COUNT(*) AS total_titles
FROM netflix_clean
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

Result
Country	Titles
United States	3690
India	1046
United Kingdom	806
Canada	445
France	393

Business Insight

The United States dominates Netflix's content library, while India is the second-largest content contributor.

Recommendation

Netflix should continue investing in high-growth markets such as India.
-----------------------------------------------------------------------------------------------------------------
3. What are the most popular genres?
SQL

SELECT
TRIM(UNNEST(STRING_TO_ARRAY(listed_in,','))) AS genre,
COUNT(*) AS total_titles
FROM netflix_clean
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

Result
Genre	Titles
International Movies	2752
Dramas	2427
Comedies	1674
International TV Shows	1351
Documentaries	869

Business Insight

Netflix strongly focuses on international content, indicating a global content strategy.

Recommendation

Continue expanding multilingual and regional content.
---------------------------------------------------------------------------------------------------------------
4. What audience does Netflix target?
SQL

SELECT rating, COUNT(*)
FROM netflix_clean
GROUP BY rating
ORDER BY COUNT(*) DESC;

Result
Rating	Count
TV-MA	3207
TV-14	2160
TV-PG	863
R	799
PG-13	490

Business Insight

Netflix primarily targets mature and teen audiences.

Recommendation

Balance adult content with family-friendly content to broaden reach.
-------------------------------------------------------------------------------------------------------------
5. How many documentaries are available?
SQL

SELECT COUNT(*)
FROM netflix_clean
WHERE type='Movie'
AND listed_in ILIKE '%Documentaries%';

Result

869 Documentary Movies

Business Insight

Netflix maintains a substantial documentary catalog, showing investment in educational and informational content.

Recommendation

Increase documentary production in trending topics such as technology and true crime.
----------------------------------------------------------------------------------------------------------------------
6. Which directors have contributed the most content?
SQL

SELECT
director,
COUNT(*) AS total_titles
FROM netflix_clean
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

Top Directors

Director	Titles
Rajiv Chilaka	19
Raúl Campos, Jan Suter	18
Marcus Raboy	16
Suhas Kadav	16
Business Insight

A small group of directors contributes a significant amount of content.

Recommendation

Maintain relationships with high-performing content creators.
-------------------------------------------------------------------------------------------------------------------
7. How important is India to Netflix?
SQL

SELECT COUNT(*)
FROM netflix_clean
WHERE country ILIKE '%India%';

Result

1,046 titles

Business Insight

India is Netflix's second-largest content-producing market.

Recommendation

Expand investment in regional-language content such as Telugu, Tamil, and Hindi productions.
------------------------------------------------------------------------------------------------------------------------------
8. Wh
at is the longest movie on Netflix?
SQL
SELECT title, duration
FROM netflix_clean
WHERE type='Movie'
ORDER BY SPLIT_PART(duration,' ',1)::INT DESC
LIMIT 1;

Result

Black Mirror: Bandersnatch — 312 minutes

Business Insight

Netflix offers a wide variety of content lengths to cater to different viewing preferences.
------------------------------------------------------------------------------------------------------------
9. What percentage of Netflix content is international?
SQL

SELECT COUNT(*)
FROM netflix_clean
WHERE listed_in ILIKE '%International%';
Business Insight

International Movies and International TV Shows are among the largest categories.

Recommendation

Netflix's global growth strategy appears highly dependent on international content production.
---------------------------------------------------------------------------------------------------------------------------
10. Which content strategy seems strongest?
Combined Finding
Movies dominate (6131)
International content dominates genres
United States and India dominate production
TV-MA dominates ratings
Final Business Conclusion

Netflix's content strategy is centered around globally distributed movie content targeted primarily at mature audiences, with strong investments in international markets—especially India.

Best 5 Insights to Put on Your Resume / GitHub'

Netflix catalog consists of 6,131 movies and 2,676 TV shows, showing a movie-first strategy.
United States (3,690) and India (1,046) are the largest content-producing countries.
International Movies is the most common genre (2,752 titles).
TV-MA is the most common rating (3,207 titles), indicating a mature audience focus.
Netflix hosts 869 documentary movies, demonstrating significant investment in educational content.

These findings are strong enough to build a GitHub project, Power BI dashboard, and discuss confidently in Data Analyst interviews.