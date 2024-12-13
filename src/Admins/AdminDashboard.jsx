// src/AdminDashboard.js
import React, { useContext } from "react";
import { AuthContext } from "../Contexts/AuthContext";
import { Routes, Route, Link } from "react-router-dom";
import DegreePrograms from "./DegreePrograms";
import EnrollStudent from "./EnrollStudent";

const AdminDashboard = () => {
  const { username, userData } = useContext(AuthContext);
  console.log(userData); // Ensure this logs the correct data
  // Add CSS to hide the scrollbar but still allow scrolling
  const hideScrollbarStyle = {
    overflow: "auto",
    scrollbarWidth: "none", // For Firefox
    msOverflowStyle: "none", // For Internet Explorer and Edge
  };

  // For Webkit browsers like Chrome and Safari
  const hideScrollbarWebkit = `
    ::-webkit-scrollbar {
      display: none;
    }
  `;

  return (
    <div className="p-4" style={hideScrollbarStyle}>
      <style>{hideScrollbarWebkit}</style>
      <h2 className="text-2xl font-bold mb-4 text-center">Admin Dashboard</h2>
      <p className="mb-4">
        Welcome back {JSON.stringify(userData[0].AdminName)}
      </p>

      <Routes>
        <Route path="/" element={<DegreePrograms />} />
        {/* <Route path="degProg/:students" element={<Students />} /> */}
        <Route path="enroll" element={<EnrollStudent />} />
      </Routes>
    </div>
  );
};

export default AdminDashboard;
