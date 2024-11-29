// src/App.js
import React, { useEffect, useContext, useState } from 'react';
import './App.css';
import Login from './Login';
import { AuthContext, AuthProvider } from './AuthContext';

function App() {
  const { username, password, setUsername, setPassword } = useContext(AuthContext);
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchCourses = async () => {
      if (!username || !password) return;
      setLoading(true);
      setError(null);
      
      try {
        const response = await fetch('http://localhost:3000/data', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            'x-username': username,
            'x-password': password
          }
        });
        const data = await response.json();
        if (response.ok) {
          if (Array.isArray(data)) {
            setCourses(data);
          } else if (data && typeof data === 'object' && data.recordset) {
            setCourses(data.recordset);
          }
        } else {
          setError(data.error || 'Failed to fetch data');
          console.error('Failed to fetch data:', data.error);
        }
      } catch (error) {
        setError('Error connecting to server');
        console.error('Error fetching data:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchCourses();
  }, [username, password]);

  const handleLogout = () => {
    setUsername('');
    setPassword('');
    setCourses([]);
    setError(null);
  };
  console.log('courses:', courses);
  return (
    <div className="App">
      <header className="App-header">
        <h1>Welcome to QuizMasterPro</h1>
        {!username || !password ? (
          <Login onLogin={(username, password) => {
            setUsername(username);
            setPassword(password);
          }} />
        ) : (
          <div className="dashboard">
            <div className="user-info">
              <p>Logged in as: {username}</p>
              <button onClick={handleLogout}>Logout</button>
            </div>
            
            {loading && <p>Loading...</p>}
            
            {error && (
              <div className="error-message">
                <p>Error: {error}</p>
              </div>
            )}
            
            {!loading && !error && (
              <div className="courses-list">
                <h2>Course List</h2>
                
                  
              </div>
            )}
          </div>
        )}
      </header>
    </div>
  );
}

export default function AppWrapper() {
  return (
    <AuthProvider>
      <App />
    </AuthProvider>
  );
}