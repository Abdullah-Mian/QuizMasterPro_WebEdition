// src/CourseDetails.jsx
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "../Contexts/AuthContext";
import { DegreeProgramsContext } from "../Contexts/DegreeProgramsContext";
import { useParams, useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import {
  FaBook,
  FaChartLine,
  FaCheckCircle,
  FaTimesCircle,
  FaChevronDown,
  FaChevronUp,
  FaPen,
} from "react-icons/fa";

const QuizSessionCard = ({ quiz, isExpanded, onToggle }) => (
  <motion.div
    initial={{ opacity: 0, y: 20 }}
    animate={{ opacity: 1, y: 0 }}
    className="bg-gradient-to-br from-gray-800 to-gray-900 rounded-xl shadow-lg overflow-hidden"
  >
    <div className="p-4 cursor-pointer" onClick={onToggle}>
      <div className="flex justify-between items-center">
        <div className="flex items-center space-x-4">
          <div className="p-2 bg-blue-500/20 rounded-lg">
            <FaBook className="text-blue-400 text-xl" />
          </div>
          <div>
            <h4 className="text-lg font-semibold text-white">
              Quiz #{quiz.QuizSessionID}
            </h4>
            <p className="text-sm text-gray-400">
              Scholastic Status: {quiz.ScholasticStatus}
            </p>
          </div>
        </div>
        <div className="text-right">
          <div className="text-2xl font-bold text-white">
            {quiz.ObtainedMarks}/{quiz.QuizTotalScore}
          </div>
          <div className="text-sm text-gray-400">
            {quiz.ProgressPercentage}% Score
          </div>
        </div>
      </div>

      <AnimatePresence>
        {isExpanded && quiz.Questions && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            className="mt-4 space-y-4"
          >
            {quiz.Questions.map((question, qIndex) => (
              <motion.div
                key={qIndex}
                initial={{ x: -20, opacity: 0 }}
                animate={{ x: 0, opacity: 1 }}
                transition={{ delay: qIndex * 0.1 }}
                className="bg-gray-700/50 rounded-lg p-4 space-y-2"
              >
                <p className="text-white font-medium">
                  {question.Question_String}
                </p>
                <div className="grid grid-cols-1 gap-4 mt-4">
                  <div className="bg-gray-800/50 rounded-lg p-4">
                    <div className="flex items-center justify-between mb-2">
                      <span className="text-gray-400 text-sm font-medium">
                        Your Answer
                      </span>
                      {question.Student_Answer === question.Actual_Answer ? (
                        <span className="px-2 py-1 bg-green-500/20 text-green-400 text-xs rounded-full flex items-center">
                          <FaCheckCircle className="mr-1" />
                          Correct
                        </span>
                      ) : (
                        <span className="px-2 py-1 bg-red-500/20 text-red-400 text-xs rounded-full flex items-center">
                          <FaTimesCircle className="mr-1" />
                          Incorrect
                        </span>
                      )}
                    </div>
                    <p
                      className={`text-lg font-medium ${
                        question.Student_Answer === question.Actual_Answer
                          ? "text-green-400"
                          : "text-red-400"
                      }`}
                    >
                      {question.Student_Answer}
                    </p>
                  </div>

                  <div className="bg-gray-800/50 rounded-lg p-4">
                    <div className="flex items-center justify-between mb-2">
                      <span className="text-gray-400 text-sm font-medium">
                        Correct Answer
                      </span>
                      <span className="px-2 py-1 bg-blue-500/20 text-blue-400 text-xs rounded-full">
                        Solution
                      </span>
                    </div>
                    <p className="text-lg font-medium text-blue-400">
                      {question.Actual_Answer}
                    </p>
                  </div>
                </div>
              </motion.div>
            ))}
          </motion.div>
        )}
      </AnimatePresence>

      <div className="flex justify-center mt-4">
        {isExpanded ? (
          <FaChevronUp className="text-gray-400" />
        ) : (
          <FaChevronDown className="text-gray-400" />
        )}
      </div>
    </div>
  </motion.div>
);

