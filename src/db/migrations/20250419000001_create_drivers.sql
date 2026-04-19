-- migrate:up
CREATE TABLE IF NOT EXISTS drivers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    team VARCHAR(255),
    number INTEGER
);

-- Insert sample data
INSERT INTO drivers (name, team, number) VALUES 
    ('Max Verstappen', 'Red Bull Racing', 1),
    ('Lewis Hamilton', 'Mercedes', 44),
    ('Charles Leclerc', 'Ferrari', 16)
ON CONFLICT DO NOTHING;

-- migrate:down
DROP TABLE IF EXISTS drivers;
