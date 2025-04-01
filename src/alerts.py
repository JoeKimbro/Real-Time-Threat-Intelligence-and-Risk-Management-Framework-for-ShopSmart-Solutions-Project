import smtplib
from email.mime.text import MIMEText

def send_alert(threat, risk_score):
    msg = MIMEText(f"High-Risk Threat Detected: {threat} with Risk Score {risk_score}")
    msg["Subject"] = "Critical Cybersecurity Alert"
    msg["From"] = "alerts@shopsmart.com"
    msg["To"] = "admin@shopsmart.com"

    with smtplib.SMTP("smtp.your-email.com", 587) as server:
        server.starttls()
        server.login("your-email", "password")
        server.sendmail("alerts@shopsmart.com", "admin@shopsmart.com", msg.as_string())

