def recommend_mitigation(threat):
    recommendations = {
        "SQL Injection": "Use parameterized queries and WAF.",
        "Phishing": "Train employees and enforce MFA.",
        "DDoS": "Implement rate limiting and use DDoS protection."
    }
    return recommendations.get(threat, "No recommendation available.")

# Example usage
mitigation = recommend_mitigation("Phishing")
print(f"Mitigation: {mitigation}")