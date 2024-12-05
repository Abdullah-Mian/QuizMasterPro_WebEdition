// src/StudentDashboard.js
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "./AuthContext";

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
    <div className="dashboard">
      <h2>Student Dashboard</h2>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      {!loading && !error && (
        <ul>
          {/* {courses.map((course, index) => (
            <li key={index}>{course.Course_Name}</li>
          ))} */}
        </ul>
      )}
    </div>
  );
};

export default StudentDashboard;
