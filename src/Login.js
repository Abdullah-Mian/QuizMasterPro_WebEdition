// src/Login.js
import React, { useState, useContext } from 'react';
import { AuthContext } from './AuthContext';

const Login = ({ onLogin }) => {
  const { setUsername, setPassword } = useContext(AuthContext);
  const [localUsername, setLocalUsername] = useState('');
  const [localPassword, setLocalPassword] = useState('');
  const [message, setMessage] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      console.log('Logging in with:', localUsername, localPassword);
      const response = await fetch('http://localhost:3000/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username: localUsername, password: localPassword }),
      });
      const data = await response.json();
      if (response.ok) {
        setMessage(data.message);
        setUsername(localUsername);
        setPassword(localPassword);
        onLogin(localUsername, localPassword);
      } else {
        setMessage(data.error || 'Login failed');
      }
    } catch (error) {
      console.error('Error logging in:', error);
      setMessage('Login failed');
    }
  };

  return (
    <div className="login-container">
      <form onSubmit={handleSubmit} className="login-form">
        <h2>Login</h2>
        
        <div className="form-group">
          <label htmlFor="username">Username:</label>
          <input
            type="text"
            id="username"
            value={localUsername}
            onChange={(e) => {setLocalUsername(e.target.value); console.log('username:', e.target.value)}}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="password">Password:</label>
          <input
            type="password"
            id="password"
            value={localPassword}
            onChange={(e) => {setLocalPassword(e.target.value); console.log('password:', e.target.value)}}
            required
          />
        </div>

        <button type="submit" className="login-button">
          Login
        </button>

        {message && (
          <div className={`message ${message.includes('failed') ? 'error' : 'success'}`}>
            {message}
          </div>
        )}
      </form>
    </div>
  );
};

export default Login;