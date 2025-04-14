
import os
import psycopg2
import requests
from dotenv import load_dotenv

load_dotenv()

securitytrails_API_key = os.getenv("securitytrails_api")
print(securitytrails_API_key)

url = "https://api.securitytrails.com/v1/account/usage?apikey="+ securitytrails_API_key

headers = {"accept": "application/json"}

response = requests.get(url, headers=headers)

print(response.text)

#WHOIS data
url = "https://api.securitytrails.com/v1/domain/securitytrails.com/whois?apikey=your_api_key"

headers = {"accept": "application/json"}

response = requests.get(url, headers=headers)

print(response.text)


#Subdomains
url = "https://api.securitytrails.com/v1/domain/oracle.com/subdomains?apikey=your_api_key"

headers = {"accept": "application/json"}

response = requests.get(url, headers=headers)

print(response.text)