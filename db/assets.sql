CREATE TABLE assets (
    id SERIAL PRIMARY KEY,
    asset_name VARCHAR(255) NOT NULL,
    asset_type VARCHAR(50) CHECK (asset_type IN ('Hardware', 'Software', 'Data', 'People', 'Process')),
    description TEXT
);

INSERT INTO assets (asset_name, asset_type, description) VALUES
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
