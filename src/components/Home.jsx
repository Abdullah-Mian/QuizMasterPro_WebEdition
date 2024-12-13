// src/Home.jsx
import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import {
  FaBrain,
  FaChartLine,
  FaBook,
  FaMedal,
  FaClock,
  FaUserGraduate,
} from "react-icons/fa";
import { motion } from "framer-motion";

const FeatureCard = ({ icon, title, description, onClick }) => (
  <motion.div
    whileHover={{ scale: 1.05 }}
    whileTap={{ scale: 0.95 }}
    className="bg-gradient-to-br from-gray-800 to-gray-900 text-white p-6 rounded-xl shadow-xl hover:shadow-2xl transition-all duration-300 cursor-pointer"
    onClick={onClick}
  >
    <div className="flex items-center mb-4">
      {icon}
      <h2 className="text-2xl font-bold ml-3">{title}</h2>
    </div>
    <p className="text-gray-300">{description}</p>
    <div className="mt-4 flex justify-end">
      <span className="text-blue-400 hover:text-blue-300 transition-colors">
        Learn more →
      </span>
    </div>
  </motion.div>
);

const Home = () => {
  const navigate = useNavigate();
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    setIsVisible(true);
  }, []);

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-900 via-gray-800 to-gray-900">
      {/* Hero Section */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8 }}
        className="py-20 px-4 text-center"
      >
        <h1 className="text-6xl font-bold mb-6 bg-clip-text text-transparent bg-gradient-to-r from-blue-400 to-purple-600">
          Welcome to QuizMasterPro
        </h1>
        <p className="text-xl text-gray-300 max-w-3xl mx-auto mb-8">
          Your intelligent learning companion designed to transform education
          through interactive assessments and personalized progress tracking.
        </p>
        <motion.button
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          className="bg-blue-600 hover:bg-blue-700 text-white px-8 py-3 rounded-full text-lg font-semibold transition-all duration-300 shadow-lg hover:shadow-xl"
          onClick={() => navigate("/courses")}
        >
          Start Learning
        </motion.button>
      </motion.div>

      {/* Features Grid */}
      <div className="container mx-auto px-4 pb-20">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <FeatureCard
            icon={<FaBrain className="text-4xl text-blue-400" />}
            title="Smart Quizzes"
            description="Experience adaptive quizzes that match your skill level. With our database of carefully curated questions across multiple courses, master your subjects one quiz at a time."
            onClick={() => navigate("/")}
          />

          <FeatureCard
            icon={<FaBook className="text-4xl text-green-400" />}
            title="Course Library"
            description="Access a comprehensive collection of courses from various programs including BSCS, BCE, BSSE, and more. Each course is structured for optimal learning and retention."
            onClick={() => navigate("/courses")}
          />

          <FeatureCard
            icon={<FaChartLine className="text-4xl text-purple-400" />}
            title="Progress Analytics"
            description="Track your learning journey with detailed analytics. View your quiz history, performance metrics, and improvement trends in real-time."
            onClick={() => navigate("/analytics")}
          />

          <FeatureCard
            icon={<FaClock className="text-4xl text-yellow-400" />}
            title="Timed Assessments"
            description="Challenge yourself with timed quizzes that simulate exam conditions. Improve your time management skills while testing your knowledge."
            onClick={() => navigate("/assessments")}
          />

          <FeatureCard
            icon={<FaMedal className="text-4xl text-red-400" />}
            title="Achievement System"
            description="Earn badges and certificates as you progress. Track your scholastic status and celebrate your academic victories with our comprehensive reward system."
            onClick={() => navigate("/achievements")}
          />

          <FeatureCard
            icon={<FaUserGraduate className="text-4xl text-indigo-400" />}
            title="Student Portal"
            description="Access your personalized dashboard to manage enrolled courses, view upcoming assessments, and track your overall academic progress."
            onClick={() => navigate("/dashboard")}
          />
        </div>
      </div>

      {/* Stats Section */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: isVisible ? 1 : 0 }}
        transition={{ duration: 1 }}
        className="bg-gray-800 py-16"
      >
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
            <div className="p-6">
              <h3 className="text-4xl font-bold text-blue-400">20+</h3>
              <p className="text-gray-300 mt-2">Available Courses</p>
            </div>
            <div className="p-6">
              <h3 className="text-4xl font-bold text-green-400">100000+</h3>
              <p className="text-gray-300 mt-2">Quiz Questions</p>
            </div>
            <div className="p-6">
              <h3 className="text-4xl font-bold text-purple-400">110+</h3>
              <p className="text-gray-300 mt-2">Degree Programs</p>
            </div>
          </div>
        </div>
      </motion.div>
    </div>
  );
};

export default Home;
