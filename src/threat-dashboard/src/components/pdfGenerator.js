import { jsPDF } from "jspdf";

export async function generatePDFReport(item) {
  try {
    const response = await fetch("http://127.0.0.1:5000/api/generate-report", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(item),
    });

    const data = await response.json();
    if (!data.content) {
      throw new Error(data.error || "No content returned from server");
    }

    const doc = new jsPDF();
    doc.setFontSize(12);
    doc.text(`Mitigation Report for ${item.asset}`, 10, 10);
    const lines = doc.splitTextToSize(data.content, 180);
    doc.text(lines, 10, 20);
    doc.save(`${item.asset}_Mitigation_Report.pdf`);
  } catch (err) {
    console.error("PDF generation failed:", err);
    alert("Error generating PDF. Check console for details.");
  }
}
