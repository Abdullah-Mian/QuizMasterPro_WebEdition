import React, { createContext, useState, useEffect } from "react";

export const AuthContext = createContext({
  username: "",
  setUsername: () => {},
  password: "",
  setPassword: () => {},
});

export const AuthProvider = ({ children }) => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  useEffect(() => {
    console.log("Username:", username);
    console.log("Password:", password);
  }, [username, password]);

  return (
    <AuthContext.Provider value={{ username, setUsername, password, setPassword }}>
      {children}
    </AuthContext.Provider>
  );
};