// src/Progress.jsx
import React, { useContext, useEffect, useState } from "react";
import { ProgressContext } from "./ProgressContext";
import { AuthContext } from "./components/AuthContext";
import { DegreeProgramsContext } from "./components/DegreeProgramsContext";
import { motion, AnimatePresence } from "framer-motion";
import {
  FaBook,
  FaChartLine,
  FaCheckCircle,
  FaTimesCircle,
  FaTrophy,
  FaClock,
} from "react-icons/fa";

const CourseProgressCard = ({
  course,
  courseDetails,
  onToggle,
  isExpanded,
}) => (
  <motion.div
    initial={{ opacity: 0, y: 20 }}
    animate={{ opacity: 1, y: 0 }}
    className="bg-gradient-to-br from-gray-800 to-gray-900 rounded-xl shadow-lg overflow-hidden mb-6"
  >
    <div className="p-6">
      {/* Course Header */}
      <div className="flex justify-between items-start mb-4">
        <div>
          <div className="flex items-center space-x-3 mb-2">
            <FaBook className="text-2xl text-blue-400" />
            <h3 className="text-xl font-bold text-white">
              {course.Course_Code}
            </h3>
          </div>
          <p className="text-gray-300">{course.Course_Name}</p>
        </div>
        <div className="text-right">
          <div className="text-3xl font-bold text-white">
            {course.Progress_Percentage || 0}%
          </div>
          <p className="text-sm text-gray-400">Overall Progress</p>
        </div>
      </div>
      {/* Stats Grid */}
      <div className="grid grid-cols-3 gap-4 mb-4">
        <div className="bg-gray-700/30 rounded-lg p-3">
          <div className="flex items-center space-x-2">
            <FaClock className="text-blue-400" />
            <div>
              <p className="text-sm text-gray-400">Attempts</p>
              <p className="text-lg font-bold text-white">
                {course.AttemptedQuizzes || 0}
              </p>
            </div>
          </div>
        </div>
        <div className="bg-gray-700/30 rounded-lg p-3">
          <div className="flex items-center space-x-2">
            <FaChartLine className="text-green-400" />
            <div>
              <p className="text-sm text-gray-400">Avg Score</p>
              <p className="text-lg font-bold text-white">
                {courseDetails?.QuizDetails?.reduce(
                  (acc, quiz) =>
                    acc +
                    (parseInt(quiz.ObtainedMarks) /
                      parseInt(quiz.QuizTotalScore)) *
                      100,
                  0
                ) / (courseDetails?.QuizDetails?.length || 1) || 0}
                %
              </p>
            </div>
          </div>
        </div>
        <div className="bg-gray-700/30 rounded-lg p-3">
          <div className="flex items-center space-x-2">
            <FaTrophy className="text-yellow-400" />
            <div>
              <p className="text-sm text-gray-400">Best Score</p>
              <p className="text-lg font-bold text-white">
                {Math.max(
                  ...(courseDetails?.QuizDetails?.map(
                    (q) => q.ProgressPercentage
                  ) || [0])
                )}
                %
              </p>
            </div>
          </div>
        </div>
      </div>
      {/* Quiz History */}
      {course.AttemptedQuizzes > 0 && (
        <>
          <button
            onClick={() => onToggle(course.Course_id)}
            className="w-full text-left text-blue-400 hover:text-blue-300 transition-colors flex items-center justify-between"
          >
            <span>View Quiz History</span>
            <span>{isExpanded ? "▼" : "▶"}</span>
          </button>

          <AnimatePresence>
            {isExpanded && courseDetails && (
              <motion.div
                initial={{ height: 0, opacity: 0 }}
                animate={{ height: "auto", opacity: 1 }}
                exit={{ height: 0, opacity: 0 }}
                className="mt-4 space-y-3"
              >
                {courseDetails.QuizDetails.map((quiz, index) => (
                  <div key={index} className="bg-gray-700/30 rounded-lg p-3">
                    <div className="flex justify-between items-center">
                      <div>
                        <p className="text-sm text-gray-400">
                          Quiz #{quiz.QuizSessionID}
                        </p>
                        <p className="text-white">
                          Score: {quiz.ObtainedMarks}/{quiz.QuizTotalScore}
                        </p>
                      </div>
                      <div className="text-right">
                        <p
                          className={`text-sm ${
                            quiz.ScholasticStatus === "Pass"
                              ? "text-green-400"
                              : "text-red-400"
                          }`}
                        >
                          {quiz.ScholasticStatus}
                        </p>
                        <p className="text-white">{quiz.ProgressPercentage}%</p>
                      </div>
                    </div>
                  </div>
                ))}
              </motion.div>
            )}
          </AnimatePresence>
        </>
      )}
    </div>
  </motion.div>
);

const Progress = () => {
  const { username, password, userData } = useContext(AuthContext);
  const { courses } = useContext(DegreeProgramsContext);
  const [courseDetails, setCourseDetails] = useState({});
  const [expandedCourse, setExpandedCourse] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const fetchCourseDetails = async (courseId) => {
      try {
        const response = await fetch(
          `http://localhost:3000/coursedetails?studentId=${userData[0].StudentID}&courseId=${courseId}`,
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
          setCourseDetails((prev) => ({
            ...prev,
            [courseId]: data,
          }));
        }
      } catch (error) {
        console.error("Error fetching course details:", error);
      }
    };

    // Only fetch details for courses with attempts
    courses.forEach((course) => {
      if (course.AttemptedQuizzes > 0) {
        fetchCourseDetails(course.Course_id);
      }
    });
  }, [courses, username, password, userData]);

  const handleToggle = (courseId) => {
    setExpandedCourse(expandedCourse === courseId ? null : courseId);
  };

  const overallProgress =
    courses.length > 0
      ? courses.reduce(
          (acc, course) => acc + (course.Progress_Percentage || 0),
          0
        ) / courses.length
      : 0;

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="p-6"
    >
      {/* Header with Overall Stats */}
      <div className="bg-gradient-to-br from-blue-600 to-blue-800 rounded-xl p-6 text-white shadow-xl mb-8">
        <h2 className="text-2xl font-bold mb-4">Progress Overview</h2>
        <div className="grid grid-cols-3 gap-4">
          <div>
            <p className="text-sm text-blue-200">Overall Progress</p>
            <p className="text-3xl font-bold">{overallProgress.toFixed(1)}%</p>
          </div>
          <div>
            <p className="text-sm text-blue-200">Courses Enrolled</p>
            <p className="text-3xl font-bold">{courses.length}</p>
          </div>
          <div>
            <p className="text-sm text-blue-200">Total Attempts</p>
            <p className="text-3xl font-bold">
              {courses.reduce(
                (acc, course) => acc + (course.AttemptedQuizzes || 0),
                0
              )}
            </p>
          </div>
        </div>
      </div>

      {/* Course Progress Cards */}
      <div className="space-y-6">
        {courses.map((course) => (
          <CourseProgressCard
            key={course.Course_id}
            course={course}
            courseDetails={courseDetails[course.Course_id]}
            onToggle={handleToggle}
            isExpanded={expandedCourse === course.Course_id}
          />
        ))}
      </div>
    </motion.div>
  );
};

export default Progress;
