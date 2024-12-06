// src/Navigation.js
import React from "react";
import { Link, useNavigate } from "react-router-dom";
import { AuthContext } from "./AuthContext";

const Navigation = () => {
  const { username, setUsername, setPassword, setLoginType } =
    React.useContext(AuthContext);
  const navigate = useNavigate();

  const handleLogout = () => {
    setUsername("");
    setPassword("");
    setLoginType("");
    navigate("/");
  };

  return (
    <nav className="bg-blue-500 text-white p-4 shadow-lg">
      <div className="container mx-auto flex justify-between items-center">
        <Link to="/" className="text-2xl font-bold">
          QuizMasterPro
        </Link>
        <div className="flex space-x-4">
          <Link to="/dashboard" className="hover:underline">
            Dashboard
          </Link>
          <Link to="/progress" className="hover:underline">
            Progress
          </Link>
          <Link to="/analytics" className="hover:underline">
            Analytics
          </Link>
          {username ? (
            <button
              onClick={handleLogout}
              className="bg-red-500 px-4 py-2 rounded hover:bg-red-600"
            >
              Logout
            </button>
          ) : (
            <Link
              to="/login"
              className="bg-green-500 px-4 py-2 rounded hover:bg-green-600"
            >
              Login
            </Link>
          )}
        </div>
      </div>
    </nav>
  );
};

export default Navigation;
