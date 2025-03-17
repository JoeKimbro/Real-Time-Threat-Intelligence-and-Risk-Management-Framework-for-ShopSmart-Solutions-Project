CREATE TABLE ASSETS (
  ASSET_ID SERIAL PRIMARY KEY,              
  ASSET_NAME VARCHAR(255) NOT NULL,          
  ASSET_TYPE VARCHAR(100) NOT NULL,         
  CATEGORY VARCHAR(50),                     
  DESCRIPTION TEXT                           
);

CREATE TABLE RISK (
  RISK_RATING_ID SERIAL PRIMARY KEY,         
  RISK_LEVEL INT CHECK (RISK_LEVEL BETWEEN 1 AND 10), 
  LIKELIHOOD DECIMAL(3,1) NOT NULL,          
  IMPACT DECIMAL(3,1) NOT NULL,             
  RISK_SCORE DECIMAL(5,2) GENERATED ALWAYS AS (LIKELIHOOD * IMPACT) STORED
);

CREATE TABLE THREATS (
  THREATS_ID SERIAL PRIMARY KEY,
  ASSET_ID INT REFERENCES ASSETS(ASSET_ID) ON DELETE CASCADE,  
  RISK_RATING_ID INT REFERENCES RISK(RISK_RATING_ID) ON DELETE SET NULL,
  THREAT_NAME VARCHAR(255) NOT NULL,         
  THREAT_TYPE VARCHAR(100) NOT NULL
);

CREATE TABLE VULNERABILITIES (
  VULNERABILITY_ID SERIAL PRIMARY KEY,       
  ASSET_ID INT REFERENCES ASSETS(ASSET_ID) ON DELETE CASCADE,  
  RISK_RATING_ID INT REFERENCES RISK(RISK_RATING_ID) ON DELETE SET NULL, 
  VULNERABILITY_NAME VARCHAR(255) NOT NULL,   
  VULNERABILITY_TYPE VARCHAR(100) NOT NULL
);

CREATE TABLE tva_mapping (
  id SERIAL PRIMARY KEY,
  asset_id INT REFERENCES ASSETS(ASSET_ID) ON DELETE CASCADE,
  threat_id INT REFERENCES THREATS(THREATS_ID) ON DELETE CASCADE,
  vulnerability_id INT REFERENCES VULNERABILITIES(VULNERABILITY_ID) ON DELETE CASCADE,
  risk_rating_id INT REFERENCES RISK(RISK_RATING_ID) ON DELETE SET NULL, 
  likelihood INT,
  impact INT,
  risk_score INT GENERATED ALWAYS AS (likelihood * impact) STORED
);

INSERT INTO assets (asset_name, asset_type, category, description) VALUES
('Corporate Database', 'Database', 'Data Storage', 'Stores sensitive business and customer information'),
('Web Server', 'Server', 'Infrastructure', 'Hosts the company’s website and services'),
('Enterprise Workstations', 'Computer', 'Endpoint Devices', 'Workstations used by employees'),
('Network Firewall', 'Security Device', 'Network Security', 'Monitors and controls incoming and outgoing network traffic'),
('ShopSmart Web Server', 'Web Application', 'IT Infrastructure', 'Primary e-commerce server');

INSERT INTO risk (RISK_LEVEL, LIKELIHOOD, IMPACT) VALUES 
(5, 0.8, 0.9),  -- For Unauthorized Access, example risk level 5
(7, 0.7, 0.8),  -- For Data Breach
(6, 0.6, 0.7),  -- For DoS Attack
(9, 0.9, 1.0),  -- For Malware Infection
(8, 0.8, 0.9);  -- For SQL Injection Attack

INSERT INTO threats (asset_id, risk_rating_id, threat_name, threat_type) VALUES
(1, 1, 'Unauthorized Access', 'Cyber Intrusion'),
(1, 2, 'Data Breach', 'Data Exposure'),
(2, 3, 'Denial of Service (DoS) Attack', 'Service Disruption'),
(3, 4, 'Malware Infection', 'Malicious Software'),
(5, 5, 'SQL Injection Attack', 'Web Application Exploit');

INSERT INTO vulnerabilities (asset_id, risk_rating_id, vulnerability_name, vulnerability_type) VALUES
(1, 1, 'Weak or Default Credentials', 'Authentication Weakness'),
(1, 2, 'Unencrypted Sensitive Data', 'Data Protection Failure'),
(2, 3, 'Unrestricted Network Traffic', 'Lack of Traffic Control'),
(3, 4, 'Unpatched Software', 'Outdated Security Updates'),
(5, 5, 'Unpatched Apache Server', 'Software Vulnerability');

INSERT INTO tva_mapping (asset_id, threat_id, vulnerability_id, risk_rating_id, likelihood, impact) VALUES
(1, 1, 1, 1, 4, 5), -- Unauthorized Access mapped with Weak Credentials
(1, 2, 2, 2, 3, 5), -- Data Breach mapped with Unencrypted Sensitive Data
(2, 3, 3, 3, 4, 4), -- DoS Attack mapped with Unrestricted Network Traffic
(3, 4, 4, 4, 5, 5), -- Malware Infection mapped with Unpatched Software
(5, 5, 5, 5, 4, 5); -- SQL Injection mapped with Unpatched Apache Server

SELECT * FROM tva_mapping;
