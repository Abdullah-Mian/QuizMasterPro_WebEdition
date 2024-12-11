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
    console.log("Submitting quiz:", answers);
    // try {
    //   const response = await fetch(`http://localhost:3000/submitquiz`, {
    //     method: "POST",
    //     headers: {
    //       "Content-Type": "application/json",
    //       "x-username": username,
    //       "x-password": password,
    //     },
    //     body: JSON.stringify({
    //       studentId: userData[0].StudentID,
    //       courseId: courseCode,
    //       answers,
    //     }),
    //   });
    //   const data = await response.json();
    //   if (response.ok) {
    //     alert("Quiz submitted successfully!");
    //     navigate(`/student/course/${courseId}`);
    //   } else {
    //     alert(data.error || "Failed to submit quiz");
    //   }
    // } catch (error) {
    //   alert("Error connecting to server");
    // }
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
