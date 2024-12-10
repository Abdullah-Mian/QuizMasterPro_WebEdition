// src/StudentDashboard.js
import React, { useContext, useEffect } from "react";
import { AuthContext } from "./components/AuthContext";
import { DegreeProgramsContext } from "./components/DegreeProgramsContext";
import { Routes, Route } from "react-router-dom";
import StudentCourses from "./StudentCourses";
import Progress from "./Progress";
import Analytics from "./Analytics";

const StudentDashboard = () => {
  const { username, password, userData } = useContext(AuthContext);
  const { setCourses, setLoading, setError } = useContext(
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
    <div className="dashboard p-4 ">
      <h2 className="text-2xl font-bold mb-4 text-center">Student Dashboard</h2>
      <h2 className="text-2xl font-bold mb-4 text-center">
        {JSON.stringify(userData[0].Deg_Prog)}
      </h2>
      <h1 className="text-xl font-bold ml-4">
        Welcome back {JSON.stringify(userData[0].StudentName)}
      </h1>
      <Routes>
        <Route path="/" element={<StudentCourses />} />
        <Route path="/progress" element={<Progress />} />
        <Route path="/analytics" element={<Analytics />} />
      </Routes>
    </div>
  );
};

export default StudentDashboard;
