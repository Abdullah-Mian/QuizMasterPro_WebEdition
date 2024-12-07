// src/AdminDashboard.js
import React, { useContext } from "react";
import { AuthContext } from "./AuthContext";
import { Routes, Route, Link } from "react-router-dom";
import DegreePrograms from "./DegreePrograms";
import Students from "./Students";
import EnrollStudent from "./EnrollStudent";

const AdminDashboard = () => {
  const { username, userData } = useContext(AuthContext);
  console.log(userData); // Ensure this logs the correct data

  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Admin Dashboard</h2>
      <p className="mb-4">
        Logged in as: {JSON.stringify(userData[0].AdminName)}
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
