from flask import Flask, jsonify
import psycopg2
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # So React can access this API

# PostgreSQL connection details
db_params = {
    "dbname": "treats",
    "user": "project_user",
    "password": "QhBzwcVWbMaB9wXgEfvPj6NzZlQQzPcS",
    "host": "dpg-cvm1k5h5pdvs739f5540-a.oregon-postgres.render.com",
    "port": 5432
}

@app.route("/api/threats", methods=["GET"])
def get_threats():
    conn = psycopg2.connect(**db_params)
    cursor = conn.cursor()
    cursor.execute("SELECT ip_address, ports FROM threat_data")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    # Format data for React
    threats = []
    for row in rows:
        ip, ports = row
        threats.append({
            "ip": ip,
            "type": f"Open Ports: {ports}",
            "risk_score": len(str(ports)) * 2  # Dummy Risk Score (you can improve this)
        })

    return jsonify(threats)

@app.route("/api/vulnerabilities", methods=["GET"])
def get_vulnerabilities():
    conn = psycopg2.connect(**db_params)
    cursor = conn.cursor()

    # Join tva_mapping with assets to get the asset name
    query = """
        SELECT 
            a.asset_name,
            m.vulnerability_description,
            m.threat_name,
            m.likelihood,
            m.impact,
            m.risk_score
        FROM tva_mapping m
        JOIN assets a ON m.asset_id = a.id
    """
    cursor.execute(query)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    # Format the data
    results = []
    for row in rows:
        results.append({
            "asset": row[0],
            "vulnerability": row[1],
            "threat": row[2],
            "likelihood": row[3],
            "impact": row[4],
            "risk_score": row[5],
        })

    return jsonify(results)


if __name__ == "__main__":
    app.run(debug=True)
