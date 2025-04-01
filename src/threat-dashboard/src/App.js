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
  );
}

export default App;
