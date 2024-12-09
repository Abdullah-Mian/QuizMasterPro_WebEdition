// src/Analytics.jsx
import React, { useContext } from "react";
import { ProgressContext } from "./ProgressContext";
// import { Bar } from "react-chartjs-2";

const Analytics = () => {
  const { progressData, loading, error } = useContext(ProgressContext);

  const chartData = {
    labels: progressData
      ? progressData.map((course) => course.Course_Name)
      : [],
    datasets: [
      {
        label: "Progress Percentage",
        data: progressData
          ? progressData.map((course) => course.Progress_Percentage)
          : [],
        backgroundColor: "rgba(75, 192, 192, 0.6)",
      },
    ],
  };

  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Analytics</h2>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      {/* {progressData && <Bar data={chartData} />} */}
    </div>
  );
};

export default Analytics;
