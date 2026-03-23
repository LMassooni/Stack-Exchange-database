SELECT 'tag', 'n_questions'
UNION ALL
SELECT t.TagName tag, count(*) n_questions -- We will pull the number of questions for each Tag 
INTO OUTFILE '/var/lib/mysql-files/questionsxtags.csv' -- Save in the right folder (the one with the default permission)
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
FROM Posts p INNER JOIN Tags t 
ON p.Tags LIKE LOWER(CONCAT('%',t.TagName,'%')) -- Stack exchange puts all the tags in a post toghether, on a big string like |python|sql|pandas| etc. If the data files were bigger, it would be better to create new collumn for it (and add an index to it)
WHERE p.PostTypeId = 1  -- only questions
AND LENGTH(p.Body)>10 -- The question need to be more than 10 letters long (in case of a post not intend)
AND Score>10 -- low scores will not be count
GROUP BY t.TagName 
HAVING n_questions > 5 -- Tags mentioned less then 5 times will not be count as well
ORDER BY n_questions DESC;

