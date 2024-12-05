import React, { useEffect, useContext, useState } from "react";
import "./App.css";
import Login from "./Login";
import { AuthContext } from "./AuthContext";
import StudentDashboard from "./StudentDashboard";
import AdminDashboard from "./AdminDashboard";

function App() {
  const { username, password, loginType, setUsername, setPassword } =
    useContext(AuthContext);
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
          setVerified(true);
        } else {
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
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Welcome to QuizMasterPro</h1>
        {!username || !password ? (
          <Login
            onLogin={(username, password) => {
              setUsername(username);
              setPassword(password);
            }}
          />
        ) : (
          <div className="dashboard">
            <div className="user-info">
              <p>Logged in as: {username}</p>
              <button
                onClick={handleLogout}
                className="bg-red-500 text-white p-2 rounded hover:bg-red-600"
              >
                Logout
              </button>
            </div>

            {loading && <p>Loading...</p>}

            {error && (
              <div className="error-message">
                <p>Error: {error}</p>
              </div>
            )}

            {!loading && !error && verified && (
              <>
                {loginType === "admin" ? (
                  <AdminDashboard />
                ) : (
                  <StudentDashboard />
                )}
              </>
            )}
          </div>
        )}
      </header>
    </div>
  );
}

export default App;
