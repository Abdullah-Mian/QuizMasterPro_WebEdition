// src/Login.js
import React, { useState, useContext } from "react";
import { AuthContext } from "./AuthContext";

const Login = ({ onLogin }) => {
  const { setUsername, setPassword, setLoginType, setVerified } =
    useContext(AuthContext);
  const [localUsername, setLocalUsername] = useState("");
  const [localPassword, setLocalPassword] = useState("");
  const [message, setMessage] = useState("");
  const [loginType, setLocalLoginType] = useState(""); // New state for login type

  const handleSubmit = async (e) => {
    e.preventDefault();
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
        setLoginType(loginType); // Set login type in context
        setVerified(true); // Set verified to true
        onLogin(localUsername, localPassword);
      } else {
        setMessage(data.error || "Login failed");
      }
    } catch (error) {
      console.error("Error logging in:", error);
      console.log("Login failed form Login.js");
      setMessage("Login failed");
    }
  };

  return (
    <div className="flex justify-center items-center min-h-screen bg-gray-900">
      <form
        onSubmit={handleSubmit}
        className="bg-gray-800 p-8 rounded shadow-md w-full max-w-md"
      >
        <h2 className="text-2xl font-bold mb-6 text-center text-white">
          Login
        </h2>

        <div className="mb-4">
          <label htmlFor="username" className="block text-gray-300 mb-2">
            Username:
          </label>
          <input
            type="text"
            id="username"
            value={localUsername}
            onChange={(e) => {
              setLocalUsername(e.target.value);
              console.log("username:", e.target.value);
            }}
            required
            className="w-full p-2 border border-gray-600 rounded bg-gray-700 text-white"
          />
        </div>

        <div className="mb-4">
          <label htmlFor="password" className="block text-gray-300 mb-2">
            Password:
          </label>
          <input
            type="password"
            id="password"
            value={localPassword}
            onChange={(e) => {
              setLocalPassword(e.target.value);
              console.log("password:", e.target.value);
            }}
            required
            className="w-full p-2 border border-gray-600 rounded bg-gray-700 text-white"
          />
        </div>

        <div className="mb-4">
          <label className="block text-gray-300 mb-2">Login Type:</label>
          <div className="flex justify-between">
            <label className="flex items-center">
              <input
                type="radio"
                name="loginType"
                value="admin"
                checked={loginType === "admin"}
                onChange={(e) => {
                  setLocalLoginType(e.target.value);
                  console.log("loginType:", e.target.value);
                }}
                className="mr-2"
              />
              Admin
            </label>
            <label className="flex items-center">
              <input
                type="radio"
                name="loginType"
                value="student"
                checked={loginType === "student"}
                onChange={(e) => {
                  setLocalLoginType(e.target.value);
                  console.log("loginType:", e.target.value);
                }}
                className="mr-2"
              />
              Student
            </label>
          </div>
        </div>

        <button
          type="submit"
          className="w-full bg-blue-500 text-white p-2 rounded hover:bg-blue-600"
        >
          Login
        </button>

        {message && (
          <div
            className={`mt-4 p-2 rounded text-center ${
              message.includes("failed")
                ? "bg-red-100 text-red-700"
                : "bg-green-100 text-green-700"
            }`}
          >
            {message}
          </div>
        )}
      </form>
    </div>
  );
};

export default Login;
