// src/DegreeProgramsContext.js
import React, { createContext, useState, useEffect, useContext } from "react";
import { AuthContext } from "./AuthContext";

export const DegreeProgramsContext = createContext({
  degreePrograms: [],
  setDegreePrograms: () => {},
  courses: [],
  setCourses: () => {},
  loading: false,
  setLoading: () => {},
  error: null,
  setError: () => {},
});

export const DegreeProgramsProvider = ({ children }) => {
  const [degreePrograms, setDegreePrograms] = useState([]);
  const [courses, setCourses] = useState([]);
  const { username, password, verified } = useContext(AuthContext);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchCourses = async () => {
      console.log("fetching courses");
      try {
        const response = await fetch("http://localhost:3000/courses", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "x-username": username,
            "x-password": password,
          },
        });
        const data = await response.json();
        if (response.ok) {
          const coursesByDegree = data.reduce((acc, course) => {
            if (!acc[course.Deg_Prog]) {
              acc[course.Deg_Prog] = [];
            }
            acc[course.Deg_Prog].push(course);
            return acc;
          }, {});
          setCourses(coursesByDegree);
        } else {
          console.error("Failed to fetch courses:", data.error);
        }
      } catch (error) {
        console.error("Error fetching courses:", error);
      }
    };

    const fetchDegreePrograms = async () => {
      console.log("fetching degree programs");
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
          console.error("Failed to fetch degree programs:", data.error);
        }
      } catch (error) {
        console.error("Error fetching degree programs:", error);
      }
    };

    if (verified) {
      // fetchDegreePrograms();
      // fetchCourses();
    }
  }, [username, password, verified]);

  return (
    <DegreeProgramsContext.Provider
      value={{
        degreePrograms,
        setDegreePrograms,
        courses,
        setCourses,
        loading,
        setLoading,
        error,
        setError,
      }}
    >
      {children}
    </DegreeProgramsContext.Provider>
  );
};
