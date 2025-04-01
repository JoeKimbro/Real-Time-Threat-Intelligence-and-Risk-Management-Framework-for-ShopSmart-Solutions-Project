import schedule
import time
from fetch_osint import store_threat_data

def run_osint_updates():
    store_threat_data("8.8.8.8")

schedule.every(6).hours.do(run_osint_updates)

while True:
    schedule.run_pending()
    time.sleep(1)