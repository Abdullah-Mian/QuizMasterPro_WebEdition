// src/StudentCourses.jsx
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "./components/AuthContext";
import { DegreeProgramsContext } from "./components/DegreeProgramsContext";
import { Link } from "react-router-dom";

const StudentCourses = () => {
  const { userData } = useContext(AuthContext);
  const { courses, loading, error } = useContext(DegreeProgramsContext);

  console.log("Courses:", courses);
  console.log(userData);
  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Registered Courses</h2>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      {!loading && !error && Array.isArray(courses) && (
        <div className="space-y-4">
          {courses.map((course, index) => (
            <Link to={`/course/${course.Course_id}`} key={index}>
              <div className="border-t border-b border-gray-300 rounded-lg p-4 bg-gray-800 text-white mb-2">
                <div className="flex justify-between items-center">
                  <span>
                    {course.Course_Code} - {course.Course_Name}
                  </span>
                  <span>Attempted Quizzes: {course.AttemptedQuizzes}</span>
                </div>
              </div>
            </Link>
          ))}
        </div>
      )}
    </div>
  );
};

export default StudentCourses;
