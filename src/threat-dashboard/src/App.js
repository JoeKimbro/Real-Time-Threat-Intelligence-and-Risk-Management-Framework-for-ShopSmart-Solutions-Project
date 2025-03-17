
import './App.css';
import ThreatList from './ThreatList';

const threatsData = [
  { name: 'Malware', vulnerability: 'Outdated software', risk_score: 8 },
  { name: 'Phishing', vulnerability: 'Human error', risk_score: 7 },
];

function App() {
  return (
    <ThreatList threats={threatsData} />
  );
}

export default App;
