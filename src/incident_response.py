from mitigation_recommendations import recommend_mitigation

def generate_response_plan(threat):
    mitigation = recommend_mitigation(threat)
    return f"Incident Response Plan for {threat}:\n- {mitigation}\n- Notify Blue Team\n- Document in Threat Log"

# Example
if __name__ == "__main__":
    print(generate_response_plan("SQL Injection"))