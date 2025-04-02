from transformers import pipeline

# Load sentiment-analysis pipeline for demonstration
model = pipeline("text-classification")

def analyze_risk(threat, likelihood, impact):
    input_text = f"Risk analysis for {threat} with likelihood {likelihood} and impact {impact}."
    result = model(input_text)
    
    # Simple mapping
    if result[0]['label'] == 'NEGATIVE':
        return "High Risk"
    else:
        return "Low Risk"

print(analyze_risk("Phishing Attack", 5, 4))