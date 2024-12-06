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
  const { username, password, loginType, setUsername, setPassword } =
    useContext(AuthContext);
  const navigate = useNavigate();
  const [verified, setVerified] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const verifyUser = async () => {
      if (!username || !password || !loginType) return;
      setLoading(true);
      setError(null);

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
          console.log(data);
          setVerified(true);
          if (loginType === "admin") {
            navigate("/admin/dashboard");
          } else {
            navigate("/student/dashboard");
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

  return (
    <div className="App">
      <Navigation />
      <Routes>
        <Route index element={<Home />} path="/" />
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
