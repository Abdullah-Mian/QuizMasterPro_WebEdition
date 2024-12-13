import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "../Contexts/AuthContext";
import { DegreeProgramsContext } from "../Contexts/DegreeProgramsContext";
import { motion, AnimatePresence } from "framer-motion";
import {
  FaGraduationCap,
  FaBook,
  FaChevronDown,
  FaChevronUp,
} from "react-icons/fa";

const CourseCard = ({ course }) => (
  <motion.div
    initial={{ opacity: 0, y: 10 }}
    animate={{ opacity: 1, y: 0 }}
    className="pl-4 border border-gray-700 rounded-lg p-4 bg-gray-800/50 backdrop-blur-sm"
  >
    <div className="flex items-center space-x-3">
      <FaBook className="text-blue-400" />
      <div>
        <span className="font-medium text-white">{course.Course_Code}</span>
        <span className="text-gray-400 ml-2">-</span>
        <span className="text-gray-300 ml-2">{course.Course_Name}</span>
      </div>
    </div>
  </motion.div>
);

const ProgramCard = ({ program, index, isExpanded, onToggle, courses }) => (
  <motion.div
    initial={{ opacity: 0, y: 20 }}
    animate={{ opacity: 1, y: 0 }}
    transition={{ delay: index * 0.1 }}
    className="border border-gray-700 rounded-lg bg-gray-800/90 backdrop-blur-md shadow-xl overflow-hidden"
  >
    <motion.div
      whileHover={{ backgroundColor: "rgba(55, 65, 81, 0.5)" }}
      className="flex justify-between items-center p-4 cursor-pointer"
      onClick={onToggle}
    >
      <div className="flex items-center space-x-3">
        <FaGraduationCap className="text-2xl text-blue-400" />
        <span className="text-lg font-semibold text-white">
          {program.Deg_Prog_Name}
        </span>
      </div>
      <motion.div
        animate={{ rotate: isExpanded ? 180 : 0 }}
        transition={{ duration: 0.2 }}
      >
        {isExpanded ? (
          <FaChevronUp className="text-gray-400" />
        ) : (
          <FaChevronDown className="text-gray-400" />
        )}
      </motion.div>
    </motion.div>

    <AnimatePresence>
      {isExpanded && (
        <motion.div
          initial={{ height: 0, opacity: 0 }}
          animate={{ height: "auto", opacity: 1 }}
          exit={{ height: 0, opacity: 0 }}
          transition={{ duration: 0.2 }}
          className="border-t border-gray-700"
        >
          <div className="p-4 space-y-3">
            {courses ? (
              courses.map((course, courseIndex) => (
                <CourseCard key={courseIndex} course={course} />
              ))
            ) : (
              <motion.div
                animate={{ opacity: [0.5, 1], y: [0, -5, 0] }}
                transition={{ repeat: Infinity, duration: 2 }}
                className="text-gray-400 text-center py-4"
              >
                Loading courses...
              </motion.div>
            )}
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  </motion.div>
);

const DegreePrograms = () => {
  const { username, password } = useContext(AuthContext);
  const { degreePrograms, setDegreePrograms, courses, setCourses } = useContext(
    DegreeProgramsContext
  );
  const [expanded, setExpanded] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchDegreePrograms = async () => {
      setLoading(true);
      setError(null);
      try {
        const response = await fetch("http://localhost:3000/degreeprograms", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "x-username": username,
            "x-password": password,
          },
        });
        const data = await response.json();
        if (response.ok) {
          setDegreePrograms(data);
        } else {
          setError("Failed to fetch degree programs");
        }
      } catch (error) {
        setError("Error connecting to server");
      } finally {
        setLoading(false);
      }
    };

    if (degreePrograms.length === 0) {
      fetchDegreePrograms();
    }
  }, [username, password, degreePrograms.length, setDegreePrograms]);

  const handleToggle = (degProg) => {
    setExpanded(expanded === degProg ? null : degProg);
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="p-6"
    >
      <motion.div
        initial={{ y: -20 }}
        animate={{ y: 0 }}
        className="flex items-center space-x-4 mb-8"
      >
        <FaGraduationCap className="text-3xl text-blue-500" />
        <div>
          <h1 className="text-2xl font-bold text-white">Degree Programs</h1>
          <p className="text-gray-400">
            Manage your institution's academic programs
          </p>
        </div>
      </motion.div>

      {loading && (
        <div className="flex justify-center items-center h-64">
          <div className="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-blue-500"></div>
        </div>
      )}

      {error && (
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-red-500/20 border border-red-500 text-red-400 p-4 rounded-lg mb-6"
        >
          {error}
        </motion.div>
      )}

      <div className="space-y-4">
        {degreePrograms.map((degProg, index) => (
          <ProgramCard
            key={degProg.Deg_Prog}
            program={degProg}
            index={index}
            isExpanded={expanded === degProg.Deg_Prog}
            onToggle={() => handleToggle(degProg.Deg_Prog)}
            courses={courses[degProg.Deg_Prog]}
          />
        ))}
      </div>
    </motion.div>
  );
};

export default DegreePrograms;
