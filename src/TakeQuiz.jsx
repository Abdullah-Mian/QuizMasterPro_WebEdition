// src/TakeQuiz.jsx
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "./components/AuthContext";
import { DegreeProgramsContext } from "./components/DegreeProgramsContext";
import { useParams, useNavigate } from "react-router-dom";

const TakeQuiz = () => {
  const { username, password, userData } = useContext(AuthContext);
  const { courses } = useContext(DegreeProgramsContext);
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [questions, setQuestions] = useState([]);
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

    fetchQuestions();
  }, [username, password, courseCode, userData]);

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
    await insertAttemptedQuiz(
      quizSessionId,
      questions,
      answers,
      correctAnswers
    );

    alert("Quiz submitted successfully!");
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
        questions,
        answers,
        correctAnswers,
      }),
    });
    const data = await response.json();
    return data.message;
  };

  console.log("Questions:", questions);
  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Take Quiz</h2>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      {!loading && !error && questions.length > 0 && (
        <div>
          {questions.map((question, index) => (
            <div key={question.QuestionID} className="mb-4">
              <p className="text-lg font-bold">
                {index + 1}. {question.Question_String}
              </p>
              {question.Options.map((option) => (
                <div key={option.OptionID} className="flex items-center mb-2">
                  <input
                    type="checkbox"
                    id={`option-${option.OptionID}`}
                    checked={answers[question.QuestionID] === option.OptionID}
                    onChange={(e) => {
                      handleOptionChange(question.QuestionID, option.OptionID);
                      console.log(question, e.target.id);
                    }}
                    className="mr-2"
                  />
                  <label htmlFor={`option-${option.OptionID}`}>
                    {option.Option_String}
                  </label>
                </div>
              ))}
            </div>
          ))}
          <button
            onClick={handleSubmit}
            className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 mt-4"
          >
            Submit
          </button>
        </div>
      )}
    </div>
  );
};

export default TakeQuiz;
