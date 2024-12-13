import React, { useState, useContext } from "react";
import { DegreeProgramsContext } from "../Contexts/DegreeProgramsContext";
import { AuthContext } from "../Contexts/AuthContext";
import { motion, AnimatePresence } from "framer-motion";
import {
  FaUserPlus,
  FaGraduationCap,
  FaBook,
  FaCheck,
  FaExclamation,
} from "react-icons/fa";

const FormInput = ({ label, type, value, onChange, required = true }) => (
  <motion.div
    initial={{ opacity: 0, y: 20 }}
    animate={{ opacity: 1, y: 0 }}
    className="space-y-2"
  >
    <label className="block text-gray-300 font-medium">{label}</label>
    <input
      type={type}
      value={value}
      onChange={onChange}
      required={required}
      className="w-full p-3 bg-gray-700 border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition-all duration-200"
    />
  </motion.div>
);

const CourseCard = ({ course, isSelected, onToggle }) => (
  <motion.div
    whileHover={{ scale: 1.02 }}
    whileTap={{ scale: 0.98 }}
    className={`p-4 rounded-lg cursor-pointer border ${
      isSelected
        ? "border-blue-500 bg-blue-500/20"
        : "border-gray-600 bg-gray-700/50"
    }`}
    onClick={onToggle}
  >
    <div className="flex items-center space-x-3">
      <FaBook className={isSelected ? "text-blue-400" : "text-gray-400"} />
      <div>
        <p className="font-medium text-white">{course.Course_Code}</p>
        <p className="text-sm text-gray-400">{course.Course_Name}</p>
      </div>
      {isSelected && <FaCheck className="ml-auto text-blue-500" />}
    </div>
  </motion.div>
);

const EnrollStudent = () => {
  const { degreePrograms, courses } = useContext(DegreeProgramsContext);
  const { username, password } = useContext(AuthContext);
  const [studentName, setStudentName] = useState("");
  const [studentUsername, setStudentUsername] = useState("");
  const [studentPassword, setStudentPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [selectedDegProg, setSelectedDegProg] = useState("");
  const [selectedCourses, setSelectedCourses] = useState([]);
  const [message, setMessage] = useState("");
  const [status, setStatus] = useState(""); // "success" or "error"
  const [loading, setLoading] = useState(false);

  const handleDegProgChange = (e) => {
    setSelectedDegProg(e.target.value);
    setSelectedCourses([]);
  };

  const handleCourseToggle = (courseId) => {
    setSelectedCourses((prev) =>
      prev.includes(courseId)
        ? prev.filter((id) => id !== courseId)
        : [...prev, courseId]
    );
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setMessage("");
    setStatus("");

    if (studentPassword !== confirmPassword) {
      setMessage("Passwords do not match");
      setStatus("error");
      setLoading(false);
      return;
    }

    try {
      const response = await fetch("http://localhost:3000/enrollstudent", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-username": username,
          "x-password": password,
        },
        body: JSON.stringify({
          studentName,
          studentUsername,
          studentPassword,
          degreeProgram: selectedDegProg,
          courses: selectedCourses,
        }),
      });

      const data = await response.json();

      if (response.ok) {
        setMessage("Student enrolled successfully");
        setStatus("success");
        // Reset form
        setStudentName("");
        setStudentUsername("");
        setStudentPassword("");
        setConfirmPassword("");
        setSelectedDegProg("");
        setSelectedCourses([]);
      } else {
        setMessage(data.error || "Failed to enroll student");
        setStatus("error");
      }
    } catch (error) {
      setMessage("Error connecting to server");
      setStatus("error");
    } finally {
      setLoading(false);
    }
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="max-w-4xl mx-auto p-6"
    >
      <div className="bg-gradient-to-br from-gray-800 to-gray-900 rounded-xl shadow-xl p-8">
        <div className="flex items-center space-x-4 mb-8">
          <FaUserPlus className="text-3xl text-blue-500" />
          <h2 className="text-2xl font-bold text-white">Enroll New Student</h2>
        </div>

        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <FormInput
              label="Student Name"
              type="text"
              value={studentName}
              onChange={(e) => setStudentName(e.target.value)}
            />
            <FormInput
              label="Username"
              type="text"
              value={studentUsername}
              onChange={(e) => setStudentUsername(e.target.value)}
            />
            <FormInput
              label="Password"
              type="password"
              value={studentPassword}
              onChange={(e) => setStudentPassword(e.target.value)}
            />
            <FormInput
              label="Confirm Password"
              type="password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
            />
          </div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="space-y-2"
          >
            <label className="block text-gray-300 font-medium">
              Degree Program
            </label>
            <select
              value={selectedDegProg}
              onChange={handleDegProgChange}
              required
              className="w-full p-3 bg-gray-700 border border-gray-600 rounded-lg text-white focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition-all duration-200"
            >
              <option value="">Select Degree Program</option>
              {degreePrograms.map((degProg) => (
                <option key={degProg.Deg_Prog} value={degProg.Deg_Prog}>
                  {degProg.Deg_Prog_Name}
                </option>
              ))}
            </select>
          </motion.div>

          <AnimatePresence>
            {selectedDegProg && (
              <motion.div
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: "auto" }}
                exit={{ opacity: 0, height: 0 }}
                className="space-y-4"
              >
                <label className="block text-gray-300 font-medium">
                  Select Courses
                </label>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {courses[selectedDegProg]?.map((course) => (
                    <CourseCard
                      key={course.Course_id}
                      course={course}
                      isSelected={selectedCourses.includes(course.Course_id)}
                      onToggle={() => handleCourseToggle(course.Course_id)}
                    />
                  ))}
                </div>
              </motion.div>
            )}
          </AnimatePresence>

          {message && (
            <motion.div
              initial={{ opacity: 0, y: -20 }}
              animate={{ opacity: 1, y: 0 }}
              className={`p-4 rounded-lg ${
                status === "success"
                  ? "bg-green-500/20 text-green-400 border border-green-500"
                  : "bg-red-500/20 text-red-400 border border-red-500"
              }`}
            >
              <div className="flex items-center space-x-2">
                {status === "success" ? (
                  <FaCheck className="text-green-400" />
                ) : (
                  <FaExclamation className="text-red-400" />
                )}
                <span>{message}</span>
              </div>
            </motion.div>
          )}

          <motion.button
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
            disabled={loading}
            type="submit"
            className={`w-full p-4 rounded-lg font-semibold ${
              loading
                ? "bg-gray-600 cursor-not-allowed"
                : "bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700"
            } text-white shadow-lg transition-all duration-300`}
          >
            {loading ? (
              <span className="flex items-center justify-center">
                <svg className="animate-spin h-5 w-5 mr-3" viewBox="0 0 24 24">
                  <circle
                    className="opacity-25"
                    cx="12"
                    cy="12"
                    r="10"
                    stroke="currentColor"
                    strokeWidth="4"
                  ></circle>
                  <path
                    className="opacity-75"
                    fill="currentColor"
                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                  ></path>
                </svg>
                Enrolling...
              </span>
            ) : (
              "Enroll Student"
            )}
          </motion.button>
        </form>
      </div>
    </motion.div>
  );
};

export default EnrollStudent;
