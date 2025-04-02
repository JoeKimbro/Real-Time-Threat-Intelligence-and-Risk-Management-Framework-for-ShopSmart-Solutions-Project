
import React from "react";
import "./App.css";
import ThreatDashboard from "./components/ThreatDashboard";

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>ShopSmart Threat Intelligence Dashboard</h1>
      </header>
      <ThreatDashboard />
    </div>
=======

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
