SELECT * FROM netflix

-- Q1 Count the number of Movies vs TV Shows

SELECT
	type,
	COUNT(*) AS total
FROM netflix
GROUP BY TYPE

--Q2 Find the most common rating for movies and TV shows

SELECT
	type,
	rating
FROM
	(SELECT
		type,
		rating,
		COUNT(*),
		 RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
	FROM netflix
	GROUP BY 1,2) 
WHERE ranking = 1	

-- Q3 List all movies released in a specific year (e.g., 2020)

SELECT title, release_year
FROM netflix
WHERE release_year = 2020;

--Q4  Find the top 5 countries with the most content on Netflix

SELECT * 
FROM
(	
	SELECT 
		    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country,
		    COUNT(*) AS total
	FROM netflix
	GROUP BY 1
)
WHERE country IS NOT NULL
ORDER BY total DESC
LIMIT 5;

--Q5 Identify the longest movie

SELECT type,title, duration FROM netflix
WHERE type = 'Movie' AND duration IS NOT NULL
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) DESC
LIMIT 1

--Q6 Find content added in the last 5 years

SELECT title, date_added
FROM netflix
WHERE
	 TO_DATE(date_added,'Month DD,YYYY')>= CURRENT_DATE - INTERVAL '5 years'
	 
--Q7 Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%'
-- Or -> WHERE 'Rajiv Chilaka' = ANY(STRING_TO_ARRAY(director, ', '));

--Q8 List all TV shows with more than 5 seasons

SELECT title,duration FROM netflix
WHERE type = 'TV Show' AND CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) > 5

--Q9 Count the number of content items in each genre

SELECT
        UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
		COUNT(*) AS total
FROM netflix
GROUP BY genre

--Q10 Find each year and the average numbers of content release by India on netflix. 
-- return top 5 year with highest avg content release !
SELECT 
	country,
	release_year,
	COUNT(show_id) as total_release,
	ROUND(
		COUNT(show_id)::numeric/
								(SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100 
		,2
		)
		as avg_release
FROM netflix
WHERE country = 'India' 
GROUP BY country, 2
ORDER BY avg_release DESC 
LIMIT 5

--Q11 List all movies that are documentaries

SELECT type, title, listed_in 
FROM netflix
WHERE type = 'Movie' AND listed_in ILIKE '%Documentaries%'

--Q12 Find all content without a director

SELECT *
FROM netflix
WHERE director IS NULL

--Q13 Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT * FROM netflix
WHERE type = 'Movie' AND casts ILIKE '%Salman Khan%' AND 
release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

--Q14 Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actor,
	COUNT(*)
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

/*
Q15 Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/

SELECT 
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2
