import requests
import shodan
import os
from dotenv import load_dotenv
load_dotenv() 


shodan_api_key = os.getenv("shodan_api")
securitytrails_api_key = os.getenv("securitytrails_api")
security_trails_url = "https://api.securitytrails.com/v1/ping"

#ANY.RUN has limited documentation that I found currently, I am working on further integration



headers = {"accept": "application/json"}

response = requests.get(security_trails_url, headers=headers)

print(response.text)
'''
shodan_api = shodan.Shodan(shodan_api_key)
host = shodan_api.host("8.8.8.8")

try:
        # Search Shodan
        results = shodan_api.search('apache')

        # Show the results
        print('Results found: {}'.format(results['total']))
        for result in results['matches']:
                print('IP: {}'.format(result['ip_str']))
                print(result['data'])
                print('')
except:
    print("error")

# Print general info
print("""
        IP: {}
        Organization: {}
        Operating System: {}
""".format(host['ip_str'], host.get('org', 'n/a'), host.get('os', 'n/a')))

# Print all banners
for item in host['data']:
        print("""
                Port: {}
                Banner: {}

        """.format(item['port'], item['data']))
'''