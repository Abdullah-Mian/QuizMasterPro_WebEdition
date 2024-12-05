// src/AuthContext.js
import React, { createContext, useState, useEffect } from "react";

export const AuthContext = createContext({
  username: "",
  setUsername: () => {},
  password: "",
  setPassword: () => {},
  loginType: "",
  setLoginType: () => {},
});

export const AuthProvider = ({ children }) => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loginType, setLoginType] = useState(""); // New state for login type

  useEffect(() => {
    console.log("Username:", username);
    console.log("Password:", password);
    console.log("Login Type:", loginType);
  }, [username, password, loginType]);

  return (
    <AuthContext.Provider
      value={{
        username,
        setUsername,
        password,
        setPassword,
        loginType,
        setLoginType,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};
