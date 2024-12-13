// src/AuthContext.js
import React, { createContext, useState, useEffect } from "react";

export const AuthContext = createContext({
  username: "",
  setUsername: () => {},
  password: "",
  setPassword: () => {},
  loginType: "",
  setLoginType: () => {},
  verified: false,
  setVerified: () => {},
  userData: null,
  setUserData: () => {},
});

export const AuthProvider = ({ children }) => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loginType, setLoginType] = useState(""); // New state for login type
  const [verified, setVerified] = useState(false);
  const [userData, setUserData] = useState(null);

  useEffect(() => {
    console.log("Username:", username);
    console.log("Password:", password);
    console.log("Login Type:", loginType);
    console.log("Verified:", verified);
  }, [username, password, loginType, verified, userData]);

  return (
    <AuthContext.Provider
      value={{
        username,
        setUsername,
        password,
        setPassword,
        loginType,
        setLoginType,
        verified,
        setVerified,
        userData,
        setUserData,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};
