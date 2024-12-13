import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "../Contexts/AuthContext";
import { DegreeProgramsContext } from "../Contexts/DegreeProgramsContext";
import { useParams, useNavigate } from "react-router-dom";
import { QuestionsProvider, useQuestions } from "../Contexts/QuestionsContext";
import { motion, AnimatePresence } from "framer-motion";
import {
  FaClock,
  FaCheckCircle,
  FaQuestion,
  FaExclamationTriangle,
} from "react-icons/fa";

const QuestionCard = ({
  question,
  index,
  totalQuestions,
  answer,
  onAnswerChange,
}) => (
  <motion.div
    initial={{ opacity: 0, y: 20 }}
    animate={{ opacity: 1, y: 0 }}
    className="bg-gradient-to-br from-gray-800 to-gray-900 rounded-xl p-6 shadow-lg mb-6"
  >
    <div className="flex items-center justify-between mb-4">
      <span className="bg-blue-500/20 text-blue-400 px-3 py-1 rounded-full text-sm">
        Question {index + 1} of {totalQuestions}
      </span>
      <span className="text-gray-400">
        <FaQuestion className="inline mr-2" />
        {question.Course_Code}
      </span>
    </div>

    <h3 className="text-xl font-semibold text-white mb-6">
      {question.Question_String}
    </h3>

    <div className="space-y-3">
      {question.Options.map((option) => (
        <motion.label
          key={option.OptionID}
          whileHover={{ scale: 1.02 }}
          whileTap={{ scale: 0.98 }}
          className={`block cursor-pointer ${
            answer === option.OptionID
              ? "bg-blue-500/20 border-blue-500"
              : "bg-gray-700/50 border-gray-600"
          } border-2 rounded-lg p-4 transition-all duration-300`}
        >
          <div className="flex items-center">
            <input
              type="checkbox"
              checked={answer === option.OptionID}
              onChange={() =>
                onAnswerChange(question.QuestionID, option.OptionID)
              }
              className="hidden"
            />
            <div
              className={`w-5 h-5 rounded-full border-2 mr-3 flex items-center justify-center ${
                answer === option.OptionID
                  ? "border-blue-500 bg-blue-500"
                  : "border-gray-400"
              }`}
            >
              {answer === option.OptionID && (
                <FaCheckCircle className="text-white text-sm" />
              )}
            </div>
            <span className="text-white">{option.Option_String}</span>
          </div>
        </motion.label>
      ))}
    </div>
  </motion.div>
);

