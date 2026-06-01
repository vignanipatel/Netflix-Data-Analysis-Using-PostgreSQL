

CREATE TABLE netflix_clean AS
SELECT *
FROM netflix;

SELECT COUNT(*)
FROM netflix_clean;
 
select * from netflix_clean

-- to check the datatype of every coloumn
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'netflix_clean';

-- to check for duplicates
SELECT
    show_id,
    COUNT(*)
FROM netflix_clean
GROUP BY show_id
HAVING COUNT(*) > 1;

-- title duplicates
SELECT
    title,
    COUNT(*)
FROM netflix_clean
GROUP BY title
HAVING COUNT(*) > 1;

-- duplicates found(select only these)
SELECT *
FROM netflix_clean
WHERE title IN ('22-Jul', 'Feb-09', '15-Aug')
ORDER BY title;

-- to find duplicates
WITH dupes AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY title
               ORDER BY show_id
           ) AS rn
    FROM netflix_clean
)
SELECT *
FROM dupes
WHERE rn > 1;  

-- to remove duplicates
WITH dupes AS (
    SELECT ctid,
           ROW_NUMBER() OVER (
               PARTITION BY title
               ORDER BY show_id
           ) AS rn
    FROM netflix_clean
)
DELETE FROM netflix_clean
WHERE ctid IN (
    SELECT ctid
    FROM dupes
    WHERE rn > 1
);

-- to check whether the duplicate is still there or not 
SELECT *
FROM netflix_clean
WHERE title = '22-Jul';

-- to check the null values
SELECT
    COUNT(*) AS total_rows,

    COUNT(*) FILTER (WHERE director IS NULL) AS director_nulls,
    COUNT(*) FILTER (WHERE country IS NULL) AS country_nulls,
    COUNT(*) FILTER (WHERE casts IS NULL) AS cast_nulls,
    COUNT(*) FILTER (WHERE date_added IS NULL) AS date_added_nulls,
    COUNT(*) FILTER (WHERE rating IS NULL) AS rating_nulls,
    COUNT(*) FILTER (WHERE duration IS NULL) AS duration_nulls
FROM netflix_clean;

-- to rename the col name
ALTER TABLE netflix_clean
RENAME COLUMN castw TO casts;


-- to handle director nulls

-- 1)check count 
select count(*)
from netflix_clean
where director is NULL

-- 2)replace 
update netflix_clean
set director = 'not available'
where director is null;

-- update contry
update netflix_clean
set country = 'unknown'
where country is null;

-- verify
select count(*)
from netflix_clean
where country is null

-- update cast nulls
select count(*)
from netflix_clean 
where casts is null;

-- replace
update netflix_clean
set casts = 'not available'
where casts is null;

-- rating
update netflix_clean
set rating = 'not rated'
where rating is null;

-- verify
select count(*) from netflix_clean
where rating is null

-- to change the date format which is in name format
ALTER TABLE netflix_clean
ADD COLUMN added_year INT;

UPDATE netflix_clean
SET added_year =
EXTRACT(
    YEAR
    FROM TO_DATE(date_added,'Month DD, YYYY')
)
WHERE date_added IS NOT NULL;

-- to check
SELECT
    title,
    date_added,
    added_year
FROM netflix_clean
LIMIT 10;

-- Trim Extra Spaces
UPDATE netflix_clean
SET title = TRIM(title);

UPDATE netflix_clean
SET director = TRIM(director);

UPDATE netflix_clean
SET country = TRIM(country);

-- Final Quality Check
SELECT
    COUNT(*) FILTER (WHERE director IS NULL) AS director_nulls,
    COUNT(*) FILTER (WHERE country IS NULL) AS country_nulls,
    COUNT(*) FILTER (WHERE casts IS NULL) AS cast_nulls,
    COUNT(*) FILTER (WHERE rating IS NULL) AS rating_nulls
FROM netflix_clean;

UPDATE netflix_clean
SET listed_in = 'Documentaries'
WHERE listed_in = 'Docuseries';

select * from netflix_clean
where listed_in='Documentaries'

-- to find the unique values
SELECT DISTINCT country
FROM netflix_clean
ORDER BY country;

-- business insights
-- 1. What type of content dominates Netflix?
select type, count(*) as total_content
from netflix_clean
group by type;

select * from netflix_clean
-- 2. Which countries contribute the most content?
-- so actually united states has appeared 2 times so we need to remove by using trim
-- first of all check 
SELECT DISTINCT country
FROM netflix_clean
WHERE country ILIKE '%United States%';

-- update
UPDATE netflix_clean
SET country = TRIM(country);

-- With splitting
SELECT
   TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name,
    COUNT(*)
FROM netflix_clean
GROUP BY country_name
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 3. What are the most popular genres?
select
trim(unnest(string_to_array(listed_in,','))) as popular_genres,
count(*) from netflix_clean
group by 1
order by 2 desc
limit 5;

-- 4. What audience does Netflix target?
select rating, count(*) from netflix_clean
group by rating
order by count(*) desc;

SELECT rating, COUNT(*)
FROM netflix_clean
GROUP BY rating
ORDER BY COUNT(*) DESC;

-- 5. How many documentaries are available?
select count(*)
from netflix_clean
where
type='Movie'
 and listed_in Like '%Documentaries%'

 -- 6. Which directors have contributed the most content?
SELECT
director,
COUNT(*) AS total_titles
FROM netflix_clean
where director is not null
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

-- 7. How important is India to Netflix?
select count(*) 
from netflix_clean
where country like '%India%'

-- 8. What is the longest movie on Netflix?
select title,duration
from netflix_clean
where type ='Movie'
order by split_part(duration,'',1) desc

select duration from netflix_clean 
where duration is null

update netflix_clean
set duration = 'not available'
where duration is null

-- 9. What percentage of Netflix content is international?
select count(*)
from netflix_clean
where listed_in ilike '%international%'



