import os
import requests
import psycopg2
from dotenv import load_dotenv
load_dotenv()


shodan_api_key= os.getenv("shodan_api")

# Query Shodan for information on the IP
IP = "8.8.8.8"
URL = f"https://api.shodan.io/shodan/host/{IP}?key={shodan_api_key}"
response = requests.get(URL).json()

# Convert ports list to a string (if ports exist)
ports = response.get('ports', [])
threat_name = ", ".join(map(str, ports)) if ports else "No ports found"

# Connect to PostgreSQL and store the threat data
try:
    conn = psycopg2.connect("dbname=threat_intel user=admin password=securepass")
    cursor = conn.cursor()
    
    # Insert the data into the tva_mapping table
    cursor.execute(
        """INSERT INTO tva_mapping (asset_id, threat_name, vulnerability_description, likelihood, impact)
        VALUES (%s, %s, %s, %s, %s)""",
        (1, threat_name, "Exposed ports detected", 4, 5)
    )
    
    # Commit the changes
    conn.commit()
    
except Exception as e:
    print("An error occurred:", e)
    
finally:
    # Always close the cursor and connection
    if cursor:
        cursor.close()
    if conn:
        conn.close()
