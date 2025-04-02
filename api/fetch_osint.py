import os
import psycopg2
import requests
from dotenv import load_dotenv
from src.alerts import send_alert

load_dotenv()

def fetch_shodan_data(ip):
    API_KEY = os.getenv("SHODAN_API_KEY")
    URL = f"https://api.shodan.io/shodan/host/{ip}?key={API_KEY}"
    response = requests.get(URL).json()
    return response

def store_threat_data(ip):
    data = fetch_shodan_data(ip)
    conn = psycopg2.connect(
        dbname="treats",
        user="project_user",
        password="QhBzwcVWbMaB9wXgEfvPj6NzZlQQzPcS",
        host="dpg-cvm1k5h5pdvs739f5540-a.oregon-postgres.render.com",
        port=5432
    )
    cursor = conn.cursor()
    risk_score = 18  # You can dynamically calculate risk score if needed

    cursor.execute(
        "INSERT INTO threat_data (ip_address, ports, services) VALUES (%s, %s, %s)",
        (ip, str(data.get('ports')), str(data.get('hostnames')))
    )
    conn.commit()

    # ✅ If risk_score > 20, send alert
    if risk_score > 20:
        send_alert(f"Open Ports: {data.get('ports')}", risk_score)

    cursor.close()
    conn.close()

# # Render PostgreSQL connection details
# db_params = {
#     "dbname": "treats",
#     "user": "project_user",
#     "password": "QhBzwcVWbMaB9wXgEfvPj6NzZlQQzPcS",  # <-- replace with your real password or load from .env
#     "host": "dpg-cvm1k5h5pdvs739f5540-a.oregon-postgres.render.com",
#     "port": 5432
# }
