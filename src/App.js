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
          console.log(data);
          setVerified(true);
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
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1 className="text-center">Welcome to QuizMasterPro</h1>
        <div className="container-center">
          {!username || !password ? (
            <Login
              onLogin={(username, password) => {
                setUsername(username);
                setPassword(password);
              }}
            />
          ) : (
            <div className="dashboard">
              <div className="navbar bg-blue-500 text-white p-4 flex justify-between items-center">
                <p>{username}</p>
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
        </div>
      </header>
    </div>
  );
}

export default App;
