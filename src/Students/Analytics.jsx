// src/Analytics.jsx
import React, { useContext, useEffect, useState } from "react";
import { ProgressContext } from "../Contexts/ProgressContext";
import { AuthContext } from "../Contexts/AuthContext";
import { DegreeProgramsContext } from "../Contexts/DegreeProgramsContext";
import { motion } from "framer-motion";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  LineElement,
  PointElement,
  ArcElement,
  Title,
  Tooltip,
  Legend,
} from "chart.js";
import { Bar, Line, Pie } from "react-chartjs-2";

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  LineElement,
  PointElement,
  ArcElement,
  Title,
  Tooltip,
  Legend
);

const Analytics = () => {
  const { username, password, userData } = useContext(AuthContext);
  const { courses } = useContext(DegreeProgramsContext);
  const { progressData, loading, error } = useContext(ProgressContext);
  const [courseDetails, setCourseDetails] = useState({});
  const [loadingState, setLoadingState] = useState(true);

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

    const fetchAllCourseDetails = async () => {
      setLoadingState(true);
      for (const course of courses) {
        if (course.AttemptedQuizzes > 0) {
          await fetchCourseDetails(course.Course_id);
        }
      }
      setLoadingState(false);
    };

    fetchAllCourseDetails();
  }, [courses, username, password, userData]);

  // Course Progress Bar Chart
  const courseProgressData = {
    labels: courses.map((course) => course.Course_Code),
    datasets: [
      {
        label: "Course Progress",
        data: courses.map((course) => course.Progress_Percentage || 0),
        backgroundColor: "rgba(54, 162, 235, 0.8)",
        borderColor: "rgba(54, 162, 235, 1)",
        borderWidth: 1,
      },
    ],
  };

  // Quiz Performance Line Chart
  const getQuizPerformanceData = () => {
    const labels = [];
    const data = [];

    Object.values(courseDetails).forEach((course) => {
      if (course.QuizDetails) {
        course.QuizDetails.forEach((quiz) => {
          labels.push(`Quiz ${quiz.QuizSessionID}`);
          data.push(quiz.ProgressPercentage);
        });
      }
    });

    return {
      labels,
      datasets: [
        {
          label: "Quiz Performance",
          data,
          borderColor: "rgba(75, 192, 192, 1)",
          tension: 0.1,
          fill: false,
        },
      ],
    };
  };

  // Scholastic Status Pie Chart
  const getScholasticStatusData = () => {
    let pass = 0;
    let fail = 0;

    Object.values(courseDetails).forEach((course) => {
      if (course.QuizDetails) {
        course.QuizDetails.forEach((quiz) => {
          if (quiz.ScholasticStatus === "Pass") pass++;
          else fail++;
        });
      }
    });

    return {
      labels: ["Pass", "Fail"],
      datasets: [
        {
          data: [pass, fail],
          backgroundColor: [
            "rgba(75, 192, 192, 0.8)",
            "rgba(255, 99, 132, 0.8)",
          ],
          borderColor: ["rgba(75, 192, 192, 1)", "rgba(255, 99, 132, 1)"],
          borderWidth: 1,
        },
      ],
    };
  };

  if (loadingState) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="p-6 space-y-8"
    >
      {/* Overall Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <motion.div
          whileHover={{ scale: 1.02 }}
          className="bg-gradient-to-br from-blue-600 to-blue-800 rounded-xl p-6 text-white"
        >
          <h3 className="text-lg font-semibold mb-2">Overall Progress</h3>
          <p className="text-3xl font-bold">
            {(
              courses.reduce(
                (acc, course) => acc + (course.Progress_Percentage || 0),
                0
              ) / courses.length
            ).toFixed(1)}
            %
          </p>
        </motion.div>

        <motion.div
          whileHover={{ scale: 1.02 }}
          className="bg-gradient-to-br from-green-600 to-green-800 rounded-xl p-6 text-white"
        >
          <h3 className="text-lg font-semibold mb-2">Total Quizzes</h3>
          <p className="text-3xl font-bold">
            {courses.reduce(
              (acc, course) => acc + (course.AttemptedQuizzes || 0),
              0
            )}
          </p>
        </motion.div>

        <motion.div
          whileHover={{ scale: 1.02 }}
          className="bg-gradient-to-br from-purple-600 to-purple-800 rounded-xl p-6 text-white"
        >
          <h3 className="text-lg font-semibold mb-2">Active Courses</h3>
          <p className="text-3xl font-bold">{courses.length}</p>
        </motion.div>
      </div>

      {/* Charts */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <motion.div
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          className="bg-gray-800 rounded-xl p-6"
        >
          <h3 className="text-xl font-bold text-white mb-4">Course Progress</h3>
          <Bar
            data={courseProgressData}
            options={{
              responsive: true,
              scales: {
                y: {
                  beginAtZero: true,
                  max: 100,
                  ticks: { color: "rgba(255, 255, 255, 0.7)" },
                },
                x: {
                  ticks: { color: "rgba(255, 255, 255, 0.7)" },
                },
              },
              plugins: {
                legend: {
                  labels: { color: "rgba(255, 255, 255, 0.7)" },
                },
              },
            }}
          />
        </motion.div>

        <motion.div
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          className="bg-gray-800 rounded-xl p-6"
        >
          <h3 className="text-xl font-bold text-white mb-4">
            Quiz Performance Trend
          </h3>
          <Line
            data={getQuizPerformanceData()}
            options={{
              responsive: true,
              scales: {
                y: {
                  beginAtZero: true,
                  max: 100,
                  ticks: { color: "rgba(255, 255, 255, 0.7)" },
                },
                x: {
                  ticks: { color: "rgba(255, 255, 255, 0.7)" },
                },
              },
              plugins: {
                legend: {
                  labels: { color: "rgba(255, 255, 255, 0.7)" },
                },
              },
            }}
          />
        </motion.div>

        <motion.div
          initial={{ y: 20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          className="bg-gray-800 rounded-xl p-6"
        >
          <h3 className="text-xl font-bold text-white mb-4">
            Scholastic Status Distribution
          </h3>
          <div className="w-full max-w-md mx-auto">
            <Pie
              data={getScholasticStatusData()}
              options={{
                responsive: true,
                plugins: {
                  legend: {
                    labels: { color: "rgba(255, 255, 255, 0.7)" },
                  },
                },
              }}
            />
          </div>
        </motion.div>
      </div>
    </motion.div>
  );
};

export default Analytics;
