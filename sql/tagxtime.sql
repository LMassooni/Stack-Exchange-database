-- USE THE THREE LINES ABOVE ONLY ONCE

-- ALTER TABLE Posts
-- MODIFY COLUMN CreationDate Date 
-- MODIFY COLUMN ClosedDate Date -- If you get the .XML tables of stack exchange, the process of converting to csv and up to a database in MySQL will convert the dates to strings. This lines will convert the string date to the format YY-MM-DD. (we don't need the time for this analysis)

SELECT 'tag','year','month','n_questions'
UNION ALL
SELECT t.TagName, YEAR(p.CreationDate),MONTH(p.CreationDate), count(*) n_questions -- We will separete the query to tag, year, month and count que amount of questions in each month 
INTO OUTFILE '/var/lib/mysql-files/timextags.csv' 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
FROM Posts p INNER JOIN Tags t 
ON p.Tags LIKE LOWER(CONCAT('%',t.TagName,'%'))
WHERE ClosedDate > CreationDate -- To treat errors in the system, in case of Close Date were before the creation of the post
group by MONTH(p.CreationDate), YEAR(p.CreationDate), t.TagName
HAVING n_questions > 2 -- We will use only tags with more than 2 questions
