// src/AdminDashboard.js
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "./AuthContext";

const AdminDashboard = () => {
  const { username, password } = useContext(AuthContext);
  const [students, setStudents] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchStudents = async () => {
      setLoading(true);
      setError(null);

      try {
        const response = await fetch("http://localhost:3000/students", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "x-username": username,
            "x-password": password,
          },
        });
        const data = await response.json();
        if (response.ok) {
          setStudents(data);
        } else {
          setError(data.error || "Failed to fetch students");
        }
      } catch (error) {
        setError("Error connecting to server");
      } finally {
        setLoading(false);
      }
    };

    fetchStudents();
  }, [username, password]);

  return (
    <div className="dashboard">
      <h2>Admin Dashboard</h2>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      {!loading && !error && (
        <ul>
          {/* {students.map((student, index) => (
            <li key={index}>{student.StudentName}</li>
          ))} */}
        </ul>
      )}
    </div>
  );
};

export default AdminDashboard;
