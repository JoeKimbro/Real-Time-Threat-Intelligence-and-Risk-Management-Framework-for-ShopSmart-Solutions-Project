def prioritize_risks(threats):
    return sorted(threats, key=lambda x: x["risk_score"], reverse=True)

# Example usage
threats = [
    {"name": "Phishing", "risk_score": 30},
    {"name": "SQL Injection", "risk_score": 20},
    {"name": "DDoS", "risk_score": 25}
]

top_threats = prioritize_risks(threats)
print(top_threats)