// src/Navigation.js
import React, { useContext } from "react";
import { Link, useNavigate } from "react-router-dom";
import { AuthContext } from "./AuthContext";

const Navigation = () => {
  const { username, setUsername, setPassword, setLoginType, setVerified } =
    React.useContext(AuthContext);
  const navigate = useNavigate();
  const { loginType } = React.useContext(AuthContext);
  const handleLogout = () => {
    setUsername("");
    setPassword("");
    setLoginType("");
    setVerified(false);
    navigate("/");
  };

  return (
    <nav className="navbar p-4 shadow-lg sticky top-0 bg-white z-50">
      <div className="container mx-auto flex justify-between items-center">
        <Link to="/" className="text-2xl font-bold">
          QuizMasterPro
        </Link>
        <div className="flex space-x-4">
          {loginType === "admin" && (
            <Link
              to="/admin/enroll"
              className="px-4 py-2 rounded text-white hover:text-[#07ada0] text-center"
              style={{ minWidth: "100px" }}
            >
              Enorll Students
            </Link>
          )}

          <Link
            to={loginType === "admin" ? "/admin" : "/student"}
            className="px-4 py-2 rounded text-white hover:text-[#07ada0] text-center"
            style={{ minWidth: "100px" }}
          >
            Dashboard
          </Link>
          <Link
            to="/progress"
            className="px-4 py-2 rounded text-white hover:text-[#07ada0] text-center"
            style={{ minWidth: "100px" }}
          >
            Progress
          </Link>
          <Link
            to="/analytics"
            className="px-4 py-2 rounded text-white hover:text-[#07ada0] text-center"
            style={{ minWidth: "100px" }}
          >
            Analytics
          </Link>
          {username ? (
            <button
              onClick={handleLogout}
              className="px-4 py-2 rounded  hover:text-[#07ada0] text-center"
              style={{ minWidth: "100px" }}
            >
              Logout
            </button>
          ) : (
            <Link
              to="/login"
              className="px-4 py-2 rounded  hover:text-[#07ada0] text-center"
              style={{ minWidth: "100px" }}
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
