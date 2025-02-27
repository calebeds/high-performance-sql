SELECT
 id,
 document
FROM
 docs.documents
WHERE
 to_tsvector('english', document) @@ to_tsquery('english', 'history & economics');

ALTER TABLE docs.documents
ADD COLUMN document_tsv tsvector
GENERATED ALWAYS AS (to_tsvector('english', document)) STORED;

CREATE INDEX idx_fts ON docs.documents USING GIN(document_tsv);

SELECT
 id,
 document
FROM
 docs.documents
WHERE
 document_tsv @@ to_tsquery('english', 'history & economics');
