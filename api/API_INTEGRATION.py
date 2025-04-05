from flask import Flask, jsonify
import psycopg2
import requests
from flask_cors import CORS  # Import CORS

# Initialize the Flask app
app = Flask(__name__)

# Enable CORS for all routes
CORS(app)  # This will allow requests from any domain (e.g., localhost:3000)

API_KEY = "your_shodan_api_key"
IP = "8.8.8.8"
URL = f"https://api.shodan.io/shodan/host/{IP}?key={API_KEY}"

def get_db_connection():
    return psycopg2.connect("dbname=threat_intel user=admin password=securepass host=localhost")

def fetch_and_store_osint_data():
    response = requests.get(URL).json()
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        """
        INSERT INTO threat_data (ip_address, ports, services)
        VALUES (%s, %s, %s)
        """,
        (IP, str(response.get('ports')), str(response.get('hostnames')))
    )
    conn.commit()
    cursor.close()
    conn.close()

@app.route('/api/threats', methods=['GET'])
def get_threats():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, ip_address, ports, services, threat_type, risk_score, timestamp FROM threat_data ORDER BY timestamp DESC")
    threats = cursor.fetchall()
    cursor.close()
    conn.close()

    return jsonify([{
        "id": t[0],
        "ip_address": t[1],
        "ports": t[2],
        "services": t[3],
        "threat_type": t[4],
        "risk_score": t[5],
        "timestamp": t[6].strftime('%Y-%m-%d %H:%M:%S')  # Format timestamp for better display
    } for t in threats])


if __name__ == '__main__':
    fetch_and_store_osint_data()  # Optional: This inserts data when the server starts
    app.run(debug=True)
