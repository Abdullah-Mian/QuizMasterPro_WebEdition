// src/AdminDashboard.js
import React, { useContext } from "react";
import { AuthContext } from "./AuthContext";
import { Routes, Route, Link } from "react-router-dom";
import DegreePrograms from "./DegreePrograms";
import Students from "./Students";
import EnrollStudent from "./EnrollStudent"; // Ensure this path is correct

const AdminDashboard = () => {
  const { username } = useContext(AuthContext);

  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Admin Dashboard</h2>
      <p className="mb-4">Logged in as: {username}</p>
      <div className="flex justify-between items-center mb-4">
        <h3 className="text-xl">Degree Programs</h3>
        <Link
          to="enroll"
          className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
        >
          Enroll Student
        </Link>
      </div>
      <Routes>
        <Route path="/" element={<DegreePrograms />} />
        <Route path="students/:degProg" element={<Students />} />
        <Route path="enroll" element={<EnrollStudent />} />
      </Routes>
    </div>
  );
};

export default AdminDashboard;
