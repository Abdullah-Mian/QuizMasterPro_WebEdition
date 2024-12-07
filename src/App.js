import React, { useEffect, useContext, useState } from "react";
import "./App.css";
import { Routes, Route, Navigate, useNavigate } from "react-router-dom";
import Login from "./Login";
import Home from "./Home";
import Navigation from "./Navigation";
import { AuthContext } from "./AuthContext";
import StudentDashboard from "./StudentDashboard";
import AdminDashboard from "./AdminDashboard";

function App() {
  const {
    username,
    password,
    loginType,
    setUsername,
    setPassword,
    verified,
    setVerified,
    setUserData,
  } = useContext(AuthContext);
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const verifyUser = async () => {
      if (!username || !password || !loginType) return;
      setLoading(true);
      setError(null);
      console.log("fetching data from app.js");
      try {
        const response = await fetch(`http://localhost:3000/userverification`, {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "x-username": username,
            "x-password": password,
            "x-logintype": loginType,
          },
        });
        const data = await response.json();
        if (response.ok) {
          console.log("Verification data:", data); // Log the entire response
          setUserData(data.data); // Ensure you are setting the correct part of the response
          setVerified(true);
          if (loginType === "admin") {
            navigate("/admin");
          } else {
            navigate("/student");
          }
        } else {
          console.log(data);
          setError(data.error || "Failed to verify user");
          console.error("Failed to verify user:", data.error);
          handleLogout();
        }
      } catch (error) {
        setError("Error connecting to server");
        console.error("Error verifying user:", error);
        handleLogout();
      } finally {
        setLoading(false);
      }
    };

    verifyUser();
  }, [username, password, loginType]);

  const handleLogout = () => {
    setUsername("");
    setPassword("");
    setVerified(false);
    setError(null);
    navigate("/");
  };
  console.log("from app.js Verified:", verified);
  console.log("from app.js loginType:", loginType);
  return (
    <div className="App">
      <Navigation />
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      <Routes>
        <Route path="/" element={<Home />} />
        <Route
          path="/login"
          element={
            <Login
              onLogin={(username, password) => {
                setUsername(username);
                setPassword(password);
              }}
            />
          }
        />
        <Route
          path="/admin/*"
          element={
            verified && loginType === "admin" ? (
              <AdminDashboard />
            ) : (
              <Navigate to="/login" />
            )
          }
        />
        <Route
          path="/student/*"
          element={
            verified && loginType === "student" ? (
              <StudentDashboard />
            ) : (
              <Navigate to="/login" />
            )
          }
        />
      </Routes>
    </div>
  );
}

export default App;
