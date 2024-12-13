// src/AdminDashboard.js
import React, { useContext } from "react";
import { AuthContext } from "../Contexts/AuthContext";
import { Routes, Route, Link } from "react-router-dom";
import { motion } from "framer-motion";
import { DegreeProgramsContext } from "../Contexts/DegreeProgramsContext";
import {
  FaUsers,
  FaGraduationCap,
  FaUserPlus,
  FaChartBar,
} from "react-icons/fa";
import DegreePrograms from "./DegreePrograms";
import EnrollStudent from "./EnrollStudent";

const StatCard = ({ icon, title, value, color }) => (
  <motion.div
    whileHover={{ scale: 1.05 }}
    className={`bg-gradient-to-br from-gray-800 to-gray-900 p-6 rounded-xl shadow-lg`}
  >
    <div className="flex items-center space-x-4">
      <div className={`p-3 ${color} rounded-lg bg-opacity-20`}>{icon}</div>
      <div>
        <p className="text-gray-400 text-sm">{title}</p>
        <p className="text-2xl font-bold text-white">{value}</p>
      </div>
    </div>
  </motion.div>
);

const AdminDashboard = () => {
  const { username, userData } = useContext(AuthContext);
  const { degreePrograms, courses } = useContext(DegreeProgramsContext);

  const totalCourses = Object.values(courses).reduce(
    (total, programCourses) => total + (programCourses?.length || 0),
    0
  );

  const hideScrollbarStyle = {
    overflow: "auto",
    scrollbarWidth: "none",
    msOverflowStyle: "none",
  };

  const hideScrollbarWebkit = `
    ::-webkit-scrollbar {
      display: none;
    }
  `;

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-900 via-gray-800 to-gray-900">
      <style>{hideScrollbarWebkit}</style>

      {/* Welcome Banner */}
      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        className="bg-gradient-to-r from-blue-600 to-blue-800 text-white py-8 px-6 mb-8"
      >
        <div className="container mx-auto">
          <h1 className="text-3xl font-bold mb-2">
            Welcome back, {userData[0]?.AdminName}
          </h1>
          <p className="text-blue-100">
            Manage your institution's academic progress
          </p>
        </div>
      </motion.div>

      <div className="container mx-auto px-6" style={hideScrollbarStyle}>
        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          <StatCard
            icon={<FaUsers className="text-2xl text-blue-400" />}
            title="Total Students"
            value="1,234"
            color="bg-blue-400"
          />
          <StatCard
            icon={<FaGraduationCap className="text-2xl text-green-400" />}
            title="Degree Programs"
            value={degreePrograms.length}
            color="bg-green-400"
          />

          <StatCard
            icon={<FaChartBar className="text-2xl text-yellow-400" />}
            title="Active Courses"
            value={totalCourses}
            color="bg-yellow-400"
          />
        </div>

        {/* Quick Actions */}
        <div className="flex space-x-4 mb-8">
          <motion.div whileHover={{ scale: 1.02 }}>
            <Link
              to="/admin/enroll"
              className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg flex items-center space-x-2"
            >
              <FaUserPlus />
              <span>Enroll Student</span>
            </Link>
          </motion.div>
        </div>

        {/* Main Content */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2 }}
          className="bg-gray-800 rounded-xl shadow-xl p-6"
        >
          <Routes>
            <Route path="/" element={<DegreePrograms />} />
            <Route path="enroll" element={<EnrollStudent />} />
          </Routes>
        </motion.div>
      </div>
    </div>
  );
};

export default AdminDashboard;
