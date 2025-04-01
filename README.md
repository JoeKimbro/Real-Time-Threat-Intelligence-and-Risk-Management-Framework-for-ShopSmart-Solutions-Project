# 🛡️ ShopSmart Threat Intelligence & Risk Management Framework

## Project Overview
This project is a Real-Time Threat Intelligence and Risk Management system designed for ShopSmart Solutions. It fetches live threat data from OSINT APIs, stores and analyzes the data, and provides dynamic risk scores, mitigation strategies, and incident response plans. A React Dashboard is used to visualize threats in real-time.

---

## ✅ Completed Tasks

### Week 4 Deliverables

**1. OSINT API Integration**
- Integrated Shodan API to fetch threat intelligence data (open ports & services).
- Stored the threat data into PostgreSQL database (`threat_data` table).
- Backend integration implemented in `/api/fetch_osint.py`.

**2. Threat Data Automation**
- Created an automated scheduler to fetch OSINT data every 6 hours.
- Implemented using `schedule` library in `/api/scheduler.py`.

**3. Real-Time Threat Intelligence Dashboard**
- Built a React dashboard to display live threat data from the backend API.
- Dashboard implemented in `/src/components/ThreatDashboard.js`.

**4. Alert System**
- Developed an alert system that sends email notifications if a threat's risk score exceeds 20.
- Implemented in `/src/alerts.py`.

**5. API Testing**
- Wrote test cases using Pytest to validate OSINT API and Flask API.
- Test files located in `/tests/api_tests.py`.

---

### Week 5 Deliverables

**1. Machine Learning Risk Scoring**
- Integrated a HuggingFace model (`distilbert-base-uncased`) for risk analysis to simulate LLM integration.
- Implemented in `/src/risk_analysis.py`.

**2. Threat-Vulnerability-Asset (TVA) Mapping**
- Refined TVA mapping in the database based on live threat data.
- SQL update script executed to adjust likelihood score.

**3. Risk Prioritization Model**
- Developed a Python script to prioritize threats based on risk score.
- Implemented in `/src/risk_prioritization.py`.

**4. Automated Risk Mitigation Recommendations**
- Created a Python module that recommends mitigation strategies based on detected threat type.
- Implemented in `/src/mitigation_recommendations.py`.

**5. Incident Response Plan**
- Developed a module to generate a response plan for each detected threat.
- Implemented in `/src/incident_response.py`.

---

## 🚀 How It Works

1. **OSINT Threat Data Collection**
   - `fetch_osint.py` fetches threat data from Shodan API.
   - Data is stored in PostgreSQL database.

2. **Automated Scheduler**
   - `scheduler.py` fetches new data every 6 hours.

3. **Alert System**
   - Sends email alerts for high-risk threats.

4. **Risk Scoring & Prioritization**
   - Uses a lightweight LLM (HuggingFace pipeline) to analyze risk.
   - Sorts and prioritizes risks dynamically.

5. **Mitigation Recommendations**
   - Provides recommended action steps for each threat.

6. **Incident Response**
   - Generates incident response plans linked to detected threats.

7. **Dashboard**
   - Displays real-time threats and risk scores in a React app (`ThreatDashboard.js`).

---

## 📂 Project Structure

```text
├── api
│   ├── __pycache__                  # Python cache
│   ├── fetch_osint.py               # Shodan API Integration & OSINT data fetch
│   ├── osint.py                     # Additional OSINT API integrations
│   └── scheduler.py                 # Automated script for real-time data fetching
├── db
│   └── (Database files)             # Database scripts & schema
├── docs
│   ├── nist_framework_summary.md    # NIST framework summary
│   ├── osint_research.md            # Research on OSINT sources
│   ├── team_structure.md            # Team roles and structure
│   └── tech_stack.md                # Tech stack used in the project
├── src
│   ├── threat-dashboard             # (Empty folder - Can be deleted if unused)
│   ├── threat-intelligence-platform
│   │   ├── app.py                   # Flask app entry point
│   │   └── components               # React components folder
├── src
│   ├── alerts.py                    # Email alert system
│   ├── incident_response.py         # Incident Response Plan generator
│   ├── mitigation_recommendations.py# Automated risk mitigation recommendations
│   ├── risk_analysis.py             # Risk scoring using ML (T5 model integration)
│   └── risk_prioritization.py       # Dynamic risk prioritization model
├── tests
│   └── api_tests.py                 # Unit tests for API endpoints
├── .gitignore                       # Git ignored files
├── database.txt                     # Notes on database setup
├── README.md                        # Project documentation
└── requirements.txt                 # Python dependencies
```