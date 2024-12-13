// src/StudentCourses.jsx
import React, { useContext } from "react";
import { AuthContext } from "../Contexts/AuthContext";
import { DegreeProgramsContext } from "../Contexts/DegreeProgramsContext";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import { FaBook, FaChartLine, FaClock } from "react-icons/fa";

const CourseCard = ({ course }) => (
  <motion.div
    whileHover={{ scale: 1.02 }}
    whileTap={{ scale: 0.98 }}
    className="bg-gradient-to-br from-gray-800 to-gray-900 rounded-xl shadow-xl overflow-hidden"
  >
    <Link to={`/student/course/${course.Course_id}`}>
      <div className="p-6 space-y-4">
        <div className="flex items-center space-x-3">
          <FaBook className="text-2xl text-blue-400" />
          <h3 className="text-xl font-bold text-white">{course.Course_Code}</h3>
        </div>

        <p className="text-gray-300 font-medium">{course.Course_Name}</p>

        <div className="grid grid-cols-2 gap-4 mt-4">
          <div className="flex items-center space-x-2">
            <FaChartLine className="text-green-400" />
            <div className="text-sm">
              <p className="text-gray-400">Progress</p>
              <p className="text-white font-bold">
                {course.Progress_Percentage ?? 0}%
              </p>
            </div>
          </div>

          <div className="flex items-center space-x-2">
            <FaClock className="text-purple-400" />
            <div className="text-sm">
              <p className="text-gray-400">Attempts</p>
              <p className="text-white font-bold">
                {course.AttemptedQuizzes ?? 0}
              </p>
            </div>
          </div>
        </div>

        <div className="mt-4 pt-4 border-t border-gray-700">
          <motion.div
            whileHover={{ x: 5 }}
            className="flex items-center justify-end text-blue-400"
          >
            View Details →
          </motion.div>
        </div>
      </div>
    </Link>
  </motion.div>
);

const StudentCourses = () => {
  const { userData } = useContext(AuthContext);
  const { courses, loading, error } = useContext(DegreeProgramsContext);

  if (loading) {
    return (
      <div className="p-8">
        <div className="animate-pulse space-y-4">
          {[1, 2, 3].map((n) => (
            <div key={n} className="h-32 bg-gray-800 rounded-xl"></div>
          ))}
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="p-8">
        <div className="bg-red-900/20 border border-red-500 text-red-500 rounded-lg p-4">
          Error: {error}
        </div>
      </div>
    );
  }

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="p-8"
    >
      <div className="flex justify-between items-center mb-8">
        <div>
          <h2 className="text-3xl font-bold text-white mb-2">Your Courses</h2>
          <p className="text-gray-400">
            Track your progress and continue learning
          </p>
        </div>
        <div className="text-right">
          <p className="text-sm text-gray-400">Total Courses</p>
          <p className="text-2xl font-bold text-white">
            {Array.isArray(courses) ? courses.length : 0}
          </p>
        </div>
      </div>

      {Array.isArray(courses) && courses.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {courses.map((course, index) => (
            <CourseCard key={course.Course_id || index} course={course} />
          ))}
        </div>
      ) : (
        <div className="text-center py-12">
          <p className="text-gray-400">No courses registered yet.</p>
        </div>
      )}
    </motion.div>
  );
};

export default StudentCourses;
