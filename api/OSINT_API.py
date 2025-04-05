# backend/database_setup.py
import psycopg2

def create_tables():
    conn = psycopg2.connect("dbname=threat_intel user=admin password=securepass")
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS threat_data (
            id SERIAL PRIMARY KEY,
            ip_address TEXT NOT NULL,
            ports TEXT,
            services TEXT,
            threat_type TEXT,
            risk_score INTEGER,
            timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    conn.commit()
    cursor.close()
    conn.close()

def insert_threat_data(ip, ports, services, threat_type, risk_score):
    conn = psycopg2.connect("dbname=threat_intel user=admin password=securepass")
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO threat_data (ip_address, ports, services, threat_type, risk_score)
        VALUES (%s, %s, %s, %s, %s)
    """, (ip, ports, services, threat_type, risk_score))
    conn.commit()
    cursor.close()
    conn.close()

if __name__ == "__main__":
    create_tables()
