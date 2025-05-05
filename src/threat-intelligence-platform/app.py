from flask import Flask, jsonify
from flask_cors import CORS
import psycopg2
import os

from pdf import generate_report  # Secure OpenAI handler

app = Flask(__name__)
CORS(app)

# PostgreSQL connection parameters
db_params = {
    "dbname": "treats",
    "user": "project_user",
    "password": "QhBzwcVWbMaB9wXgEfvPj6NzZlQQzPcS",
    "host": "dpg-cvm1k5h5pdvs739f5540-a.oregon-postgres.render.com",
    "port": 5432
}

# --- Register OpenAI PDF route ---
app.add_url_rule("/api/generate-report", view_func=generate_report, methods=["POST"])

# --- Threats endpoint ---
@app.route("/api/threats", methods=["GET"])
def get_threats():
    try:
        conn = psycopg2.connect(**db_params)
        cursor = conn.cursor()
        cursor.execute("SELECT ip_address, ports FROM threat_data")
        rows = cursor.fetchall()
        cursor.close()
        conn.close()

        threats = [
            {
                "ip": ip,
                "type": f"Open Ports: {ports}",
                "risk_score": len(str(ports)) * 2  # Dummy logic
            }
            for ip, ports in rows
        ]

        return jsonify(threats)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# --- Vulnerabilities endpoint ---
@app.route("/api/vulnerabilities", methods=["GET"])
def get_vulnerabilities():
    try:
        conn = psycopg2.connect(**db_params)
        cursor = conn.cursor()
        cursor.execute("""
            SELECT 
                a.asset_name,
                m.vulnerability_description,
                m.threat_name,
                m.likelihood,
                m.impact,
                m.risk_score
            FROM tva_mapping m
            JOIN assets a ON m.asset_id = a.id
        """)
        rows = cursor.fetchall()
        cursor.close()
        conn.close()

        results = [
            {
                "asset": row[0],
                "vulnerability": row[1],
                "threat": row[2],
                "likelihood": row[3],
                "impact": row[4],
                "risk_score": row[5],
            }
            for row in rows
        ]

        return jsonify(results)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True)
