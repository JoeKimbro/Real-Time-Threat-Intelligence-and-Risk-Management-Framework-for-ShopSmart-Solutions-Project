import React, { useEffect, useState } from "react";

const App = () => {
  const [threats, setThreats] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch("http://localhost:5000/api/threats")
      .then((response) => response.json())
      .then((data) => {
        console.log(data); // Check if the correct data is coming through
        setThreats(data);
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
        setError("Error fetching data.");
      });
  }, []);

  return (
    <div>
      <h1>Real-Time Threat Intelligence</h1>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>IP Address</th>
            <th>Ports</th>
            <th>Services</th>
            <th>Threat Type</th>
            <th>Risk Score</th>
            <th>Timestamp</th>
          </tr>
        </thead>
        <tbody>
          {threats.length === 0 ? (
            <tr>
              <td colSpan="7">No threats data available.</td>
            </tr>
          ) : (
            threats.map((threat) => (
              <tr key={threat.id}>
                <td>{threat.id}</td>
                <td>{threat.ip_address}</td>
                <td>{JSON.stringify(threat.ports)}</td>
                <td>{JSON.stringify(threat.services)}</td>
                <td>{threat.threat_type}</td>
                <td>{threat.risk_score}</td>
                <td>{threat.timestamp}</td>
              </tr>
            ))
          )}
        </tbody>
      </table>
      {error && <div>{error}</div>}
    </div>
  );
};

export default App;

