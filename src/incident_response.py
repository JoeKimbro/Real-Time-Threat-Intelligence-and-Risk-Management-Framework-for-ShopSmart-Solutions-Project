import sqlite3
import openai
import os

from dotenv import load_dotenv
load_dotenv()

openai.api_key = os.getenv("OPENAI_API_KEY")

# Hard-coded response plan with links to NIST SP 800-61 Rev.2
def incident_response(threat):
    response_plan = {
        "SQL Injection": ("1. Block the attacking IP. "
                          "2. Patch the vulnerability. "
                          "3. Conduct forensic analysis. "
                          "Reference: NIST SP 800-61 Rev.2 "
                          "https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final"),
        "Phishing": ("1. Notify affected users. "
                     "2. Change compromised credentials. "
                     "3. Update phishing filters. "
                     "Reference: NIST SP 800-61 Rev.2 "
                     "https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final"),
        "DDoS Attack": ("1. Activate DDoS mitigation. "
                        "2. Enable rate limiting. "
                        "3. Monitor ongoing traffic. "
                        "Reference: NIST SP 800-61 Rev.2 "
                        "https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final")
    }
    
    # If the threat is known, return the hardcoded plan.
    if threat in response_plan:
        plan = response_plan[threat]
    else:
        # If threat is not in the hardcoded list, use ChatGPT-4 to generate a plan dynamically.
        messages = [
            {"role": "system", "content": "You are a cybersecurity expert providing incident response plans based on NIST SP 800-61 Rev.2."},
            {"role": "user", "content": f"Provide an incident response plan for a threat: '{threat}'. Include countermeasures and reference NIST SP 800-61 Rev.2."}
        ]
        try:
            response = openai.ChatCompletion.create(
                model="gpt-4",
                messages=messages,
                max_tokens=150,
                temperature=0.7,
            )
            plan = response['choices'][0]['message']['content'].strip()
        except Exception as e:
            plan = "No response plan available due to an error: " + str(e)
    
    # Log the incident response in the database.
    log_incident(threat, plan)
    return plan

def log_incident(threat, response_plan):
    # Connect to (or create) the SQLite database to store incident logs.
    conn = sqlite3.connect("alerts.db")
    cursor = conn.cursor()
    
    # Create the incident_logs table if it doesn't exist.
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS incident_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        threat TEXT NOT NULL,
        response_plan TEXT NOT NULL,
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
    )
    """)
    
    # Insert the incident handling log.
    cursor.execute("INSERT INTO incident_logs (threat, response_plan) VALUES (?, ?)", (threat, response_plan))
    conn.commit()
    conn.close()

# Example Usage
if __name__ == "__main__":
    threat_input = "SQL Injection"  # Change the threat here for testing.
    response = incident_response(threat_input)
    print(f"Incident Response Plan for '{threat_input}':\n{response}")
