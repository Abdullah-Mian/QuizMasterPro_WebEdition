// src/CourseDetails.jsx
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "./components/AuthContext";
import { useParams, useNavigate } from "react-router-dom";

const CourseDetails = () => {
  const { username, password, userData } = useContext(AuthContext);
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [courseDetails, setCourseDetails] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [expandedQuiz, setExpandedQuiz] = useState(null);

  useEffect(() => {
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
  }, [username, password, userData, courseId]);

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

  console.log("Course Details:", courseDetails);
  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4 text-center">Course Details</h2>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      {courseDetails && (
        <div>
          <h3 className="text-xl font-bold">
            {courseDetails.Course_Name} {courseDetails.Course_Code}
          </h3>
          <h4 className="text-lg font-bold mt-4">
            Attempted Quizzes #{courseDetails.AttemptedQuizzes || 0}
          </h4>
          <div className="space-y-2">
            {Array.isArray(courseDetails.QuizDetails) &&
              courseDetails.QuizDetails.map((quiz, index) => (
                <div
                  key={index}
                  className="border-t border-b border-gray-300 rounded-lg p-4 bg-gray-800 text-white"
                >
                  <div
                    className="flex justify-between items-center cursor-pointer"
                    onClick={() => handleToggleQuiz(quiz.QuizSessionID)}
                  >
                    <span>Quiz ID: {quiz.QuizSessionID}</span>
                    <span>
                      Score: {quiz.ObtainedMarks}/{quiz.QuizTotalScore} (
                      {quiz.ProgressPercentage}%)
                    </span>
                    <span>
                      {expandedQuiz === quiz.QuizSessionID ? "▲" : "▼"}
                    </span>
                  </div>
                  {expandedQuiz === quiz.QuizSessionID && (
                    <div className="mt-4 space-y-2">
                      <p>Scholastic Status: {quiz.ScholasticStatus}</p>
                      {quiz.Questions.map((question, qIndex) => (
                        <div
                          key={qIndex}
                          className="pl-4 border-t border-b border-gray-300 rounded-lg p-4 bg-gray-700 text-white"
                        >
                          <p>Question: {question.Question_String}</p>
                          <p>Correct Answer: {question.Actual_Answer}</p>
                          <p>Your Answer: {question.Student_Answer}</p>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              ))}
          </div>
          <button
            onClick={handleTakeQuiz}
            className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 mt-4"
          >
            Take Quiz
          </button>
        </div>
      )}
    </div>
  );
};

export default CourseDetails;