const CourseDetails = () => {
  const { username, password, userData } = useContext(AuthContext);
  const { courses } = useContext(DegreeProgramsContext);
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [courseDetails, setCourseDetails] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [expandedQuiz, setExpandedQuiz] = useState(null);

  useEffect(() => {
    const currentCourse = courses.find(
      (c) => c.Course_id.toString() === courseId
    );

    if (!currentCourse) {
      setError("Course not found");
      return;
    }

    if (currentCourse.AttemptedQuizzes === 0) {
      // Set basic course details without fetching
      setCourseDetails({
        Course_Code: currentCourse.Course_Code,
        Course_Name: currentCourse.Course_Name,
        AttemptedQuizzes: 0,
        QuizDetails: [],
      });
      return;
    }

    const fetchCourseDetails = async () => {
      setLoading(true);
      setError(null);

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
          setCourseDetails(data);
        } else {
          setError(data.error || "Failed to fetch course details");
        }
      } catch (error) {
        setError("Error connecting to server");
      } finally {
        setLoading(false);
      }
    };

    fetchCourseDetails();
  }, [username, password, userData, courseId, courses]);

  const handleToggleQuiz = (quizSessionID) => {
    if (expandedQuiz === quizSessionID) {
      setExpandedQuiz(null);
    } else {
      setExpandedQuiz(quizSessionID);
    }
  };

  const handleTakeQuiz = () => {
    navigate(`/student/course/${courseId}/take-quiz`);
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="min-h-screen bg-gradient-to-b from-gray-900 via-gray-800 to-gray-900 p-6"
    >
      {loading && (
        <div className="flex justify-center items-center h-64">
          <div className="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-blue-500"></div>
        </div>
      )}

      {error && (
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-red-500/20 border border-red-500 text-red-500 p-4 rounded-lg"
        >
          Error: {error}
        </motion.div>
      )}

      {courseDetails && (
        <div className="max-w-4xl mx-auto space-y-6">
          <motion.div
            initial={{ y: -20 }}
            animate={{ y: 0 }}
            className="bg-gradient-to-br from-blue-600 to-blue-800 rounded-xl p-6 text-white shadow-xl"
          >
            <h2 className="text-3xl font-bold mb-2">
              {courseDetails.Course_Name}
            </h2>
            <div className="flex items-center space-x-4">
              <span className="px-3 py-1 bg-blue-500/20 rounded-full text-sm">
                {courseDetails.Course_Code}
              </span>
              <span className="flex items-center">
                <FaChartLine className="mr-2" />
                {courseDetails.AttemptedQuizzes || 0} Quizzes Attempted
              </span>
            </div>
          </motion.div>

          {courseDetails.AttemptedQuizzes === 0 ? (
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              className="text-center py-12 bg-gray-800/50 rounded-xl"
            >
              <FaPen className="text-4xl text-gray-400 mx-auto mb-4" />
              <p className="text-gray-400 text-lg">No quizzes attempted yet.</p>
              <p className="text-gray-500 mt-2">
                Take your first quiz to see your progress!
              </p>
            </motion.div>
          ) : (
            <div className="space-y-4">
              {Array.isArray(courseDetails.QuizDetails) &&
                courseDetails.QuizDetails.map((quiz, index) => (
                  <QuizSessionCard
                    key={quiz.QuizSessionID}
                    quiz={quiz}
                    isExpanded={expandedQuiz === quiz.QuizSessionID}
                    onToggle={() => handleToggleQuiz(quiz.QuizSessionID)}
                  />
                ))}
            </div>
          )}

          <motion.button
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            onClick={handleTakeQuiz}
            className="w-full bg-gradient-to-r from-blue-500 to-blue-600 text-white py-3 px-6 rounded-xl font-semibold shadow-lg hover:from-blue-600 hover:to-blue-700 transition-all duration-300"
          >
            Take New Quiz
          </motion.button>
        </div>
      )}
    </motion.div>
  );
};

export default CourseDetails;
