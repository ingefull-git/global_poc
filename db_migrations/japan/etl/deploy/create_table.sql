-- Japan schema: Create table
CREATE TABLE japan (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL,
    created_to TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
