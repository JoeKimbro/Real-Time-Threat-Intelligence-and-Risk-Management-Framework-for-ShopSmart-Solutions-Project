function ThreatList({ threats }) {
    return (
        <div>
            <h2>Threat Intelligence Overview</h2>
                <table>
                    <thead>
                        <tr>
                        <th>Threat</th>
                        <th>Vulnerability</th>
                        <th>Risk Score</th>
                        </tr>
                    </thead>
                    <tbody>
                        {threats.map((threat, index) => (
                        <tr key={index}>
                        <td>{threat.name}</td>
                        <td>{threat.vulnerability}</td>
                        <td>{threat.risk_score}</td>
                        </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        );
    }

    export default ThreatList