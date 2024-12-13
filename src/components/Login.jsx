// src/Login.js
import React, { useState, useContext } from "react";
import { AuthContext } from "./AuthContext";
import { motion } from "framer-motion";
import { FaUser, FaLock, FaUserGraduate, FaUserShield } from "react-icons/fa";

const Login = ({ onLogin }) => {
  const { setUsername, setPassword, setLoginType, setVerified } =
    useContext(AuthContext);
  const [localUsername, setLocalUsername] = useState("");
  const [localPassword, setLocalPassword] = useState("");
  const [message, setMessage] = useState("");
  const [loginType, setLocalLoginType] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    try {
      console.log("Logging in with:", localUsername, localPassword);
      console.log("gonna post to http://localhost:3000/login");
      const response = await fetch("http://localhost:3000/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          username: localUsername,
          password: localPassword,
        }),
      });
      const data = await response.json();
      if (response.ok) {
        setMessage(data.message);
        setUsername(localUsername);
        setPassword(localPassword);
        setLoginType(loginType);
        setVerified(true);
        onLogin(localUsername, localPassword);
      } else {
        setMessage(data.error || "Login failed");
      }
    } catch (error) {
      console.error("Error logging in:", error);
      console.log("Login failed form Login.js");
      setMessage("Login failed");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 py-12 px-4 sm:px-6 lg:px-8">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="max-w-md w-full space-y-8"
      >
        <div>
          <motion.h2
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="mt-6 text-center text-3xl font-extrabold text-white"
          >
            Welcome to QuizMasterPro
          </motion.h2>
          <p className="mt-2 text-center text-sm text-gray-400">
            Please sign in to your account
          </p>
        </div>
        <motion.form
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.3 }}
          onSubmit={handleSubmit}
          className="mt-8 space-y-6 bg-gray-800 p-8 rounded-xl shadow-2xl"
        >
          <div className="rounded-md shadow-sm -space-y-px">
            <div className="mb-6">
              <label
                htmlFor="username"
                className="block text-gray-300 text-sm font-medium mb-2"
              >
                Username
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FaUser className="h-5 w-5 text-gray-400" />
                </div>
                <input
                  type="text"
                  id="username"
                  value={localUsername}
                  onChange={(e) => {
                    setLocalUsername(e.target.value);
                    console.log("username:", e.target.value);
                  }}
                  required
                  className="block w-full pl-10 pr-3 py-2 border border-gray-600 rounded-md bg-gray-700 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  placeholder="Enter your username"
                />
              </div>
            </div>
            <div className="mb-6">
              <label
                htmlFor="password"
                className="block text-gray-300 text-sm font-medium mb-2"
              >
                Password
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FaLock className="h-5 w-5 text-gray-400" />
                </div>
                <input
                  type="password"
                  id="password"
                  value={localPassword}
                  onChange={(e) => {
                    setLocalPassword(e.target.value);
                    console.log("password:", e.target.value);
                  }}
                  required
                  className="block w-full pl-10 pr-3 py-2 border border-gray-600 rounded-md bg-gray-700 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  placeholder="Enter your password"
                />
              </div>
            </div>
          </div>

          <div className="mb-6">
            <label className="block text-gray-300 text-sm font-medium mb-4">
              Select Account Type
            </label>
            <div className="grid grid-cols-2 gap-4">
              <motion.label
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className={`flex items-center justify-center p-4 rounded-lg cursor-pointer transition-all ${
                  loginType === "admin"
                    ? "bg-blue-600 border-blue-500"
                    : "bg-gray-700 border-gray-600"
                } border-2`}
              >
                <input
                  type="radio"
                  name="loginType"
                  value="admin"
                  checked={loginType === "admin"}
                  onChange={(e) => {
                    setLocalLoginType(e.target.value);
                    console.log("loginType:", e.target.value);
                  }}
                  className="hidden"
                />
                <FaUserShield className="h-6 w-6 mr-2 text-white" />
                <span className="text-white font-medium">Admin</span>
              </motion.label>
              <motion.label
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className={`flex items-center justify-center p-4 rounded-lg cursor-pointer transition-all ${
                  loginType === "student"
                    ? "bg-blue-600 border-blue-500"
                    : "bg-gray-700 border-gray-600"
                } border-2`}
              >
                <input
                  type="radio"
                  name="loginType"
                  value="student"
                  checked={loginType === "student"}
                  onChange={(e) => {
                    setLocalLoginType(e.target.value);
                    console.log("loginType:", e.target.value);
                  }}
                  className="hidden"
                />
                <FaUserGraduate className="h-6 w-6 mr-2 text-white" />
                <span className="text-white font-medium">Student</span>
              </motion.label>
            </div>
          </div>

          <motion.button
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
            type="submit"
            disabled={isLoading}
            className={`w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 ${
              isLoading ? "opacity-75 cursor-not-allowed" : ""
            }`}
          >
            {isLoading ? (
              <svg
                className="animate-spin h-5 w-5 text-white"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
              >
                <circle
                  className="opacity-25"
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  strokeWidth="4"
                ></circle>
                <path
                  className="opacity-75"
                  fill="currentColor"
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                ></path>
              </svg>
            ) : (
              "Sign in"
            )}
          </motion.button>

          {message && (
            <motion.div
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              className={`mt-4 p-3 rounded-md text-center ${
                message.includes("failed")
                  ? "bg-red-100 text-red-700 border border-red-200"
                  : "bg-green-100 text-green-700 border border-green-200"
              }`}
            >
              {message}
            </motion.div>
          )}
        </motion.form>
      </motion.div>
    </div>
  );
};

export default Login;
