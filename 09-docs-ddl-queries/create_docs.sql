
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TABLE docs.documents (
    id SERIAL PRIMARY KEY,
    document TEXT NOT NULL
);

CREATE INDEX gin_idx_document ON docs.documents USING GIN (document gin_trgm_ops);

