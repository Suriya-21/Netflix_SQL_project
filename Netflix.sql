-- Netflix Project
dROP TABLE IF EXISTS Netflix;
CREATE TABLE Netflix(
show_id	VARCHAR(10),
type VARCHAR(10),	
title VARCHAR(150),	
director VARCHAR(250),	
casts VARCHAR(1000),	
country	VARCHAR(150),
date_added VARCHAR(50),	
release_year INT, 	
rating VARCHAR(10),	
duration VARCHAR(20),	
listed_in VARCHAR(100),	
description VARCHAR(300)
);

Select * from Netflix;
Select distinct type from Netflix;
Select count (*) from Netflix;

-- 1.Count the number of Movies and TV Shows
	
	SELECT 
	type,
	COUNT (*) AS total_content FROM Netflix
	GROUP BY type

-- 2.Find the most common rating for Movies and TV Shows
	WITH T1 AS(
	SELECT type,rating, COUNT(*) as total_titles
	FROM Netflix
	GROUP BY type,rating
	),
	T2 AS(
	SELECT type,rating,total_titles,
	RANK() OVER(PARTITION BY type ORDER BY total_titles DESC) as ranking
	FROM T1
	)
	SELECT type,rating
	FROM T2
	WHERE ranking = 1

-- 3. List all the Movies in a Specific year (Eg. 2020)
	SELECT * FROM Netflix
	WHERE 
		type = 'Movie' AND release_year = 2020

-- 4. Find the top 5 countries with the most content on Netflix
	SELECT 
		TRIM(UNNEST(STRING_TO_ARRAY(country,','))) as new_country,
		COUNT(show_id) as totalcontent
		FROM Netflix
		GROUP BY new_country ORDER BY totalcontent DESC

-- 5. Identify the longest movie
	SELECT * FROM Netflix
	WHERE 
		type = 'Movie' 
		AND
		duration = (SELECT MAX(duration) FROM Netflix)

-- 6. Find the content that was added in the last 5 years
	SELECT * FROM Netflix
	WHERE
		TO_DATE(date_added,'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'

-- 7. Find all the Movies/TV Shows by director 'Rajiv Chilaka'
	SELECT * FROM Netflix
		WHERE director LIKE '%Rajiv Chilaka%'

-- 8. List all TV Shows with more than 5 Seasons
	WITH tv_shows AS(
	SELECT 
	*,
	SPLIT_PART(duration,' ',1)::INT AS Seasons
	FROM Netflix 
	WHERE type = 'TV Show'
	)
	SELECT *
	FROM tv_shows
		WHERE Seasons >= 5


-- 9. Count the number of content in each genre
	SELECT 
		UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre,
		COUNT(show_id) AS total_content
		FROM Netflix
		GROUP BY 1;

-- 10. Find the average number of content released by India on Netflix for each year and return top 5 year with high average
	SELECT 
	EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) AS year,
	COUNT(*) as yearly_content,
	ROUND(COUNT(*)::numeric/(SELECT COUNT(*) FROM Netflix  WHERE TRIM(country) = 'India')::numeric * 100, 2) AS avg_content_per_year
	FROM Netflix
	WHERE TRIM(country) ='India'
	GROUP BY year

-- 11. List all the movies that are Documentaries
	SELECT 
	*,
	UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre 
	FROM Netflix
		WHERE type = 'Movie' AND listed_in = TRIM('Documentaries')


--Alternative
	SELECT * FROM Netflix
		WHERE 
			listed_in ILIKE '%documentaries%'

			
-- 12. Find all the content without director
	SELECT * FROM Netflix
		WHERE 
			director IS NULL

-- 13. Movies salman khan appeared in last 10 years
	SELECT * FROM Netflix
		WHERE casts ILIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

-- 14. Find top 10 actors who have appeared in the highest number of movies produced in India
	SELECT 
		UNNEST(STRING_TO_ARRAY(casts,',')) AS actors,
		COUNT(*) AS total_content
		FROM Netflix
		WHERE country ILIKE '%India%'
		GROUP BY actors
		ORDER BY total_content DESC
		LIMIT 10


-- 15. Categorize the content based on the presence of keywords 'kill' and 'violence' in the description field. Label the content containing these keywords as 'Bad' and all other as 'Good'. Count how many items fall into each category
		SELECT 
		CASE 
			WHEN description ~* '\mkill'
				OR description ~* '\mviolence'
			THEN 'Bad'
			ELSE 'Good'
		END AS category,
		COUNT (*) AS total_content
		FROM Netflix
		GROUP BY category
		
















		