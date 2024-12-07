// src/StudentDashboard.js
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "./AuthContext";
import { Routes, Route, Link } from "react-router-dom";
import DegreePrograms from "./DegreePrograms";

const StudentDashboard = () => {
  const { username, password } = useContext(AuthContext);
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchCourses = async () => {
      setLoading(true);
      setError(null);

      try {
        const response = await fetch("http://localhost:3000/courses", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "x-username": username,
            "x-password": password,
          },
        });
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

    fetchCourses();
  }, [username, password]);

  return (
    <div className="dashboard p-4">
      <h2 className="text-2xl font-bold mb-4">Student Dashboard</h2>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      {!loading && !error && (
        <ul className="list-disc pl-5">
          {courses.map((course, index) => (
            <li key={index}>{course.Course_Name}</li>
          ))}
        </ul>
      )}
      <Routes>
        <Route path="/" element={<DegreePrograms />} />
      </Routes>
    </div>
  );
};

export default StudentDashboard;
