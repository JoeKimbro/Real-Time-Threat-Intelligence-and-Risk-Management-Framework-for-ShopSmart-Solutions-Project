CREATE TABLE ASSETS (
    ASSET_ID SERIAL PRIMARY KEY,
    ASSET_NAME VARCHAR(255) NOT NULL,
    ASSET_TYPE VARCHAR(50) CHECK (asset_type IN ('Hardware', 'Software', 'Data', 'People', 'Process')),
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
  VULNERABILITY_TYPE REFERENCES ASSERT(ASSET_TYPE) VARCHAR(50) NOT NULL
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

INSERT INTO ASSETS (ASSET_NAME, ASSET_TYPE, DESCRIPTION) VALUES
('Main Database Server', 'Hardware', 'Primary database server storing critical business data'),
('Employee Workstations', 'Hardware', 'Workstations used by employees for daily operations'),
('Company Network Switch', 'Hardware', 'Manages network traffic between internal systems'),
('E-commerce Website', 'Software', 'Web application for customer transactions'),
('Content Management System (CMS)', 'Software', 'Manages website content and product listings'),
('API Gateway', 'Software', 'Handles API requests between services and applications'),
('Customer Records', 'Data', 'Includes customer personal information and order history'),
('Transaction Logs', 'Data', 'Stores records of all payment and order transactions'),
('User Credentials', 'Data', 'Encrypted usernames and passwords for authentication'),
('IT Security Team', 'People', 'Manages cybersecurity and system integrity'),
('Customers', 'People', 'End users who purchase products from the e-commerce platform'),
('Payment Processing', 'Process', 'Handles online transactions and payment verifications'),
('Account Authentication', 'Process', 'Verifies user identities during login'),
('Daily Backups', 'Process', 'Routine data backup process to prevent data loss');

INSERT INTO RISK (RISK_LEVEL, LIKELIHOOD, IMPACT) VALUES
-- Main Database Server: Threats like Unauthorized Access, Data Breach
(5, 0.8, 0.9),  -- Unauthorized Access (High likelihood & impact)
(7, 0.7, 0.8),  -- Data Breach (Medium likelihood & high impact)
-- Employee Workstations: Threats like DoS Attack, Malware Infection
(6, 0.7, 0.7),  -- DoS Attack (Medium likelihood & moderate impact)
(6, 0.6, 0.8),  -- Malware Infection (Moderate likelihood & high impact)
-- Company Network Switch: Threats like Malware Infection, Network Intrusion
(6, 0.5, 0.7),  -- Malware Infection (Low likelihood & moderate impact)
(5, 0.6, 0.6),  -- Network Intrusion (Moderate likelihood & moderate impact)
-- E-commerce Website: Threats like SQL Injection, XSS
(8, 0.8, 0.9),  -- SQL Injection (High likelihood & high impact)
(7, 0.7, 0.8),  -- Cross-Site Scripting (Moderate likelihood & high impact)
-- Content Management System (CMS): Threats like XSS, SQL Injection
(7, 0.7, 0.8),  -- Cross-Site Scripting (Moderate likelihood & high impact)
(8, 0.8, 0.9),  -- SQL Injection (High likelihood & high impact)
-- API Gateway: Threats like API Abuse, Denial of Service (DoS)
(6, 0.6, 0.7),  -- API Abuse (Moderate likelihood & moderate impact)
(6, 0.5, 0.6),  -- DoS Attack (Low likelihood & moderate impact)
-- Customer Records: Threats like Data Breach, Credential Theft
(9, 0.9, 1.0),  -- Data Breach (High likelihood & high impact)
(8, 0.8, 0.9),  -- Credential Theft (High likelihood & high impact)
-- Transaction Logs: Threats like Log Manipulation
(6, 0.6, 0.7),  -- Log Manipulation (Moderate likelihood & moderate impact)
-- User Credentials: Threats like Credential Theft, Phishing Attack
(7, 0.8, 0.8),  -- Credential Theft (High likelihood & high impact)
(7, 0.7, 0.7),  -- Phishing Attack (Moderate likelihood & moderate impact)
-- IT Security Team: Threats like Social Engineering
(6, 0.6, 0.7),  -- Social Engineering (Moderate likelihood & moderate impact)
-- Customers: Threats like Phishing Attack
(7, 0.8, 0.7),  -- Phishing Attack (High likelihood & moderate impact)
-- Payment Processing: Threats like Payment Fraud
(9, 0.9, 1.0),  -- Payment Fraud (High likelihood & high impact)
-- Account Authentication: Threats like Authentication Bypass
(9, 0.9, 1.0),  -- Authentication Bypass (High likelihood & high impact)
-- Daily Backups: Threats like Backup Tampering
(7, 0.7, 0.8);  -- Backup Tampering (Moderate likelihood & high impact)


INSERT INTO threats (asset_id, threat_name, threat_category, description, risk_rating) VALUES
-- Threats targeting Hardware
(1, 'Unauthorized Access', 'Hardware', 'Hackers attempting to gain unauthorized control over the database server', 5),
(2, 'Denial of Service (DoS) Attack', 'Hardware', 'Overloading employee workstations with excessive traffic causing service disruptions', 4),
(3, 'Malware Infection', 'Hardware', 'Company network switch compromised by malicious software', 4),
-- Threats targeting Software
(4, 'SQL Injection Attack', 'Software', 'Exploiting vulnerabilities in the e-commerce website to execute unauthorized database queries', 5),
(5, 'Cross-Site Scripting (XSS)', 'Software', 'Injecting malicious scripts into the CMS to steal user data', 4),
(6, 'API Abuse', 'Software', 'Excessive API calls causing service degradation and data leakage', 3),
-- Threats targeting Data
(7, 'Data Breach', 'Data', 'Unauthorized access to customer records leading to data exposure', 5),
(8, 'Log Manipulation', 'Data', 'Tampering with transaction logs to cover fraudulent activities', 3),
(9, 'Credential Theft', 'Data', 'Stealing encrypted user credentials through brute-force or phishing attacks', 4),
-- Threats targeting People
(10, 'Social Engineering', 'People', 'Manipulating IT staff into divulging sensitive information', 4),
(11, 'Phishing Attack', 'People', 'Customers tricked into providing login credentials via fraudulent emails', 4),
-- Threats targeting Processes
(12, 'Payment Fraud', 'Process', 'Exploiting weaknesses in payment processing systems to carry out fraudulent transactions', 5),
(13, 'Authentication Bypass', 'Process', 'Exploiting flaws in account authentication mechanisms to gain unauthorized access', 5),
(14, 'Backup Tampering', 'Process', 'Interfering with daily backups to prevent data recovery after an attack', 4);

INSERT INTO vulnerabilities (asset_id, threat_id, vulnerability_name, VULNERABILITY_TYPE, description, risk_rating) VALUES
-- Vulnerabilities in Hardware
(1, 1, 'Weak or Default Credentials', 'Hardware', 'Default database credentials make it easier for attackers to gain unauthorized access', 5),
(2, 2, 'Unrestricted Network Traffic', 'Hardware', 'Employee workstations lack network segmentation, making DoS attacks more effective', 4),
(3, 3, 'Unpatched Software', 'Hardware', 'Outdated firmware on networking devices makes them susceptible to malware', 4),
-- Vulnerabilities in Software
(4, 4, 'Unvalidated User Input', 'Software', 'SQL injection vulnerability due to poor input validation on e-commerce website forms', 5),
(5, 5, 'Unescaped User Input', 'Software', 'Lack of input sanitization allows XSS attacks in the CMS', 4),
(6, 6, 'Exposed API Endpoints', 'Software', 'API gateway allows unauthenticated users to query sensitive data', 3),
-- Vulnerabilities in Data
(7, 7, 'Unencrypted Sensitive Data', 'Data', 'Customer records stored in plaintext, increasing exposure risk in case of a breach', 5),
(8, 8, 'Lack of Audit Logging', 'Data', 'Transaction logs can be modified without detection', 3),
(9, 9, 'Weak Password Storage', 'Data', 'User credentials stored with weak hashing algorithms', 4),
-- Vulnerabilities in People
(10, 10, 'Lack of Security Awareness Training', 'People', 'Employees are not trained to recognize social engineering attacks', 4),
(11, 11, 'Email Spoofing Vulnerability', 'People', 'No DMARC policy, allowing phishing emails to appear legitimate', 4),
-- Vulnerabilities in Processes
(12, 12, 'Weak Fraud Detection Systems', 'Process', 'Inadequate fraud prevention tools in payment processing', 5),
(13, 13, 'Broken Authentication Logic', 'Process', 'Incorrect session handling allows authentication bypass', 5),
(14, 14, 'Lack of Backup Integrity Checks', 'Process', 'No verification of backup integrity, increasing risk of tampered backups', 4);


INSERT INTO tva_mapping (asset_id, threat_id, vulnerability_id, likelihood, impact, RISK_RATING_ID) VALUES
-- Threats targeting Hardware
(1, 1, 1, 4, 5, 1),  -- Unauthorized Access mapped with Weak or Default Credentials (Main Database Server)
(2, 3, 2, 4, 4, 2),  -- Denial of Service (DoS) Attack mapped with Unrestricted Network Traffic (Employee Workstations)
(3, 4, 3, 5, 5, 3),  -- Malware Infection mapped with Unpatched Software (Company Network Switch)
-- Threats targeting Software
(4, 4, 4, 4, 5, 4),   -- SQL Injection Attack mapped with Unvalidated User Input (E-commerce Website)
(5, 5, 5, 4, 5, 5),  -- Cross-Site Scripting (XSS) mapped with Unescaped User Input (Content Management System)
(6, 6, 6, 3, 4, 6),  -- API Abuse mapped with Exposed API Endpoints (API Gateway)
-- Threats targeting Data
(7, 7, 7, 3, 5, 7),  -- Data Breach mapped with Unencrypted Sensitive Data (Customer Records)
(8, 8, 8, 3, 3, 8),  -- Log Manipulation mapped with Lack of Audit Logging (Transaction Logs)
(9, 9, 9, 4, 4, 9),  -- Credential Theft mapped with Weak Password Storage (User Credentials)
-- Threats targeting People
(10, 10, 10, 4, 4, 10),  -- Social Engineering mapped with Lack of Security Awareness Training (IT Security Team)
(11, 11, 11, 4, 4, 11),  -- Phishing Attack mapped with Email Spoofing Vulnerability (Customers)
-- Threats targeting Processes
(12, 12, 12, 5, 5, 12),  -- Payment Fraud mapped with Weak Fraud Detection Systems (Payment Processing)
(13, 13, 13, 5, 5, 13),  -- Authentication Bypass mapped with Broken Authentication Logic (Account Authentication)
(14, 14, 14, 4, 4, 14);  -- Backup Tampering mapped with Lack of Backup Integrity Checks (Daily Backups)


SELECT * FROM tva_mapping;
