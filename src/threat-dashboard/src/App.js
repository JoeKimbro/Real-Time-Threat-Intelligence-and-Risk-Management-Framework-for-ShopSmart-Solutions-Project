import React from "react";
import "./App.css";
import ThreatDashboard from "./components/ThreatDashboard";
import VulnerabilityTable from "./components/VulnerabilityTable";

function App() {
  return (
    <div className="App">
    <header className="bg-gray-900 text-white py-4 text-center">
      <h1 className="text-3xl font-semibold">ShopSmart Threat Intelligence Dashboard</h1>
    </header>
      {/* <ThreatDashboard /> */}
      <VulnerabilityTable />
    </div>
  );
}

export default App;
