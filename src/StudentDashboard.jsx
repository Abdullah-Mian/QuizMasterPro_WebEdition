// src/StudentDashboard.js
import React, { useContext } from "react";
import { AuthContext } from "./components/AuthContext";
import { Routes, Route } from "react-router-dom";
import StudentCourses from "./StudentCourses";

const StudentDashboard = () => {
  const { userData } = useContext(AuthContext);

  return (
    <div className="dashboard p-4 ">
      <h2 className="text-2xl font-bold mb-4 text-center">Student Dashboard</h2>
      <h1 className="text-xl font-bold ml-4">
        Welcome back {JSON.stringify(userData[0].StudentName)}
      </h1>
      <Routes>
        <Route path="/" element={<StudentCourses />} />
      </Routes>
    </div>
  );
};

export default StudentDashboard;
