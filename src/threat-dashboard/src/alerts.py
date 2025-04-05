import smtplib
import requests
from email.mime.text import MIMEText

WEBHOOK_URL = "https://your-webhook-url.com"

def send_email_alert(threat, risk_score):
    msg = MIMEText(f"High-Risk Threat Detected: {threat} with Risk
        Score {risk_score}")
    msg["Subject"] = "Critical Cybersecurity Alert"
    msg["From"] = "alerts@shopsmart.com"
    msg["To"] = "admin@shopsmart.com"

    with smtplib.SMTP("smtp.your-email.com", 587) as server:
        server.starttls()
        server.login("your-email", "password")
        server.sendmail("alerts@shopsmart.com", "admin@shopsmart.com", msg.as_string())

def send_webhook_alert(threat, risk_score):
    payload = {"threat": threat, "risk_score": risk_score}
    requests.post(WEBHOOK_URL, json=payload)

# Example Usage
send_email_alert("SQL Injection", 25)
send_webhook_alert("SQL Injection", 25)