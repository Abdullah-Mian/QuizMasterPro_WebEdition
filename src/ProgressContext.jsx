// src/components/ProgressContext.jsx
import React, { createContext, useState, useEffect, useContext } from "react";
import { AuthContext } from "./components/AuthContext";

export const ProgressContext = createContext({
  progressData: [],
  setProgressData: () => {},
});

export const ProgressProvider = ({ children }) => {
  const { username, password, userData, loginType } = useContext(AuthContext);
  const [progressData, setProgressData] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchProgressData = async () => {
      setLoading(true);
      setError(null);

      try {
        const response = await fetch(
          `http://localhost:3000/progress?studentId=${userData[0].StudentID}`,
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
          setProgressData(data);
        } else {
          setError(data.error || "Failed to fetch progress data");
        }
      } catch (error) {
        setError("Error connecting to server");
      } finally {
        setLoading(false);
      }
    };
    if (loginType === "student") {
      // fetchProgressData();
    }
  }, [username, password, userData]);

  return (
    <ProgressContext.Provider
      value={{
        progressData,
        setProgressData,
        loading,
        error,
      }}
    >
      {children}
    </ProgressContext.Provider>
  );
};
