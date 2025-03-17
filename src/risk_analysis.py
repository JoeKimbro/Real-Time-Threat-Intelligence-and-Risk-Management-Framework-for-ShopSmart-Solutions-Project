def calculate_risk(likelihood, impact):
    return likelihood * impact



# Example Threat Rating
threats = [
    {"threat": "SQL Injection", "likelihood": 4, "impact": 5},
    {"threat": "Phishing Attack", "likelihood": 5, "impact": 3},
    {"threat": "Malware Infection", "likelihood": 4, "impact": 4},
    {"threat": "Ransomware Attack", "likelihood": 3, "impact": 5},
    {"threat": "Distributed Denial of Service (DDoS)", "likelihood": 4, "impact": 4},
    {"threat": "Zero-day Exploit", "likelihood": 2, "impact": 5},
    {"threat": "Man-in-the-Middle Attack", "likelihood": 3, "impact": 4},
    {"threat": "Cross-Site Scripting (XSS)", "likelihood": 4, "impact": 3},
]



for threat in threats:
    risk_score = calculate_risk(threat["likelihood"],
    threat["impact"])
    print(f"Threat: {threat['threat']}, Risk Score: {risk_score}")