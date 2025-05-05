from flask import request, jsonify
from openai import OpenAI
import os
from dotenv import load_dotenv


load_dotenv()  # ✅ Load .env values into os.environ

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))  # ✅ Load API key securely

def generate_report():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing JSON body"}), 400

    prompt = f"""
    Provide mitigation strategies for the following cybersecurity issue:

    Asset: {data.get('asset')}
    Vulnerability: {data.get('vulnerability')}
    Threat: {data.get('threat')}
    Likelihood: {data.get('likelihood')}
    Impact: {data.get('impact')}
    Risk Score: {data.get('risk_score')}

    Output in a structured, readable format.
    """

    try:
        response = client.chat.completions.create(
            model="gpt-4",
            messages=[{"role": "user", "content": prompt}]
        )
        content = response.choices[0].message.content
        return jsonify({"content": content})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

