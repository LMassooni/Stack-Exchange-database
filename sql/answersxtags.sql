SELECT t.TagName tags, count(p.Id) questions_w_a -- Again, we will get Id count per tagname, now only for those questions that has answers
INTO OUTFILE '/var/lib/mysql-files/answersxtags.csv' 
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'  
FROM Posts p INNER JOIN Tags t  
ON p.Tags LIKE LOWER(CONCAT('%',t.TagName,'%')) -- The same case of questionsxtags
WHERE p.PostTypeId = 1 -- only questions have tags attach to them
AND LENGTH(p.Body) > 10 -- Only questions higher than 10 letters
AND p.Score > 10 -- minimum score
AND p.Id IN (
(SELECT ps.ParentId 
FROM Posts ps 
WHERE ps.ParentId != "NULL") -- Subquery that returns the Id of the questions that receive answers
) 
GROUP BY t.TagName;
