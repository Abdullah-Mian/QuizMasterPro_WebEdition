// src/StudentCourses.jsx
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "./components/AuthContext";
import { DegreeProgramsContext } from "./components/DegreeProgramsContext";

const StudentCourses = () => {
  const { username, password, userData } = useContext(AuthContext);
  const { courses, setCourses } = useContext(DegreeProgramsContext);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

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

  console.log("Courses:", courses);
  console.log(userData);
  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Registered Courses</h2>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      {!loading && !error && (
        <div className="space-y-4">
          {courses.map((course, index) => (
            <div
              key={index}
              className="border-t border-b border-gray-300 rounded-lg p-4 bg-gray-800 text-white"
            >
              <div className="flex justify-between items-center">
                <span>
                  {course.Course_Code} - {course.Course_Name}
                </span>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default StudentCourses;
