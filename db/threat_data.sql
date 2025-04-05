-- db/setup_threat_data.sql
CREATE TABLE IF NOT EXISTS threat_data (
    id SERIAL PRIMARY KEY,
    ip_address TEXT NOT NULL,
    ports TEXT,
    services TEXT,
    threat_type TEXT,
    risk_score INTEGER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
