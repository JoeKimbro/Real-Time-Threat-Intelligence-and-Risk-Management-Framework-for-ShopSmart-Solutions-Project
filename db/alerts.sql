-- Create the alert_logs table to track security alerts
CREATE TABLE alert_logs (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    alert_type VARCHAR(50) NOT NULL,              -- 'email' or 'webhook'
    threat_details TEXT NOT NULL,                 -- Description of the threat
    risk_score INTEGER NOT NULL,                  -- The risk score that triggered the alert
    recipient VARCHAR(255) NOT NULL,              -- Email recipient or webhook URL
    status VARCHAR(50) DEFAULT 'sent',            -- Status of the alert delivery
    error_message TEXT                            -- Any error details if the alert failed
);

-- Create indexes for efficient querying
CREATE INDEX idx_alert_logs_timestamp ON alert_logs(timestamp);
CREATE INDEX idx_alert_logs_risk_score ON alert_logs(risk_score);
