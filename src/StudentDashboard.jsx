// src/StudentDashboard.js
import React, { useContext, useEffect } from "react";
import { AuthContext } from "./components/AuthContext";
import { DegreeProgramsContext } from "./components/DegreeProgramsContext";
import { Routes, Route } from "react-router-dom";
import { motion } from "framer-motion";
import { FaGraduationCap, FaBook, FaChartLine } from "react-icons/fa";
import StudentCourses from "./StudentCourses";
import Progress from "./Progress";
import Analytics from "./Analytics";

const StatCard = ({ icon, title, value }) => (
  <motion.div
    whileHover={{ scale: 1.05 }}
    className="bg-gradient-to-br from-gray-800 to-gray-900 p-6 rounded-xl shadow-lg"
  >
    <div className="flex items-center space-x-4">
      {icon}
      <div>
        <h3 className="text-gray-400 text-sm">{title}</h3>
        <p className="text-white text-2xl font-bold">{value}</p>
      </div>
    </div>
  </motion.div>
);

const StudentDashboard = () => {
  const { username, password, userData } = useContext(AuthContext);
  const { setCourses, setLoading, setError, courses } = useContext(
    DegreeProgramsContext
  );

  useEffect(() => {
    const fetchStudentCourses = async () => {
      setLoading(true);
      setError(null);
      try {
        const response = await fetch(
          `http://localhost:3000/studentcourses?studentId=${userData[0].StudentID}`,
          {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              "x-username": username,
              "x-password": password,
            },
          }
        );
        const data = await response.json();
        if (response.ok) {
          setCourses(data);
        } else {
          setError(data.error || "Failed to fetch courses");
        }
      } catch (error) {
        setError("Error connecting to server");
      } finally {
        setLoading(false);
      }
    };

    fetchStudentCourses();
  }, [username, password, userData, setCourses]);

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-900 via-gray-800 to-gray-900">
      {/* Welcome Banner */}
      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        className="bg-gradient-to-r from-blue-600 to-blue-800 text-white py-8 px-4 mb-8"
      >
        <div className="container mx-auto">
          <h1 className="text-3xl font-bold mb-2">
            Welcome back, {userData[0].StudentName}
          </h1>
          <p className="text-blue-100">
            {userData[0].Deg_Prog} - Your learning journey continues here
          </p>
        </div>
      </motion.div>

      <div className="container mx-auto px-4">
        {/* Stats Overview */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <StatCard
            icon={<FaGraduationCap className="text-3xl text-blue-400" />}
            title="Program"
            value={userData[0].Deg_Prog}
          />
          <StatCard
            icon={<FaBook className="text-3xl text-green-400" />}
            title="Enrolled Courses"
            value={`${courses.length} Courses`}
          />

          <StatCard
            icon={<FaChartLine className="text-3xl text-purple-400" />}
            title="Overall Progress"
            value={`${(
              courses.reduce(
                (acc, course) => acc + course.Progress_Percentage,
                0
              ) / courses.length
            ).toFixed(2)}%`}
          />
        </div>

        {/* Main Content */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2 }}
          className="bg-gray-800 rounded-xl shadow-xl p-6"
        >
          <Routes>
            <Route path="/" element={<StudentCourses />} />
            <Route path="/progress" element={<Progress />} />
            <Route path="/analytics" element={<Analytics />} />
          </Routes>
        </motion.div>
      </div>
    </div>
  );
};

export default StudentDashboard;
