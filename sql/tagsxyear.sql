
-- First, create a subquery that will be used in the window function LAG
WITH ly AS (SELECT t.TagName AS tag, YEAR(p.CreationDate) AS years, count(*) AS n_questions -- ly will be the subquery used. It will contain the tag, the year, and couting of questions
FROM Posts p INNER JOIN Tags t
ON p.Tags LIKE CONCAT('%',t.TagName,'%')
WHERE p.PostTypeId = 1
GROUP BY t.TagName, YEAR(p.CreationDate)
HAVING n_questions > 5 -- We will use only tags with more than 5 questions
ORDER BY YEAR(p.CreationDate))

SELECT 'tag','years','n_questions','last year', 'cy-ly'
UNION ALL
SELECT tag, years, n_questions, 
LAG(n_questions) -- Catch the questions in the last year per tag
OVER(PARTITION BY tag ORDER BY years) AS prev_year, 
n_questions - LAG(n_questions) -- Count the difference of questions between two consecutive year for each tag
OVER(PARTITION BY tag ORDER BY years) AS growth 
INTO OUTFILE '/var/lib/mysql-files/tagsxyear.csv' 
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
FROM ly 
ORDER BY tag, years;

