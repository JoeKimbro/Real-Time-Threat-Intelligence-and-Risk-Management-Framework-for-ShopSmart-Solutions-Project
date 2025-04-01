# tests/api_tests.py

import pytest
import requests

def test_flask_api():
    response = requests.get("http://127.0.0.1:5000/api/threats")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_shodan_api():
    # You can replace this IP if you want
    api_key = "YOUR_SHODAN_API_KEY"
    response = requests.get(f"https://api.shodan.io/shodan/host/8.8.8.8?key={api_key}")
    assert response.status_code == 200
    data = response.json()
    assert "ports" in data

# To run the test:
# In terminal →  pytest tests/api_tests.py

