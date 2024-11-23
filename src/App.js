import React, { useEffect, useState } from "react";
import "./App.css";

function App() {
  const [courses, setCourses] = useState([]);

  useEffect(() => {
    const fetchCourses = async () => {
      try {
        const response = await fetch("http://localhost:3000/COURSE");
        const data = await response.json();
        console.log("Fetched data:", data);
        if (Array.isArray(data)) {
          setCourses(data);
          console.log("Data is an array");
        } else if (data && typeof data === "object" && data.recordset) {
          setCourses(data.recordset);
          console.log("Data is an object with a recordset property");
        } else {
          console.error(
            "Fetched data is not an array or does not contain a recordset:",
            data
          );
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchCourses();
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Welcome to QuizMasterPro</h1>
        <h2>Course List</h2>
        <ul>
          {courses.map((course) => (
            <li key={course.EnrGrade}>
              <p>Student SSN: {course.StdSSN}</p>
              <p>Class: {course.StdClass}</p>
              <p>Offer No: {course.OfferNo}</p>
              <p>Grade: {course.EnrGrade}</p>
            </li>
          ))}
        </ul>
      </header>
    </div>
  );
}

export default App;