const TakeQuiz = () => {
  const { username, password, userData } = useContext(AuthContext);
  const { courses } = useContext(DegreeProgramsContext);
  const { courseId } = useParams();
  const navigate = useNavigate();
  const { questions, setQuestions, newFetched, setNewFetched } = useQuestions();
  const [answers, setAnswers] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [startTime, setStartTime] = useState(null);

  // Find the course code from the courses context
  const course = courses.find(
    (course) => course.Course_id === parseInt(courseId)
  );
  const courseCode = course ? course.Course_Code : null;

  useEffect(() => {
    const fetchQuestions = async () => {
      if (!courseCode) {
        setError("Course not found");
        return;
      }
      setLoading(true);
      setError(null);
      try {
        const response = await fetch(
          `http://localhost:3000/randomquizzes?courseId=${courseCode}&limit=10`,
          {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              "x-username": username,
              "x-password": password,
              "x-studentid": userData[0].StudentID,
            },
          }
        );
        const data = await response.json();
        if (response.ok) {
          setQuestions(data);
          setNewFetched(true);
          setAnswers({});
          setStartTime(new Date()); // Note the start time
        } else {
          setError(data.error || "Failed to fetch questions");
        }
      } catch (error) {
        setError("Error connecting to server");
      } finally {
        setLoading(false);
      }
    };

    if (questions.length === 0 && newFetched === false) {
      fetchQuestions();
    }
  }, [courseCode]);

  const handleOptionChange = (questionId, optionId) => {
    setAnswers((prevAnswers) => ({
      ...prevAnswers,
      [questionId]: optionId,
    }));
  };

  const handleSubmit = async () => {
    if (Object.keys(answers).length !== questions.length) {
      alert("Please answer all questions before submitting.");
      return;
    }

    const endTime = new Date(); // Note the end time
    const totalMarks = questions.length;
    let obtainedMarks = 0;

    // Fetch correct answers from Answer_Key
    const correctAnswers = await fetchCorrectAnswers();

    // Calculate obtained marks
    questions.forEach((question) => {
      const correctOptionId = correctAnswers[question.QuestionID];
      if (answers[question.QuestionID] === correctOptionId) {
        obtainedMarks += 1;
      }
    });

    const progressPercentage = (obtainedMarks / totalMarks) * 100;
    const scholasticStatus = progressPercentage >= 60 ? "Pass" : "Fail";

    // Insert into Quiz_Session
    const quizSessionId = await insertQuizSession(
      userData[0].StudentID,
      course.Course_id,
      startTime,
      endTime,
      totalMarks,
      obtainedMarks,
      progressPercentage,
      scholasticStatus
    );
    // Insert into Attempted_Quiz
    const confirmationMessage = await insertAttemptedQuiz(
      quizSessionId,
      questions,
      answers,
      correctAnswers
    );

    console.log("confirmationMessage:", confirmationMessage.message);
    // Reset questions context
    setQuestions([]);
    setNewFetched(false);
    // Show confirmation message
    if (confirmationMessage.message) {
      alert("Quiz submitted successfully!");
    } else {
      alert("Quiz submission failed!");
    }
    // Redirect to course page
    navigate(`/student/course/${courseId}`);
  };

  const fetchCorrectAnswers = async () => {
    const response = await fetch(`http://localhost:3000/correctanswers`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-username": username,
        "x-password": password,
      },
      body: JSON.stringify({
        questionIds: questions.map((q) => q.QuestionID),
      }),
    });
    const data = await response.json();
    return data.correctAnswers;
  };

  const insertQuizSession = async (
    studentId,
    courseId,
    startTime,
    endTime,
    totalMarks,
    obtainedMarks,
    progressPercentage,
    scholasticStatus
  ) => {
    const response = await fetch(`http://localhost:3000/insertquizsession`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-username": username,
        "x-password": password,
      },
      body: JSON.stringify({
        studentId,
        courseId,
        startTime,
        endTime,
        totalMarks,
        obtainedMarks,
        progressPercentage,
        scholasticStatus,
      }),
    });
    const data = await response.json();
    return data.quizSessionId;
  };

  const insertAttemptedQuiz = async (
    quizSessionId,
    questions,
    answers,
    correctAnswers
  ) => {
    const response = await fetch(`http://localhost:3000/insertattemptedquiz`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-username": username,
        "x-password": password,
      },
      body: JSON.stringify({
        quizSessionId,
        questionString1: questions[0].Question_String,
        studentAnswer1: answers[questions[0].QuestionID]?.toString() || "",
        correctAnswer1:
          correctAnswers[questions[0].QuestionID]?.toString() || "",
        questionString2: questions[1].Question_String,
        studentAnswer2: answers[questions[1].QuestionID]?.toString() || "",
        correctAnswer2:
          correctAnswers[questions[1].QuestionID]?.toString() || "",
        questionString3: questions[2].Question_String,
        studentAnswer3: answers[questions[2].QuestionID]?.toString() || "",
        correctAnswer3:
          correctAnswers[questions[2].QuestionID]?.toString() || "",
        questionString4: questions[3].Question_String,
        studentAnswer4: answers[questions[3].QuestionID]?.toString() || "",
        correctAnswer4:
          correctAnswers[questions[3].QuestionID]?.toString() || "",
        questionString5: questions[4].Question_String,
        studentAnswer5: answers[questions[4].QuestionID]?.toString() || "",
        correctAnswer5:
          correctAnswers[questions[4].QuestionID]?.toString() || "",
        questionString6: questions[5].Question_String,
        studentAnswer6: answers[questions[5].QuestionID]?.toString() || "",
        correctAnswer6:
          correctAnswers[questions[5].QuestionID]?.toString() || "",
        questionString7: questions[6].Question_String,
        studentAnswer7: answers[questions[6].QuestionID]?.toString() || "",
        correctAnswer7:
          correctAnswers[questions[6].QuestionID]?.toString() || "",
        questionString8: questions[7].Question_String,
        studentAnswer8: answers[questions[7].QuestionID]?.toString() || "",
        correctAnswer8:
          correctAnswers[questions[7].QuestionID]?.toString() || "",
        questionString9: questions[8].Question_String,
        studentAnswer9: answers[questions[8].QuestionID]?.toString() || "",
        correctAnswer9:
          correctAnswers[questions[8].QuestionID]?.toString() || "",
        questionString10: questions[9].Question_String,
        studentAnswer10: answers[questions[9].QuestionID]?.toString() || "",
        correctAnswer10:
          correctAnswers[questions[9].QuestionID]?.toString() || "",
      }),
    });
    const data = await response.json();
    return data;
  };
  console.log("Questions", questions);
  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="min-h-screen bg-gradient-to-b from-gray-900 via-gray-800 to-gray-900 p-6"
    >
      <div className="max-w-4xl mx-auto">
        {loading && (
          <div className="flex justify-center items-center h-64">
            <div className="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-blue-500"></div>
          </div>
        )}

        {error && (
          <motion.div
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            className="bg-red-500/20 border border-red-500 text-red-500 p-4 rounded-lg mb-6"
          >
            <FaExclamationTriangle className="inline mr-2" />
            {error}
          </motion.div>
        )}

        {!loading && !error && newFetched && questions.length > 0 && (
          <div>
            <motion.div
              initial={{ y: -20 }}
              animate={{ y: 0 }}
              className="bg-gradient-to-br from-blue-600 to-blue-800 rounded-xl p-6 text-white shadow-xl mb-6"
            >
              <h2 className="text-2xl font-bold mb-2">
                {course?.Course_Name} Quiz
              </h2>
              <div className="flex items-center space-x-4">
                <span className="px-3 py-1 bg-blue-500/20 rounded-full text-sm">
                  {course?.Course_Code}
                </span>
                <span className="flex items-center">
                  <FaClock className="mr-2" />
                  {startTime && (
                    <span>
                      Started at {new Date(startTime).toLocaleTimeString()}
                    </span>
                  )}
                </span>
              </div>
            </motion.div>

            <div className="space-y-6">
              {questions.map((question, index) => (
                <QuestionCard
                  key={question.QuestionID}
                  question={question}
                  index={index}
                  totalQuestions={questions.length}
                  answer={answers[question.QuestionID]}
                  onAnswerChange={handleOptionChange}
                />
              ))}
            </div>

            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={handleSubmit}
              className="w-full bg-gradient-to-r from-blue-500 to-blue-600 text-white py-3 px-6 rounded-xl font-semibold shadow-lg hover:from-blue-600 hover:to-blue-700 transition-all duration-300 mt-6"
            >
              Submit Quiz
            </motion.button>
          </div>
        )}
      </div>
    </motion.div>
  );
};

const TakeQuizWithProvider = () => (
  <QuestionsProvider>
    <TakeQuiz />
  </QuestionsProvider>
);

export default TakeQuizWithProvider;
