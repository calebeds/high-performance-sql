SELECT
 id,
 similarity(document, 'commercial know') AS sim_score,
 document
FROM
 docs.documents
WHERE
 document ILIKE '%commercial know%'
AND
 similarity(document, 'commercial know') > 0.06
ORDER BY 
 sim_score
