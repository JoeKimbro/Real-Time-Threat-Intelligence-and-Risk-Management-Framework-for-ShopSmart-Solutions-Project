import React, { useState, useEffect } from "react";

function ThreatDashboard() {
  const [threats, setThreats] = useState([]);

  useEffect(() => {
    fetch("http://127.0.0.1:5000/api/threats")
      .then((res) => res.json())
      .then((data) => setThreats(data))
      .catch((err) => console.error("Failed to fetch threats:", err));
  }, []);

  return (
    <div>
      <h2>Real-Time Threat Intelligence</h2>
      <table>
        <thead>
          <tr>
            <th>IP Address</th>
            <th>Threat Type</th>
            <th>Risk Score</th>
          </tr>
        </thead>
        <tbody>
          {threats.map((threat, index) => (
            <tr key={index}>
              <td>{threat.ip}</td>
              <td>{threat.type}</td>
              <td>{threat.risk_score}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default ThreatDashboard;

