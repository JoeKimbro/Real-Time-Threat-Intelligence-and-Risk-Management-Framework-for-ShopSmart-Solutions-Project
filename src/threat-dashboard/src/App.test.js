import './App.css';
import ThreatList from './ThreatList';
import React, { useState } from 'react';

// Sample data to use as fallback if API is unavailable
const sampleThreatsData = [
  { 
    id: 1, 
    source: 'shodan', 
    identifier: '8.8.8.8', 
    name: 'Google DNS', 
    vulnerability: 'Open DNS Server', 
    risk_score: 3.5, 
    last_seen: '2025-03-01', 
    open_ports: '53, 443' 
  },
  { 
    id: 2, 
    source: 'securitytrails', 
    identifier: 'example.com', 
    name: 'Example Domain', 
    vulnerability: 'Misconfigured DNS', 
    risk_score: 6.8, 
    last_seen: '2025-03-15', 
    open_ports: 'N/A' 
  },
  { 
    id: 3, 
    source: 'intelowl', 
    identifier: 'e1112134b6dcc8bed54e0e34d8ac272795e73d74', 
    name: 'Malware Hash', 
    vulnerability: 'Trojan Backdoor', 
    risk_score: 8.2, 
    last_seen: '2025-03-10', 
    open_ports: 'N/A' 
  },
];

function App() {
  const [useSampleData, setUseSampleData] = useState(false);

  return (
    <div className="App">
      <header className="App-header" style={{ minHeight: '10vh', padding: '20px' }}>
        <h1>Threat Intelligence Dashboard</h1>
      </header>
      
      <div className="container">
        {useSampleData ? (
          <>
            <div className="alert" style={{ backgroundColor: '#f8d7da', padding: '10px', margin: '10px 0' }}>
              Using sample data because API connection failed
              <button 
                onClick={() => setUseSampleData(false)} 
                style={{ marginLeft: '10px', padding: '5px 10px' }}
              >
                Try API again
              </button>
            </div>
            <ThreatList initialThreats={sampleThreatsData} />
          </>
        ) : (
          <ThreatList 
            initialThreats={[]} 
            onError={() => setUseSampleData(true)} 
          />
        )}
      </div>
    </div>
  );
}

export default App;