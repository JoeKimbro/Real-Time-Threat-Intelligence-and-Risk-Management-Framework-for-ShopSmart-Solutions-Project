--We would need to change the Fetch-osint data function to fit more api integration, this table really only works for shodan (check line 28 of fetch_osint.py,
also the risk score is hard-coded and needs to be changed in fetch-osint). 

CREATE TABLE threat_data (
    id SERIAL PRIMARY KEY,
    ip_address VARCHAR(45) NOT NULL,        -- IPv4 or IPv6 address
    ports TEXT,                             -- Storing ports as text (converted from list)
    services TEXT,                          -- Storing hostnames/services as text
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    risk_score INTEGER,                     -- For alert functionality
);

CREATE INDEX idx_ip_address ON threat_data(ip_address);

CREATE INDEX idx_risk_score ON threat_data(risk_score);
